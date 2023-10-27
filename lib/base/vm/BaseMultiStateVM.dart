import 'package:dio/dio.dart';
import 'package:flutter_demo/base/model/ViewStateController.dart';
import 'package:flutter_demo/base/model/em/ViewState.dart';
import 'package:flutter_demo/base/vm/BaseVM.dart';

import '../http/HttpManager.dart';
import '../http/cache/CacheMode.dart';
import '../http/exception/CstHttpException.dart';
import '../http/model/BaseRespConfig.dart';
import '../http/model/ReqType.dart';
import '../model/AppbarController.dart';

abstract class BaseMultiStateVM extends BaseVM {
  // 页面状态
  final ViewStateController stateController = ViewStateController();
  final AppbarController appbarController = AppbarController();

  /// 展示内容状态的UI
  void showContentState() {
    stateController.refreshState(ViewState.content);
  }

  /// 展示loading状态的UI
  void showLoadingState({String? loadingTxt}) {
    stateController.refreshState(ViewState.loading, hintTxt: loadingTxt);
  }

  /// 展示错误状态的UI
  void showErrorState({String? errorTxt, String? retryTxt}) {
    stateController.refreshState(ViewState.error, hintTxt: errorTxt, retryTxt: retryTxt);
  }

  /// 展示空状态的UI
  void showEmptyState({String? emptyTxt, String? retryTxt}) {
    stateController.refreshState(ViewState.empty, hintTxt: emptyTxt, retryTxt: retryTxt);
  }

  /// 重试按钮被点击
  void onRetry() {}

  /// 结合多状态UI的网络请求
  void requestWithState<T>({
    required String path,
    required OnFromJson<T>? onFromJson,
    String? loadingTxt,
    bool isShowErrorDetail = false,
    String? retryTxt,
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
    // 展示loading状态UI
    showLoadingState(loadingTxt: loadingTxt);

    super.request(
        path: path,
        onFromJson: onFromJson,
        isNeedLoading: false,
        loadingTxt: loadingTxt,
        isShowErrorToast: false,
        isShowErrorDetailToast: false,
        onSuccess: (T? data) {
          if (!isFinishing()) {
            // 接口成功，展示内容状态UI
            showContentState();

            if (onSuccess != null) {
              // 成功回调，可以在此回调自定义操作
              onSuccess(data);
            }
          }
        },
        onFailed: (CstHttpException e) {
          if (!isFinishing()) {
            // 接口失败，展示错误状态UI
            showErrorState(
                errorTxt: isShowErrorDetail ? e.detailMessage : e.message,
                retryTxt: retryTxt);

            if (onFailed != null) {
              // 失败回调，可以在此回调自定义操作
              onFailed(e);
            }
          }
        },
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
}
