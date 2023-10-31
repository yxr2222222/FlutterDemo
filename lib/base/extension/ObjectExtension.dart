import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

extension ObjectExtension on Object {
  bool isAndroid() {
    return !kIsWeb && Platform.isAndroid;
  }

  bool isIOS() {
    return !kIsWeb && Platform.isIOS;
  }

  bool isWeb() {
    return kIsWeb;
  }

  bool isMacOS() {
    return !kIsWeb && Platform.isMacOS;
  }

  bool isWindows() {
    return !kIsWeb && Platform.isWindows;
  }

  bool isLinux() {
    return !kIsWeb && Platform.isLinux;
  }

  bool isFuchsia() {
    return !kIsWeb && Platform.isFuchsia;
  }

  Future<File> getDownloadPath({required String filename}) async {
    try {
      Future<Directory> future;
      String? directory = "downloads";
      if (isAndroid()) {
        future = getTemporaryDirectory();
      } else {
        var downloadDir = await getDownloadsDirectory();
        if (downloadDir == null) {
          future = getTemporaryDirectory();
        } else {
          directory = null;
          future = Future.value(downloadDir);
        }
      }
      var dir = await future;
      return _getFile(dir, directory, filename);
    } catch (e) {
      return File(filename);
    }
  }

  Future<File> getCachePath(
      {required String filename, String? directory}) async {
    try {
      var dir = await getApplicationCacheDirectory();
      return _getFile(dir, directory, filename);
    } catch (e) {
      return File(filename);
    }
  }

  File _getFile(Directory dir, String? directory, String filename) {
    return directory?.isNotEmpty == true
        ? File('${dir.path}/$directory/$filename')
        : File('${dir.path}/$filename');
  }

  void globalCatch(Function function, {OnException? onException}) {
    try {
      function();
    } on Exception catch (e) {
      _onException(onException, e);
    } on Error catch (e) {
      _onException(onException, Exception(e));
    }
  }

  void _onException(OnException? onException, Exception e) {
    if (onException != null) {
      onException(e);
    }
  }
}

typedef OnException = void Function(Exception exception);
