import 'package:flutter/material.dart';
import 'package:flutter_demo/HttpTestVM.dart';
import 'package:flutter_demo/base/widget/BaseMultiStateWidget.dart';

class HttpTestWidget extends BaseMultiStateWidget<HttpTestVM> {
  HttpTestWidget({super.key}) : super(viewModel: HttpTestVM());

  @override
  State<StatefulWidget> createState() => _HttpTestWidgetState();
}

class _HttpTestWidgetState
    extends BaseMultiStateWidgetState<HttpTestVM, HttpTestWidget> {
  @override
  Widget createContentView(BuildContext context, HttpTestVM viewModel) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        GestureDetector(
          onTap: () {
            viewModel.requestAppUpdate();
          },
          child: Container(
              margin: const EdgeInsets.only(top: 16),
              width: 200,
              height: 60,
              decoration: const BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.all(Radius.circular(8))),
              alignment: Alignment.center,
              child: const Text('检查更新',
                  style: TextStyle(fontSize: 20, color: Colors.white))),
        ),
        Text(
          '${viewModel.appUpdate?.toJson()}',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ],
    );
  }
}
