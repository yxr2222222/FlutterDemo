import 'package:flutter/cupertino.dart';
import 'package:yxr_flutter_basic/base/ui/page/BasePage.dart';
import 'package:yxr_flutter_basic/base/vm/BaseVM.dart';

class TabBasketPage extends BasePage<_BasketVM> {
  TabBasketPage({super.key}) : super(viewModel: _BasketVM());

  @override
  State<StatefulWidget> createState() => _BasketPageState();
}

class _BasketPageState extends BasePageState<_BasketVM, TabBasketPage> {
  @override
  Widget createContentWidget(BuildContext context, _BasketVM viewModel) {
    return const Center(child: Text("BasketPage"));
  }

  @override
  bool get wantKeepAlive => true;
}

class _BasketVM extends BaseVM {
  @override
  Future<bool> onBackPressed() async {
    return false;
  }
}
