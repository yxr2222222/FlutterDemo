import 'package:flutter/cupertino.dart';
import 'package:yxr_flutter_basic/base/ui/page/BasePage.dart';
import 'package:yxr_flutter_basic/base/vm/BaseVM.dart';

class TabBasketPage extends BasePage {
  TabBasketPage({super.key, super.isCanBackPressed = false});

  @override
  State<BasePage> createState() => _BasketPageState();
}

class _BasketPageState extends BasePageState<_BasketVM, TabBasketPage> {
  @override
  _BasketVM createViewModel() => _BasketVM();

  @override
  Widget createContentWidget(BuildContext context, _BasketVM viewModel) {
    return const Center(child: Text("BasketPage"));
  }

  @override
  bool get wantKeepAlive => true;
}

class _BasketVM extends BaseVM {

}
