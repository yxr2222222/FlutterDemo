import 'package:flutter/cupertino.dart';
import 'package:flutter_demo/base/vm/BaseVM.dart';

import '../base/ui/page/BaseWidget.dart';

class KindPage extends BaseWidget<_KindVM> {
  KindPage({super.key}) : super(viewModel: _KindVM());

  @override
  State<StatefulWidget> createState() => _KindPageState();
}

class _KindPageState extends BaseWidgetState<_KindVM, KindPage> {
  @override
  Widget createContentWidget(BuildContext context, _KindVM viewModel) {
    return const Center(child: Text("KindPage"));
  }

  @override
  bool get wantKeepAlive => true;
}

class _KindVM extends BaseVM {}
