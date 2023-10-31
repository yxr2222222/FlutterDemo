import 'package:dio/dio.dart';

import '../../model/BaseResp.dart';
import '../../util/Log.dart';
import '../HttpManager.dart';
import '../cache/CacheMode.dart';
import '../model/BaseRespConfig.dart';
import '../model/ReqType.dart';

class BaseApi {
  final List<CancelToken> _cancelTokenList = [];

  BaseApi();

  /// 需要异步调用的网络请求
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
    return HttpManager.getInstance().requestWithFuture<T>(
        path: path,
        onFromJson: onFromJson,
        reqType: reqType,
        params: params,
        options: options,
        body: body,
        cancelToken: cancelToken,
        respConfig: respConfig,
        cacheMode: cacheMode,
        cacheTime: cacheTime,
        customCacheKey: customCacheKey);
  }

  /// 取消所有未完成的网络请求
  void cancelRequests() {
    for (var cancelToken in _cancelTokenList) {
      cancelRequest(cancelToken);
    }
    _cancelTokenList.clear();
  }

  /// 取消某个网络请求
  void cancelRequest(CancelToken cancelToken) {
    try {
      if (!cancelToken.isCancelled) {
        cancelToken.cancel();
      }
    } catch (e) {
      Log.d(e.toString());
    }
  }
}
