import 'package:flutter/material.dart';
import 'package:flutter_demo/api/AppUpdateApi.dart';
import 'package:flutter_demo/base/model/controller/SimpleGetxController.dart';
import 'package:flutter_demo/base/ui/widget/SimpleWidget.dart';
import 'package:flutter_demo/base/util/GetBuilderUtil.dart';
import 'package:flutter_demo/base/util/Log.dart';

import 'base/ui/page/BaseMultiStatePage.dart';
import 'base/vm/BaseMultiVM.dart';
import 'model/app_update.dart';

class HttpTestWidget extends BaseMultiPage<_HttpTestVM> {
  HttpTestWidget({super.key}) : super(viewModel: _HttpTestVM());

  @override
  State<StatefulWidget> createState() => _HttpTestWidgetState();
}

class _HttpTestWidgetState
    extends BaseMultiPageState<_HttpTestVM, HttpTestWidget> {
  @override
  Widget createMultiContentWidget(BuildContext context, _HttpTestVM viewModel) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SimpleWidget(
            margin: const EdgeInsets.only(top: 16),
            width: 200,
            height: 60,
            decoration: const BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.all(Radius.circular(8))),
            alignment: Alignment.center,
            onTap: () {
              viewModel.requestAppUpdate();
            },
            child: GetBuilderUtil.builder(
                (controller) => Text(viewModel.stateTxt.data ?? "检查更新",
                    style: const TextStyle(fontSize: 20, color: Colors.white)),
                init: viewModel.stateTxt)),
        GetBuilderUtil.builder(
            (controller) => Text(
                  '${viewModel.appUpdate.data?.toJson()}',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
            init: viewModel.appUpdate),
      ],
    );
  }
}

class _HttpTestVM extends BaseMultiVM {
  final SimpleGetxController<AppUpdate> appUpdate = SimpleGetxController();
  final SimpleGetxController<String> stateTxt = SimpleGetxController("检查更新");
  late AppUpdateApi appUpdateApi;

  @override
  void onCreate() {
    super.onCreate();
    appUpdateApi = createApi(AppUpdateApi());

    requestAppUpdate();
  }

  @override
  void onRetry() {
    requestAppUpdate();
  }

  /// 请求应用更新信息
  void requestAppUpdate() {
    var data = appUpdate.data;
    if (data != null) {
      download(
          urlPath: data.schemeUrl,
          filename: "教堂大全.apk",
          onSuccess: (file) {
            showToast("下载成功: ${file?.path}");
          },
          onFailed: (e) {
            showToast("${e.message}");
            Log.d("下载失败", error: e);
            stateTxt.data = "下载APP";
          },
          onProgress: (progress, total) {
            Log.d("下载中 progress: $progress, total: $total");
            stateTxt.data = "${(progress * 100.0 / total).toStringAsFixed(2)}%";
          });
    } else {
      requestWithState(
          future: appUpdateApi.getAppUpdate(),
          loadingTxt: "loading...",
          onSuccess: (AppUpdate? data) {
            stateTxt.data = "下载APP";
            appUpdate.data = data;
            appbarController.appbarTitle = data?.title ?? "未知标题";
          });
    }
  }
}
