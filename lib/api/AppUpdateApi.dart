import 'package:flutter_demo/model/app_update.dart';
import 'package:yxr_flutter_basic/base/http/api/BaseApi.dart';
import 'package:yxr_flutter_basic/base/http/cache/CacheMode.dart';
import 'package:yxr_flutter_basic/base/model/BaseResp.dart';

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
