import 'package:flutter/cupertino.dart';
import 'package:yxr_flutter_basic/base/ui/page/BasePage.dart';
import 'package:yxr_flutter_basic/base/vm/BaseVM.dart';

class TabMinePage extends BasePage<_MineVM> {
  TabMinePage({super.key}) : super(viewModel: _MineVM());

  @override
  State<StatefulWidget> createState() => _MinePageState();
}

class _MinePageState extends BasePageState<_MineVM, TabMinePage> {
  @override
  Widget createContentWidget(BuildContext context, _MineVM viewModel) {
    return const Center(child: Text("MinePage"));
  }

  @override
  bool get wantKeepAlive => true;
}

class _MineVM extends BaseVM {
  @override
  Future<bool> onBackPressed() async {
    return false;
  }
}
