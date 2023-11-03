import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/model/product_detail.dart';
import 'package:flutter_demo/page/ProductDetailPage.dart';
import 'package:yxr_flutter_basic/base/extension/BuildContextExtension.dart';
import 'package:yxr_flutter_basic/base/model/BaseResp.dart';
import 'package:yxr_flutter_basic/base/model/PageResult.dart';
import 'package:yxr_flutter_basic/base/ui/page/BaseMultiStatePage.dart';
import 'package:yxr_flutter_basic/base/vm/BasePageListVM.dart';

import '../api/ProductApi.dart';

class ProductListPage extends BaseMultiPage<_ProductListVM> {
  ProductListPage({super.key}) : super(viewModel: _ProductListVM());

  @override
  State<StatefulWidget> createState() => _ProductListState();
}

class _ProductListState
    extends BaseMultiPageState<_ProductListVM, ProductListPage> {
  @override
  Widget createMultiContentWidget(
      BuildContext context, _ProductListVM viewModel) {
    return viewModel.listRefreshBuilder(onItemClick: (item, context) {
      item.item.clickNum = item.item.clickNum + 1;
      item.refresh();
      context.push(ProductDetailPage(
        productId: item.item.product.id ?? 26,
      ));
    }, childItemBuilder: (item, context) {
      return Container(
          width: double.infinity,
          alignment: Alignment.center,
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(color: Colors.white),
          margin: const EdgeInsets.only(top: 0.5),
          child: Row(
            children: [
              CachedNetworkImage(
                width: 64,
                height: 64,
                fit: BoxFit.cover,
                imageUrl: item.item.product.pic ?? "",
                placeholder: (context, url) => const Icon(Icons.downloading),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
              Expanded(
                  child: Container(
                width: double.infinity,
                margin: const EdgeInsets.only(left: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      item.item.product.name ?? "",
                      maxLines: 2,
                      style: const TextStyle(
                          fontSize: 16, color: Color(0xff333333)),
                    ),
                    Container(
                        margin: const EdgeInsets.only(top: 8),
                        child: Text(
                          "点击数: ${item.item.clickNum}",
                          style: const TextStyle(
                              fontSize: 12, color: Color(0xff999999)),
                        ))
                  ],
                ),
              ))
            ],
          ));
    });
  }
}

class _ProductListVM extends BasePageListVM<TesItem, List<Product>> {
  _ProductListVM();

  late ProductApi productApi;

  @override
  void onCreate() {
    super.onCreate();
    appbarController.appbarTitle = "商品列表";

    productApi = createApi(ProductApi());

    firstLoad(multiStateLoading: true);
  }

  @override
  Future<BaseResp<List<Product>>> loadData(int page, int pageSize) {
    return productApi.getProductList(page, pageSize);
  }

  @override
  PageResult<TesItem>? createPageResult(BaseResp<List<Product>> resp) {
    List<TesItem> itemList = [];
    resp.data?.forEach((item) {
      itemList.add(TesItem(item));
    });
    return PageResult(itemList);
  }

  @override
  int initPage() => 1;
}

class TesItem {
  final Product product;
  int clickNum = 0;

  TesItem(this.product);
}
