import 'dart:convert';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter_demo/base/http/cache/CacheMode.dart';
import 'package:flutter_demo/base/http/cache/CacheStrategy.dart';
import 'package:flutter_demo/base/http/interceptor/LoggingInterceptor.dart';
import 'package:flutter_demo/base/http/cache/HttpCacheInterceptor.dart';
import 'package:flutter_demo/base/http/interceptor/RequestInterceptor.dart';
import 'package:flutter_demo/base/util/Log.dart';

import '../model/BaseResp.dart';
import 'cache/CacheConfig.dart';
import 'exception/CstHttpException.dart';
import 'model/BaseRespConfig.dart';
import 'model/ReqType.dart';

class HttpManager {
  static final HttpManager _instance = HttpManager._internal();
  static late final Dio _dio;

  final Map<String, dynamic> _publicHeaders = {
    "Access-Control-Allow-Origin": "*",
    "Content-type": "application/json"
  };
  final Map<String, dynamic> _publicQueryParams = {};

  late BaseRespConfig _respConfig;
  late bool _debug;

  bool get debug => _debug;

  /// 私有的命名构造函数
  HttpManager._internal() {
    BaseOptions options = BaseOptions();
    _dio = Dio(options);
  }

  static HttpManager getInstance() {
    return _instance;
  }

  /// 初始化
  void init(String baseUrl, bool debug, BaseRespConfig respConfig,
      [int connectTimeout = 15000,
      int receiveTimeout = 15000,
      Map<String, dynamic>? publicHeaders,
      Map<String, dynamic>? publicQueryParams,
      CacheConfig? cacheConfig,
      List<Interceptor>? interceptors]) {
    _debug = debug;
    _respConfig = respConfig;
    publicHeaders?.forEach((key, value) {
      _publicHeaders[key] = value;
    });

    publicQueryParams?.forEach((key, value) {
      _publicQueryParams[key] = value;
    });

    _dio.options = _dio.options.copyWith(
      baseUrl: baseUrl,
      connectTimeout: Duration(milliseconds: connectTimeout),
      receiveTimeout: Duration(milliseconds: receiveTimeout),
      headers: _publicHeaders,
    );

    // 添加请求拦截器
    _dio.interceptors
        .add(RequestInterceptor(_publicHeaders, _publicQueryParams));

    if (debug) {
      // 如果是调试模式，添加日志拦截器
      _dio.interceptors.add(LoggingInterceptor());
    }

    // 添加拦截器
    interceptors?.forEach((interceptor) {
      _dio.interceptors.add(interceptor);
    });

    if (cacheConfig != null) {
      // 如果有缓存配置
      _dio.interceptors.add(HttpCacheInterceptor(cacheConfig));
    }
  }

  /// 清空当前请求头
  void clearPublicHeader() {
    _publicHeaders.clear();
  }

  /// 设置请求头
  void setPublicHeader(String key, String value) {
    _publicHeaders[key] = value;
  }

  /// 批量设置请求头
  void setPublicHeaders(Map<String, String> headers) {
    headers.forEach((key, value) {
      _publicHeaders[key] = value;
    });
  }

  /// 清空公共请求参数
  void clearPublicQueryParams() {
    _publicQueryParams.clear();
  }

  /// 设置公共请求参数
  void setPublicQueryParam(String key, String value) {
    _publicQueryParams[key] = value;
  }

  /// 批量设置公共请求参数
  void setPublicQueryParams(Map<String, String> params) {
    params.forEach((key, value) {
      _publicQueryParams[key] = value;
    });
  }

  BaseRespConfig getRespConfig() {
    return _respConfig;
  }

  void request<T>({
    required String path,
    required OnFromJson<T>? onFromJson,
    OnSuccess<T>? onSuccess,
    OnFailed? onFailed,
    ReqType reqType = ReqType.get,
    Map<String, dynamic>? params,
    Options? options,
    Object? body,
    CancelToken? cancelToken,
    BaseRespConfig? respConfig,
    CacheMode? cacheMode = CacheMode.ONLY_NETWORK,
    int? cacheTime,
    String? customCacheKey,
  }) {
    var future = _requestWithFuture<dynamic>(
        path: path,
        reqType: reqType,
        params: params,
        options: options,
        body: body,
        cancelToken: cancelToken,
        respConfig: respConfig,
        cacheMode: cacheMode,
        cacheTime: cacheTime,
        customCacheKey: customCacheKey);

    _callFuture(future, respConfig, onFromJson, onSuccess, onFailed);
  }

  Future<BaseResp<T>> requestWithFuture<T>({
    required String path,
    required OnFromJson<T>? onFromJson,
    ReqType reqType = ReqType.get,
    Map<String, dynamic>? params,
    Options? options,
    Object? body,
    CancelToken? cancelToken,
    BaseRespConfig? respConfig,
    CacheMode? cacheMode = CacheMode.ONLY_NETWORK,
    int? cacheTime,
    String? customCacheKey,
  }) async {
    try {
      var future = _requestWithFuture<dynamic>(
          path: path,
          reqType: reqType,
          params: params,
          options: options,
          body: body,
          cancelToken: cancelToken,
          respConfig: respConfig,
          cacheMode: cacheMode,
          cacheTime: cacheTime,
          customCacheKey: customCacheKey);

      Response response = await future;
      return _parseResponseThenCallback(
          response, respConfig, onFromJson, null, null);
    } on Exception catch (e) {
      return BaseResp(false, error: CstHttpException.createHttpException(e));
    }
  }

  Future<Response<T>> _requestWithFuture<T>({
    required String path,
    ReqType reqType = ReqType.get,
    Map<String, dynamic>? params,
    Options? options,
    Object? body,
    CancelToken? cancelToken,
    BaseRespConfig? respConfig,
    CacheMode? cacheMode = CacheMode.ONLY_NETWORK,
    int? cacheTime,
    String? customCacheKey,
  }) {
    Options option =
        _copyOptions(options, cacheMode, cacheTime, customCacheKey);

    Future<Response<T>> future;
    switch (reqType) {
      case ReqType.post:
        {
          future = _dio.post(path,
              data: body,
              queryParameters: params,
              options: option,
              cancelToken: cancelToken);
          break;
        }
      case ReqType.put:
        {
          future = _dio.put(path,
              data: body,
              queryParameters: params,
              options: option,
              cancelToken: cancelToken);
          break;
        }
      case ReqType.delete:
        {
          future = _dio.delete(path,
              data: body,
              queryParameters: params,
              options: option,
              cancelToken: cancelToken);
          break;
        }
      default:
        {
          future = _dio.get(path,
              queryParameters: params,
              options: option,
              cancelToken: cancelToken);
        }
    }
    return future;
  }

  /// 复制缓存options
  Options _copyOptions(Options? options, CacheMode? cacheMode, int? cacheTime,
      String? customCacheKey) {
    Options requestOptions = options ?? Options();
    requestOptions = requestOptions.copyWith(
      extra: {
        CacheStrategy.CACHE_MODE: cacheMode ?? CacheMode.ONLY_NETWORK,
        CacheStrategy.CACHE_TIME: cacheTime,
        CacheStrategy.CUSTOM_CACHE_KEY: customCacheKey
      },
    );
    return requestOptions;
  }

  BaseResp<T> _parseResponseThenCallback<T>(
      Response response,
      BaseRespConfig? respConfig,
      OnFromJson<T>? onFromJson,
      OnSuccess<T>? onSuccess,
      OnFailed? onFailed) {
    String filedCode = respConfig?.filedCode ?? _respConfig.filedCode;
    String filedMsg = respConfig?.filedMsg ?? _respConfig.filedMsg;
    int successCode = respConfig?.successCode ?? _respConfig.successCode;

    int code = -1;
    String? msg;
    T? data;

    try {
      // 获取response bytes 数据
      List<int>? body;
      if (response.requestOptions.responseType == ResponseType.bytes) {
        body = response.data;
      } else {
        body = utf8.encode(jsonEncode(response.data));
      }

      if (body == null) {
        var error = CstHttpException(-1, "内容为空");
        _onFailed(onFailed, error);
        return BaseResp(false, error: error);
      }

      // bytes转String并保存
      Uint8List bytes = Uint8List.fromList(body);

      Map<String, dynamic> result = jsonDecode(utf8.decode(bytes));

      code = result[filedCode] ?? -1;
      msg = result[filedMsg];

      if (code == successCode) {
        data = onFromJson == null ? null : onFromJson(result);
      }
    } catch (e) {
      var error = CstHttpException(-1, "Json解析失败", detailMessage: e.toString());
      _onFailed(onFailed, error);
      return BaseResp(false, error: error);
    }

    if (code != successCode) {
      var error = CstHttpException(code, msg ?? "业务错误码不等于业务成功码");
      _onFailed(onFailed, error);
      return BaseResp(false, error: error);
    }

    _onSuccess(onSuccess, data);
    return BaseResp(true, data: data);
  }

  void _onSuccess<T>(OnSuccess<T>? onSuccess, T? data) {
    if (onSuccess != null) {
      onSuccess(data);
    }
  }

  void _onFailed(OnFailed? onFailed, CstHttpException exception) {
    Log.d("Http request failed", error: exception);
    if (onFailed != null) {
      onFailed(exception);
    }
  }

  void _callFuture<T>(Future<Response> future, BaseRespConfig? respConfig,
      OnFromJson<T>? onFromJson, OnSuccess<T>? onSuccess, OnFailed? onFailed) {
    future.then((response) {
      _parseResponseThenCallback<T>(
          response, respConfig, onFromJson, onSuccess, onFailed);
    }, onError: (e) {
      _onFailed(onFailed, CstHttpException.createHttpException(e));
    }).catchError((e) {
      return e;
    });
  }
}

typedef OnFromJson<T> = T Function(Map<String, dynamic> json);
typedef OnSuccess<T> = void Function(T? data);
typedef OnFailed = void Function(CstHttpException exception);
