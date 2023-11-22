import 'package:flutter/cupertino.dart';
import 'package:yxr_flutter_basic/base/config/ColorConfig.dart';
import 'package:yxr_flutter_basic/base/ui/page/BasePage.dart';
import 'package:yxr_flutter_basic/base/util/Log.dart';
import 'package:yxr_flutter_basic/base/vm/BaseVM.dart';

class TabViewPagerChildPage extends BasePage {
  final String title;
  final int pageIndex;
  final int currPage;

  TabViewPagerChildPage(
      {super.key,
      required this.title,
      required this.pageIndex,
      required this.currPage});

  @override
  State<BasePage> createState() => _TabViewPagerChildState();
}

class _TabViewPagerChildState
    extends BasePageState<_TabViewPagerChildVM, TabViewPagerChildPage> {

  @override
  _TabViewPagerChildVM createViewModel() => _TabViewPagerChildVM();

  /// viewpager需要左右各keep alive几个
  static const int off_limit = 1;

  /// 通过wantKeepAlive来判断当前tab是否需要keep alive
  @override
  bool get wantKeepAlive =>
      (widget.pageIndex - widget.currPage).abs() <= off_limit;

  @override
  Widget createContentWidget(
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
  void didUpdateWidget(covariant TabViewPagerChildPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.currPage != widget.currPage) {
      updateKeepAlive();
    }
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

class _TabViewPagerChildVM extends BaseVM {
  /// 因为嵌套在page内，所以要屏蔽掉返回事件
  @override
  Future<bool> onBackPressed() async {
    return false;
  }
}
