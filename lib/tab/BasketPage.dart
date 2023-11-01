import 'package:flutter/cupertino.dart';
import 'package:flutter_demo/base/vm/BaseVM.dart';

import '../base/ui/page/BasePage.dart';

class BasketPage extends BasePage<_BasketVM> {
  BasketPage({super.key}) : super(viewModel: _BasketVM());

  @override
  State<StatefulWidget> createState() => _BasketPageState();
}

class _BasketPageState extends BasePageState<_BasketVM, BasketPage> {
  @override
  Widget createContentWidget(BuildContext context, _BasketVM viewModel) {
    return const Center(child: Text("BasketPage"));
  }

  @override
  bool get wantKeepAlive => true;
}

class _BasketVM extends BaseVM {}
