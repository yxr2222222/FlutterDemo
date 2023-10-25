import 'dart:convert';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:flutter_demo/base/http/cache/CacheStrategy.dart';
import 'package:flutter_demo/base/http/cache/HttpCacheObj.dart';
import 'package:flutter_demo/base/util/Log.dart';
import 'package:sqflite/sqflite.dart';

class CacheManager {
  static final CacheManager _instance = CacheManager._internal();

  static Database? _database;

  /// 私有的命名构造函数
  CacheManager._internal() {
    openDatabase("basic_http_cache.db", version: 1,
        onCreate: (Database db, int version) {
      // 创建缓存表
      db.execute(
          "CREATE TABLE IF NOT EXISTS HttpCacheObj(cacheKey TEXT PRIMARY KEY, cacheValue TEXT NOT NULL, expireTime INTEGER NOT NULL, updateTime INTEGER NOT NULL)");

      // 删除过期数据
      db.execute(
          "DELETE FROM HttpCacheObj WHERE expireTime <= ${DateTime.now().millisecondsSinceEpoch}");
    }).then((db) => () {
          _database = db;
        });
  }

  static CacheManager getInstance() {
    return _instance;
  }

  /// 根据请求获取缓存
  Future<HttpCacheObj?>? getCacheWithReq(RequestOptions options) async {
    var cacheKey = getCacheKeyWithReq(options);
    return cacheKey == null ? null : getCache(cacheKey);
  }

  /// 根据返回结果保存缓存
  Future<void> putCacheWithResp(Response response, int defaultCacheTime) async {
    try {
      var cacheKey = getCacheKeyWithReq(response.requestOptions);
      if (cacheKey != null) {
        _database?.transaction((txn) async {
          // 先删除老的缓存
          await _database?.delete("HttpCacheObj",
              where: "cacheKey = ?", whereArgs: [cacheKey]);

          // 获取response bytes 数据
          List<int>? data;
          if (response.requestOptions.responseType == ResponseType.bytes) {
            data = response.data;
          } else {
            data = utf8.encode(jsonEncode(response.data));
          }

          if (data != null) {
            // bytes转String并保存
            Uint8List bytes = Uint8List.fromList(data);
            String cacheValue = utf8.decode(bytes);

            int cacheTime =
                response.requestOptions.extra[CacheStrategy.CACHE_TIME] ??
                    defaultCacheTime;
            int expireTime = DateTime.now().millisecondsSinceEpoch + cacheTime;

            var cache = HttpCacheObj(cacheKey, cacheValue, expireTime);
            await _database?.insert("HttpCacheObj", cache.toJson());
          }
        });
      }
    } catch (e) {
      Log.d("Http request cache error!", error: e);
    }
  }

  /// 获取缓存
  Future<HttpCacheObj?>? getCache(String cacheKey) async {
    var map = await _database
        ?.query("HttpCacheObj", where: "cacheKey = ?", whereArgs: [cacheKey]);
    var cache = map?.first;
    if (cache != null) {
      try {
        return jsonDecode(jsonEncode(cache));
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// 根据请求参数缓存缓存Key
  String? getCacheKeyWithReq(RequestOptions options) {
    String? customCacheKey = options.extra[CacheStrategy.CUSTOM_CACHE_KEY];
    return getCacheKey(customCacheKey, options);
  }

  /// 获取缓存Key，customCacheKey和options必须有一个不为空，否则返回null
  String? getCacheKey(String? customCacheKey, RequestOptions? options) {
    if (customCacheKey != null) {
      return md5.convert(utf8.encode(customCacheKey)).toString();
    }
    if (options == null) {
      return null;
    }

    String path = options.uri.toString();
    customCacheKey = options.extra[CacheStrategy.CUSTOM_CACHE_KEY];
    StringBuffer stringBuffer = StringBuffer(path);

    options.queryParameters.forEach((key, value) {
      stringBuffer.write("_");
      stringBuffer.write(key);
      stringBuffer.write("_");
      stringBuffer.write(value);
    });

    var body = options.data;
    if (body != null) {
      stringBuffer.write("_");
      stringBuffer.write(
          md5.convert(utf8.encode(jsonEncode(body).toString())).toString());
    }
    return md5.convert(utf8.encode(stringBuffer.toString())).toString();
  }
}