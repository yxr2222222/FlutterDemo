import 'package:flutter/cupertino.dart';
import 'package:flutter_demo/base/vm/BaseVM.dart';
import 'package:flutter_demo/base/widget/BaseWidget.dart';

class BasketPage extends BaseWidget<_BasketVM> {
  BasketPage({super.key}) : super(viewModel: _BasketVM());

  @override
  State<StatefulWidget> createState() => _BasketPageState();
}

class _BasketPageState extends BaseWidgetState<_BasketVM, BasketPage> {
  @override
  Widget createChild(BuildContext context, _BasketVM viewModel) {
    return const Center(child: Text("BasketPage"));
  }

  @override
  bool get wantKeepAlive => true;
}

class _BasketVM extends BaseVM {}