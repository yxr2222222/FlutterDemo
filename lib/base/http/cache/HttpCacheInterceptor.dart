import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_demo/base/http/cache/CacheConfig.dart';
import 'package:flutter_demo/base/http/cache/CacheManager.dart';
import 'package:flutter_demo/base/http/cache/CacheMode.dart';
import 'package:flutter_demo/base/http/cache/CacheStrategy.dart';
import 'package:flutter_demo/base/http/cache/HttpCacheObj.dart';

/// 网络缓存拦截器
class HttpCacheInterceptor extends Interceptor {
  final CacheConfig cacheConfig;

  const HttpCacheInterceptor(this.cacheConfig);

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    // 因为使用的是sqflite本地存储方式，暂不支持web等其他版本
    if (!Platform.isIOS && !Platform.isAndroid) {
      return super.onRequest(options, handler);
    }

    // 获取缓存模式
    CacheMode cacheMode = _getCacheMode(options);
    if (CacheMode.ONLY_NETWORK == cacheMode ||
        CacheMode.NETWORK_PUT_READ_CACHE == cacheMode) {
      // 如果缓存模式是只走网络和优先走网络则正常发起请求
      return super.onRequest(options, handler);
    }

    if (CacheMode.READ_CACHE_NETWORK_PUT == cacheMode) {
      // 如果缓存模式是优先缓存，则先校验缓存
      var cache = await CacheManager.getInstance().getCacheWithReq(options);
      if (cache == null ||
          cache.expireTime <= DateTime.now().millisecondsSinceEpoch) {
        // 如果没有缓存或者缓存过期了
        return super.onRequest(options, handler);
      }
      return handler.resolve(_buildResponse(cache, options), true);
    }
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    // 因为使用的是sqflite本地存储方式，暂不支持web等其他版本
    if (!Platform.isIOS && !Platform.isAndroid) {
      return super.onResponse(response, handler);
    }

    var options = response.requestOptions;

    // 获取缓存模式
    CacheMode cacheMode = _getCacheMode(options);
    if (CacheMode.ONLY_NETWORK == cacheMode) {
      // 如果缓存模式是只走网络则不保存缓存
      return super.onResponse(response, handler);
    }

    // 如果缓存模式是优先缓存，则先校验缓存
    await CacheManager.getInstance()
        .putCacheWithResp(response, cacheConfig.defaultCacheTime);
    return super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    // 因为使用的是sqflite本地存储方式，暂不支持web等其他版本
    if (!Platform.isIOS && !Platform.isAndroid) {
      return super.onError(err, handler);
    }

    var options = err.requestOptions;
    // 获取缓存模式
    CacheMode cacheMode = _getCacheMode(options);
    if (CacheMode.NETWORK_PUT_READ_CACHE == cacheMode) {
      // 如果缓存模式是优先网络则尝试获取缓存
      // 如果缓存模式是优先缓存，则先校验缓存
      var cache = await CacheManager.getInstance().getCacheWithReq(options);
      if (cache == null ||
          cache.expireTime <= DateTime.now().millisecondsSinceEpoch) {
        // 如果没有缓存或者缓存过期了
        return super.onError(err, handler);
      }
      return handler.resolve(_buildResponse(cache, options));
    }
    return super.onError(err, handler);
  }

  Response _buildResponse(HttpCacheObj obj, RequestOptions options) {
    return Response(
        data: obj, requestOptions: options.copyWith(), statusCode: 200);
  }

  CacheMode _getCacheMode(RequestOptions options) {
    return options.extra[CacheStrategy.CACHE_MODE] ?? cacheConfig.defaultCacheMode;
  }
}
