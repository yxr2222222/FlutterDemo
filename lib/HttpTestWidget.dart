import 'package:flutter/material.dart';
import 'package:flutter_demo/base/model/SimpleGetxController.dart';
import 'package:flutter_demo/base/util/GetBuilderUtil.dart';
import 'package:flutter_demo/base/widget/BaseMultiStateWidget.dart';

import 'base/vm/BaseMultiStateVM.dart';
import 'model/app_update.dart';

class HttpTestWidget extends BaseMultiStateWidget<_HttpTestVM> {
  HttpTestWidget({super.key}) : super(viewModel: _HttpTestVM());

  @override
  State<StatefulWidget> createState() => _HttpTestWidgetState();
}

class _HttpTestWidgetState
    extends BaseMultiStateWidgetState<_HttpTestVM, HttpTestWidget> {
  @override
  Widget createContentView(BuildContext context, _HttpTestVM viewModel) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        GestureDetector(
          onTap: () {
            viewModel.requestAppUpdate();
          },
          child: Container(
              margin: const EdgeInsets.only(top: 16),
              width: 200,
              height: 60,
              decoration: const BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.all(Radius.circular(8))),
              alignment: Alignment.center,
              child: const Text('检查更新',
                  style: TextStyle(fontSize: 20, color: Colors.white))),
        ),
        GetBuilderUtil.builder(
            (controller) => Text(
                  '${viewModel.appUpdateController.data?.toJson()}',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
            init: viewModel.appUpdateController),
      ],
    );
  }
}

class _HttpTestVM extends BaseMultiStateVM {
  final SimpleGetxController<AppUpdate> appUpdateController =
      SimpleGetxController();

  @override
  void onCreate() {
    super.onCreate();
    requestAppUpdate();
  }

  @override
  void onRetry() {
    requestAppUpdate();
  }

  /// 请求应用更新信息
  void requestAppUpdate() {
    requestWithState<AppUpdate>(
        path: "/pub/appUpdate/getAppUpdate",
        loadingTxt: "loading...",
        params: {"os": "0", "machine": "afhkeagjhakgaekl", "version": "1.0.0"},
        onFromJson: (Map<String, dynamic> json) {
          return AppUpdate.fromJson(json['data']);
        },
        onSuccess: (AppUpdate? data) {
          appUpdateController.data = data;
          appbarController.appbarTitle = data?.title ?? "未知标题";
        });
  }
}
