import 'package:flutter/cupertino.dart';
import 'package:flutter_demo/base/vm/BaseVM.dart';

import '../base/ui/page/BaseWidget.dart';

class MinePage extends BaseWidget<_MineVM> {
  MinePage({super.key}) : super(viewModel: _MineVM());

  @override
  State<StatefulWidget> createState() => _MinePageState();
}

class _MinePageState extends BaseWidgetState<_MineVM, MinePage> {
  @override
  Widget createContentWidget(BuildContext context, _MineVM viewModel) {
    return const Center(child: Text("MinePage"));
  }

  @override
  bool get wantKeepAlive => true;
}

class _MineVM extends BaseVM {}
