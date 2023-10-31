import 'package:flutter_demo/base/http/cache/CacheMode.dart';
import 'package:flutter_demo/model/app_update.dart';

import '../base/http/api/BaseApi.dart';
import '../base/model/BaseResp.dart';

class AppUpdateApi extends BaseApi {
  Future<BaseResp<AppUpdate>> getAppUpdate() {
    return requestWithFuture<AppUpdate>(
        path: "/pub/appUpdate/getAppUpdate",
        params: {"os": "0", "machine": "afhkeagjhakgaekl", "version": "1.0.0"},
        cacheMode: CacheMode.READ_CACHE_NETWORK_PUT,
        onFromJson: (Map<String, dynamic> json) {
          return AppUpdate.fromJson(json['data']);
        });
  }
}
