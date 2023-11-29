import 'package:flutter/material.dart';
import 'package:yxr_flutter_basic/base/ui/page/BaseMultiStatePage.dart';
import 'package:yxr_flutter_basic/base/ui/widget/AnimaWidget.dart';
import 'package:yxr_flutter_basic/base/util/Log.dart';
import 'package:yxr_flutter_basic/base/vm/BaseMultiVM.dart';

class AnimaPage extends BaseMultiPage {
  AnimaPage({super.key});

  @override
  State<BaseMultiPage> createState() => _AnimaState();
}

class _AnimaState extends BaseMultiPageState<_AnimaVM, AnimaPage> {
  final AnimationCtx _animationCtx = AnimationCtx();

  @override
  Widget createMultiContentWidget(BuildContext context, _AnimaVM viewModel) {
    return LayoutBuilder(builder: (context, constraints) {
      var maxWidth = constraints.maxWidth;
      var maxHeight = constraints.maxHeight;

      return Stack(
        children: [
          _buildAnimaWidget(maxWidth, maxHeight),
          _buildFunction(maxWidth, maxHeight),
        ],
      );
    });
  }

  @override
  _AnimaVM createViewModel() => _AnimaVM();

  /// 构建动画组件
  Widget _buildAnimaWidget(double maxWidth, double maxHeight) => AnimaWidget(
      duration: const Duration(milliseconds: 1000),
      animationCtx: _animationCtx,
      onChildBuilder: (context, value) {
        var left = (maxWidth - 50) * value;
        var top = (maxHeight - 50) * value;
        Log.d("onAnima....value: $value, left: $left, top: $top");
        return Positioned(
            width: 50,
            height: 50,
            left: left,
            top: top,
            child: Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.red,
            ));
      });

  /// 构建功能按钮列表
  Widget _buildFunction(double maxWidth, double maxHeight) => Positioned(
      width: maxWidth,
      height: 40,
      left: 0,
      bottom: 32,
      child: Row(
        children: [
          const Padding(padding: EdgeInsets.only(left: 16)),
          _buildFunctionItem("开始动画", () {
            _animationCtx.start();
          }),
          const Padding(padding: EdgeInsets.only(left: 16)),
          _buildFunctionItem("反转动画", () {
            _animationCtx.reverse();
          }),
          const Padding(padding: EdgeInsets.only(left: 16)),
          _buildFunctionItem("停止动画", () {
            _animationCtx.stop();
          }),
          const Padding(padding: EdgeInsets.only(left: 16)),
          _buildFunctionItem("重置动画", () {
            _animationCtx.reset();
          }),
          const Padding(padding: EdgeInsets.only(right: 16)),
        ],
      ));

  /// 构建功能按钮
  Widget _buildFunctionItem(String title, GestureTapCallback onTap) => Expanded(
          child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: double.infinity,
          alignment: Alignment.center,
          color: Colors.blue,
          child: Text(
            title,
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      ));
}

class _AnimaVM extends BaseMultiVM {
  @override
  void onCreate() {
    super.onCreate();
    appbarController.appbarTitle = "属性动画示例";
  }
}
