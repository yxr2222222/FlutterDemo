import 'package:flutter/cupertino.dart';
import 'package:yxr_flutter_basic/base/config/ColorConfig.dart';
import 'package:yxr_flutter_basic/base/ui/page/BasePageViewPage.dart';
import 'package:yxr_flutter_basic/base/util/Log.dart';
import 'package:yxr_flutter_basic/base/vm/BaseMultiVM.dart';

class TabViewPagerChildPage extends BasePageViewPage {
  final String title;

  TabViewPagerChildPage({
    super.key,
    super.isCanBackPressed = false,
    required super.pageIndex,
    required super.keepAliveController,
    required this.title,
  });

  @override
  State<BasePageViewPage> createState() => _TabViewPagerChildState();
}

class _TabViewPagerChildState
    extends BasePageViewState<_TabViewPagerChildVM, TabViewPagerChildPage> {
  @override
  _TabViewPagerChildVM createViewModel() => _TabViewPagerChildVM();

  @override
  Widget createMultiContentWidget(
      BuildContext context, _TabViewPagerChildVM viewModel) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      alignment: Alignment.center,
      child: Text(
        widget.title,
        style: const TextStyle(
            color: ColorConfig.blue_007aff,
            fontSize: 18,
            fontWeight: FontWeight.normal),
      ),
    );
  }

  @override
  void onCreate() {
    super.onCreate();
    Log.d("onCreate...${widget.pageIndex}");
  }

  @override
  void onDestroy() {
    Log.d("onDestroy...${widget.pageIndex}");
    super.onDestroy();
  }
}

class _TabViewPagerChildVM extends BaseMultiVM {}
