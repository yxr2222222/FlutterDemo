import 'package:flutter_demo/base/model/controller/BaseGetxController.dart';
import 'package:flutter_demo/base/model/em/ViewState.dart';

class ViewStateController extends BaseGetxController {
  ViewState _viewState = ViewState.content;
  String? _hintTxt;
  String? _retryTxt;

  ViewState get viewState => _viewState;

  String? get hintTxt => _hintTxt;

  String? get retryTxt => _retryTxt;

  void refreshState(ViewState viewState, {String? hintTxt, String? retryTxt}) {
    _viewState = viewState;
    _hintTxt = hintTxt;
    _retryTxt = retryTxt;
    update();
  }
}
