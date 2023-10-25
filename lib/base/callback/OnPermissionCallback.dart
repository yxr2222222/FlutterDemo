abstract class OnPermissionCallback {
  void onGranted();

  void onDenied(bool isPermanentlyDenied);
}
