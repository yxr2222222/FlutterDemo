import 'package:flutter/cupertino.dart';
import 'package:flutter_demo/base/vm/BaseVM.dart';

import '../base/ui/page/BasePage.dart';

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

class _HomeVM extends BaseVM {}
