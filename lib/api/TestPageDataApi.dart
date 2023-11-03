import 'package:yxr_flutter_basic/base/http/api/BaseApi.dart';
import 'package:yxr_flutter_basic/base/model/BaseResp.dart';

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
