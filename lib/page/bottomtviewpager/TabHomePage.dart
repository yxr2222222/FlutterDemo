import 'package:flutter/cupertino.dart';
import 'package:yxr_flutter_basic/base/ui/page/BasePage.dart';
import 'package:yxr_flutter_basic/base/vm/BaseVM.dart';

class TabHomePage extends BasePage {
  TabHomePage({super.key, super.isCanBackPressed = false});

  @override
  State<BasePage> createState() => _HomePageState();
}

class _HomePageState extends BasePageState<_HomeVM, TabHomePage> {
  @override
  _HomeVM createViewModel() => _HomeVM();

  @override
  Widget createContentWidget(BuildContext context, _HomeVM viewModel) {
    return const Center(child: Text("HomePage"));
  }

  @override
  bool get wantKeepAlive => true;
}

class _HomeVM extends BaseVM {

}
