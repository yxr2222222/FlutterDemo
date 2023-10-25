import 'package:flutter/cupertino.dart';
import 'package:flutter_demo/base/extension/BuildContextExtension.dart';
import 'package:permission_handler/permission_handler.dart';

import '../model/PermissionReq.dart';

class PermissionUtil {
  /// 申请权限，TODO: 除了移动端如何处理？
  static void requestPermission(
      BuildContext context, PermissionReq permissionReq) {
    if (permissionReq.isNeedTipDialog) {
      var title = permissionReq.title ?? "权限申请说明";
      var content = permissionReq.content ?? "当前功能需要申请部分权限，确定进行申请吗？";
      showCupertinoDialog(
          context: context,
          builder: (BuildContext context) {
            return CupertinoAlertDialog(
                title: Text(title),
                content: Text(content),
                actions: [
                  CupertinoDialogAction(
                      child: const Text("取消"),
                      onPressed: () {
                        context.pop();
                        permissionReq.callback.onDenied(false);
                      }),
                  CupertinoDialogAction(
                      child: const Text("确认"),
                      onPressed: () {
                        context.pop();
                        _requestPermission(context, permissionReq);
                      })
                ]);
          });
    } else {
      permissionReq.callback.onDenied(false);
    }
  }

  static void _requestPermission(
      BuildContext context, PermissionReq permissionReq) {
    permissionReq.permissions.request().then((value) => () {
          bool isGranted = false;
          bool isPermanentlyDenied = false;

          value.forEach((key, value) {
            if (value.isDenied || value.isPermanentlyDenied) {
              if (value.isPermanentlyDenied) {
                isPermanentlyDenied = true;
              }
              isGranted = false;
            }
          });

          if (isGranted) {
            permissionReq.callback.onGranted();
          } else {
            var permissionProhibitDesc =
                permissionReq.permissionPermanentlyDeniedDesc;
            if (isPermanentlyDenied && permissionProhibitDesc != null) {
              showCupertinoDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return CupertinoAlertDialog(
                        content: Text(permissionProhibitDesc),
                        actions: [
                          CupertinoDialogAction(
                              child: const Text("取消"),
                              onPressed: () {
                                context.pop();
                              }),
                          CupertinoDialogAction(
                              child: const Text("确认"),
                              onPressed: () {
                                context.pop();
                                // 跳着到设置界面
                                openAppSettings().then((value) => null);
                              })
                        ]);
                  });
            }
            permissionReq.callback.onDenied(isPermanentlyDenied);
          }
        });
  }
}
