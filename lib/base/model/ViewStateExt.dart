import 'package:flutter_demo/base/model/em/ViewState.dart';

class ViewStateExt {
  final ViewState viewState;
  final String? hintTxt;
  final String? retryTxt;

  const ViewStateExt(this.viewState, {this.hintTxt, this.retryTxt});
}
