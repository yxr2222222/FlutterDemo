import 'package:yxr_flutter_basic/base/http/api/BaseApi.dart';
import 'package:yxr_flutter_basic/base/http/cache/CacheMode.dart';
import 'package:yxr_flutter_basic/base/model/BaseResp.dart';

import '../model/product_detail.dart';

class ProductApi extends BaseApi {
  Future<BaseResp<List<Product>>> getProductList(int pageNum,int pageSize) {
    return requestWithFuture<List<Product>>(
        path: "/home/recommendProductList",
        params: {"pageNum": pageNum, "pageSize": pageSize},
        onFromJson: (Map<String, dynamic> json) {
          return (json['data'] as List<dynamic>?)
                  ?.map((e) => Product.fromJson(e as Map<String, dynamic>))
                  .toList() ??
              [];
        });
  }

  Future<BaseResp<ProductDetail>> getProductDetail(String productId) {
    return requestWithFuture<ProductDetail>(
        path: "/product/detail/$productId",
        cacheMode: CacheMode.READ_CACHE_NETWORK_PUT,
        onFromJson: (Map<String, dynamic> json) {
          return ProductDetail.fromJson(json['data']);
        });
  }
}
