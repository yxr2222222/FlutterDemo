import 'package:url_launcher/url_launcher.dart';

import '../util/Log.dart';

extension ObjectExtension on String {
  Future<bool> launch() async {
    try {
      var uri = Uri.parse(this);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
        return true;
      }
    } catch (e) {
      Log.d("launchUrl error", error: e);
    }
    return false;
  }
}
