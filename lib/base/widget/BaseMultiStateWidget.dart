import 'package:flutter/material.dart';
import 'package:flutter_demo/base/model/AppbarController.dart';
import 'package:flutter_demo/base/model/ViewStateController.dart';
import 'package:flutter_demo/base/model/em/ViewState.dart';
import 'package:flutter_demo/base/widget/BaseWidget.dart';

import '../util/GetBuilderUtil.dart';
import '../vm/BaseMultiStateVM.dart';

abstract class BaseMultiStateWidget<VM extends BaseMultiStateVM>
    extends BaseWidget<VM> {
  const BaseMultiStateWidget({super.key, required super.viewModel});
}

abstract class BaseMultiStateWidgetState<VM extends BaseMultiStateVM,
    T extends BaseMultiStateWidget<VM>> extends BaseWidgetState<VM, T> {
  Widget? _contentView, _loadingView, _errorView, _emptyView;

  @override
  Widget createChild(BuildContext context, VM viewModel) => Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(MediaQuery.of(context).size.width, 56.0),
        child: createAppBar(context, viewModel),
      ),
      body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(color: Color(0xfff2f2f2)),
          child: GetBuilderUtil.builder(
              (controller) => _buildWidget(context, viewModel, controller),
              init: viewModel.stateController)));

  ///根据不同状态来显示不同的视图
  Widget _buildWidget(
      BuildContext context, VM viewModel, ViewStateController controller) {
    switch (controller.viewState) {
      case ViewState.error:
        _errorView ??= createErrorView(context, viewModel, controller);
        return _errorView!;
      case ViewState.loading:
        _loadingView ??= createLoadingView(context, viewModel, controller);
        return _loadingView!;
      case ViewState.empty:
        _emptyView ??= createEmptyView(context, viewModel, controller);
        return _emptyView!;
      default:
        _contentView ??= createContentView(context, viewModel);
        return _contentView!;
    }
  }

  /// 创建AppBar控件，子类可override自定义
  Widget createAppBar(BuildContext context, VM viewModel) {
    return GetBuilderUtil.builder<AppbarController>(
        (controller) => AppBar(
              leading: GestureDetector(
                onTap: () {
                  viewModel.onBackPressed();
                },
                child: SizedBox(
                    width: 56,
                    height: 48,
                    child: Icon(controller.appbarBackIcon, size: 24)),
              ),
              backgroundColor: controller.appbarBackgroundColor,
              title: Text(controller.appbarTitle ?? ""),
              centerTitle: true,
              titleTextStyle: controller.appbarTitleStyle,
              actions: controller.appbarActions,
            ),
        init: viewModel.appbarController);
  }

  /// 创建Loading视图，子类可override自定义
  Widget createLoadingView(
      BuildContext context, VM viewModel, ViewStateController controller) {
    return SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                            width: 32,
                            height: 32,
                            child: CircularProgressIndicator()),
                        Visibility(
                            visible: controller.hintTxt != null,
                            child: Container(
                              margin: const EdgeInsets.only(top: 16),
                              child: Text(
                                controller.hintTxt ?? "",
                                style: const TextStyle(
                                    fontSize: 14, color: Color(0xff5c5c5c)),
                              ),
                            ))
                      ],
                    )),
              )
            ]));
  }

  /// 创建错误视图，子类可override自定义
  Widget createErrorView(
      BuildContext context, VM viewModel, ViewStateController controller) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            'images/status_default_nonetwork.png',
            width: 144,
            height: 115,
            fit: BoxFit.cover,
          ),
          Container(
            margin: const EdgeInsets.only(top: 24),
            child: Text(
              controller.hintTxt ?? "加载失败，试试刷新页面",
              style: const TextStyle(fontSize: 14, color: Color(0xff999999)),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 24),
            child: ElevatedButton(
              onPressed: () => viewModel.onRetry(),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                elevation: 5,
                padding: const EdgeInsets.only(
                    left: 24, top: 14, right: 24, bottom: 14),
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(24))),
              ),
              child: Text(
                controller.retryTxt ?? "重新加载",
                style: const TextStyle(fontSize: 14, color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }

  /// 创建空视图，子类可override自定义
  Widget createEmptyView(
      BuildContext context, VM viewModel, ViewStateController controller) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            'images/status_default_empty.png',
            width: 180,
            height: 180,
            fit: BoxFit.cover,
          ),
          Container(
            margin: const EdgeInsets.only(top: 16),
            child: Text(
              controller.hintTxt ?? "未获取到相关内容～",
              style: const TextStyle(fontSize: 14, color: Color(0xff999999)),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 24),
            child: ElevatedButton(
              onPressed: () => viewModel.onRetry(),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                elevation: 5,
                padding: const EdgeInsets.only(
                    left: 24, top: 14, right: 24, bottom: 14),
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(24))),
              ),
              child: Text(
                controller.retryTxt ?? "重新加载",
                style: const TextStyle(fontSize: 14, color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }

  /// 创建内容控件，抽象方法，子类必须实现
  Widget createContentView(BuildContext context, VM viewModel);
}
