import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_demo/base/extension/BuildContextExtension.dart';
import 'package:flutter_demo/base/vm/BaseVM.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:visibility_detector/visibility_detector.dart';

import 'DefaultLoadingDialog.dart';

abstract class BaseWidget<VM extends BaseVM> extends StatefulWidget {
  final VM viewModel;

  const BaseWidget({super.key, required this.viewModel});
}

abstract class BaseWidgetState<VM extends BaseVM, W extends BaseWidget<VM>>
    extends State<W> {
  late VM _viewModel;

  VM get viewModel => _viewModel;

  late BuildContext _context;
  BuildContext? _currLoading;

  bool _created = false;
  AppLifecycleListener? _lifecycleListener;

  @override
  void initState() {
    VisibilityDetectorController.instance.updateInterval = Duration.zero;
    this._viewModel = widget.viewModel;

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _onCreate(_context);
    });

    super.initState();

    _lifecycleListener = AppLifecycleListener(
      onResume: () {
        _onResume(true);
      },
      onHide: () {
        if (!Platform.isAndroid && !Platform.isIOS) {
          _onPause(true);
        }
      },
      onPause: () {
        if (Platform.isAndroid || Platform.isIOS) {
          _onPause(true);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    this._context = context;
    return VisibilityDetector(
        key: UniqueKey(),
        child: ChangeNotifierProvider(
          create: (BuildContext context) => viewModel,
          child: Consumer<VM>(
            builder: (BuildContext context, VM viewModel, Widget? child) =>
                createChild(context, viewModel),
          ),
        ),
        onVisibilityChanged: (visibilityInfo) {
          var visiblePercentage = visibilityInfo.visibleFraction * 100;
          if (visiblePercentage >= 80) {
            _onResume(false);
          } else {
            _onPause(false);
          }
        });
  }

  @override
  void dispose() {
    _lifecycleListener?.dispose();
    viewModel.onDestroy();

    dismissLoading();

    onDestroy();
    super.dispose();
  }

  void _onCreate(BuildContext context) {
    if (!_created) {
      _created = true;

      // 初始化ViewModel
      viewModel.init(context);
      // 设置展示loading的方法
      viewModel.onShowLoading = (String? loadingTxt, Color barrierColor,
          bool barrierDismissible, bool cancelable) {
        showLoading(
            loadingTxt: loadingTxt,
            barrierColor: barrierColor,
            barrierDismissible: barrierDismissible,
            cancelable: cancelable);
      };
      // 设置隐藏loading的方法
      viewModel.onDismissLoading = () {
        dismissLoading();
      };

      onCreate();
      viewModel.onCreate();
    }
  }

  void _onResume(bool isFromLifecycle) {
    if (_created) {
      if (!isFromLifecycle || ModalRoute.of(context)?.isCurrent == true) {
        onResume();
        viewModel.onResume();
      }
    }
  }

  void _onPause(bool isFromLifecycle) {
    if (_created) {
      if (!isFromLifecycle || ModalRoute.of(context)?.isCurrent == true) {
        onPause();
        viewModel.onPause();
      }
    }
  }

  @protected
  void onCreate() {}

  @protected
  void onResume() {}

  @protected
  void onPause() {}

  @protected
  void onDestroy() {}

  /// 展示toast
  void showToast(String? msg) {
    if (msg != null) {
      Fluttertoast.showToast(msg: msg);
    }
  }

  /// 展示loading弹框
  void showLoading(
      {String? loadingTxt,
      Color? barrierColor,
      bool barrierDismissible = false,
      bool cancelable = false}) {
    dismissLoading();
    showDialog(
        context: _context,
        barrierColor: barrierColor,
        barrierDismissible: barrierDismissible,
        builder: (context) {
          _currLoading = context;
          return WillPopScope(
            onWillPop: () async => cancelable,
            child: createLoadingDialog(loadingTxt),
          );
        });
  }

  void dismissLoading() {
    _currLoading?.pop();
    _currLoading = null;
  }

  Dialog createLoadingDialog(String? loadingTxt) {
    return DefaultLoadingDialog(loadingTxt);
  }

  Widget createChild(BuildContext context, VM viewModel);
}