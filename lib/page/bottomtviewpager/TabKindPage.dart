import 'package:flutter/cupertino.dart';
import 'package:yxr_flutter_basic/base/ui/page/BasePage.dart';
import 'package:yxr_flutter_basic/base/vm/BaseVM.dart';

class TabKindPage extends BasePage {
  TabKindPage({super.key, super.isCanBackPressed = false});

  @override
  State<BasePage> createState() => _KindPageState();

}

class _KindPageState extends BasePageState<_KindVM, TabKindPage> {

  @override
  _KindVM createViewModel() => _KindVM();

  @override
  Widget createContentWidget(BuildContext context, _KindVM viewModel) {
    return const Center(child: Text("KindPage"));
  }

  @override
  bool get wantKeepAlive => true;
}

class _KindVM extends BaseVM {

}
