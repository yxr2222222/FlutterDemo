import 'package:flutter_demo/base/http/exception/CstHttpException.dart';

class BaseResp<T> {
  final bool isSuccess;
  final T? data;
  final CstHttpException? error;

  BaseResp(this.isSuccess, {this.data, this.error});
}
