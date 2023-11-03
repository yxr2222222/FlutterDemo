import 'package:flutter/material.dart';
import 'package:flutter_demo/api/ProductApi.dart';
import 'package:flutter_demo/model/product_detail.dart';
import 'package:yxr_flutter_basic/base/model/controller/SimpleGetxController.dart';
import 'package:yxr_flutter_basic/base/ui/page/BaseMultiStatePage.dart';
import 'package:yxr_flutter_basic/base/ui/widget/SimpleWidget.dart';
import 'package:yxr_flutter_basic/base/util/GetBuilderUtil.dart';
import 'package:yxr_flutter_basic/base/util/Log.dart';
import 'package:yxr_flutter_basic/base/vm/BaseMultiVM.dart';

class ProductDetailPage extends BaseMultiPage<_ProductDetailVM> {
  ProductDetailPage({super.key, required int productId})
      : super(viewModel: _ProductDetailVM(productId));

  @override
  State<StatefulWidget> createState() => _ProductDetailState();
}

class _ProductDetailState
    extends BaseMultiPageState<_ProductDetailVM, ProductDetailPage> {
  @override
  Widget createMultiContentWidget(
      BuildContext context, _ProductDetailVM viewModel) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SimpleWidget(
            margin: const EdgeInsets.only(top: 16),
            width: 200,
            height: 60,
            decoration: const BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.all(Radius.circular(8))),
            alignment: Alignment.center,
            onTap: () {
              viewModel.checkDownloadImage();
            },
            child: GetBuilderUtil.builder(
                (controller) => Text(viewModel.stateTxt.data ?? "获取商品详情",
                    style: const TextStyle(fontSize: 20, color: Colors.white)),
                init: viewModel.stateTxt)),
        Expanded(
            child: Container(
          margin: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: GetBuilderUtil.builder(
                (controller) => Text(
                      '品牌图片地址: ${viewModel.productDetail.data?.brand?.bigPic}',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                init: viewModel.productDetail),
          ),
        )),
      ],
    );
  }
}

class _ProductDetailVM extends BaseMultiVM {
  final int productId;
  final SimpleGetxController<ProductDetail> productDetail =
      SimpleGetxController();
  final SimpleGetxController<String> stateTxt = SimpleGetxController("获取商品详情");
  late ProductApi appUpdateApi;

  _ProductDetailVM(this.productId);

  @override
  void onCreate() {
    super.onCreate();
    appUpdateApi = createApi(ProductApi());

    appbarController.appbarTitle = "获取商品详情";

    _getProductDetail();
  }

  @override
  void onRetry() {
    _getProductDetail();
  }

  /// 请求应用更新信息
  void _getProductDetail() {
    requestWithState(
        future: appUpdateApi.getProductDetail(productId.toString()),
        loadingTxt: "loading...",
        onSuccess: (ProductDetail? data) {
          stateTxt.data = "下载图片";
          productDetail.data = data;
          appbarController.appbarTitle = data?.product?.name ?? "未知标题";
        });
  }

  /// 检查是否可以下载大图
  void checkDownloadImage() {
    var data = productDetail.data;
    if (data != null) {
      var bigPic = data.brand?.bigPic;
      if (bigPic != null && bigPic.contains("/")) {
        var index = bigPic.lastIndexOf("/");
        var filename = bigPic.substring(index);
        download(
            urlPath: bigPic,
            filename: filename,
            onSuccess: (file) {
              showToast("下载成功: ${file?.path}");
            },
            onFailed: (e) {
              showToast("${e.message}");
              Log.d("下载失败", error: e);
              stateTxt.data = "下载图片";
            },
            onProgress: (progress, total) {
              Log.d("下载中 progress: $progress, total: $total");
              stateTxt.data =
                  "${(progress * 100.0 / total).toStringAsFixed(2)}%";
            });
      } else {
        showToast("图片资源异常，下载失败");
      }
    }
  }
}
