import 'package:flutter/cupertino.dart';
import 'package:yxr_flutter_basic/base/ui/page/BasePage.dart';
import 'package:yxr_flutter_basic/base/vm/BaseVM.dart';

class HomePage extends BasePage<_HomeVM> {
  HomePage({super.key}) : super(viewModel: _HomeVM());

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends BasePageState<_HomeVM, HomePage> {
  @override
  Widget createContentWidget(BuildContext context, _HomeVM viewModel) {
    return const Center(child: Text("HomePage"));
  }

  @override
  bool get wantKeepAlive => true;
}

class _HomeVM extends BaseVM {
  @override
  Future<bool> onBackPressed() async {
    return false;
  }
}
