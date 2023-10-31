import 'package:flutter_demo/model/app_update.dart';

import '../base/http/api/BaseApi.dart';
import '../base/model/BaseResp.dart';

class TestPageDataApi extends BaseApi {
  Future<BaseResp<List<dynamic>>> getTestPageData({required int page}) {
    return requestWithFuture<List<dynamic>>(
        path: "/pub/test/pageData",
        params: {"page": page, "pageSize": 20},
        onFromJson: (Map<String, dynamic> json) {
          return json['data'];
        });
  }
}
