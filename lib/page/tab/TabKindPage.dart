import 'package:flutter/cupertino.dart';
import 'package:yxr_flutter_basic/base/ui/page/BasePage.dart';
import 'package:yxr_flutter_basic/base/vm/BaseVM.dart';

class TabKindPage extends BasePage<_KindVM> {
  TabKindPage({super.key}) : super(viewModel: _KindVM());

  @override
  State<StatefulWidget> createState() => _KindPageState();
}

class _KindPageState extends BasePageState<_KindVM, TabKindPage> {
  @override
  Widget createContentWidget(BuildContext context, _KindVM viewModel) {
    return const Center(child: Text("KindPage"));
  }

  @override
  bool get wantKeepAlive => true;
}

class _KindVM extends BaseVM {
  @override
  Future<bool> onBackPressed() async {
    return false;
  }
}
