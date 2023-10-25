import 'package:flutter/cupertino.dart';
import 'package:permission_handler/permission_handler.dart';
import '../callback/OnPermissionCallback.dart';

class PermissionReq {
  final bool isNeedTipDialog;
  final List<Permission> permissions;
  final String? title;
  final String? content;
  final String? permissionPermanentlyDeniedDesc;
  final OnPermissionCallback callback;

  const PermissionReq(this.isNeedTipDialog, this.permissions, this.callback,
      {this.title,
      this.content,
      this.permissionPermanentlyDeniedDesc = "当前申请的权限被永久拒绝或多次拒绝，需要您手动开启"});
}
