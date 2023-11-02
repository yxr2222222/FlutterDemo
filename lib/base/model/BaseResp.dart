import 'package:flutter_demo/base/http/exception/CstException.dart';

class BaseResp<T> {
  final bool isSuccess;
  final T? data;
  final CstException? error;

  BaseResp(this.isSuccess, {this.data, this.error});
}
