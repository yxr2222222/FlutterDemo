// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductDetail _$ProductDetailFromJson(Map<String, dynamic> json) =>
    ProductDetail(
      product: json['product'] == null
          ? null
          : Product.fromJson(json['product'] as Map<String, dynamic>),
      brand: json['brand'] == null
          ? null
          : Brand.fromJson(json['brand'] as Map<String, dynamic>),
      productAttributeList: (json['productAttributeList'] as List<dynamic>?)
          ?.map((e) => ProductAttributeList.fromJson(e as Map<String, dynamic>))
          .toList(),
      productAttributeValueList:
          (json['productAttributeValueList'] as List<dynamic>?)
              ?.map((e) =>
                  ProductAttributeValueList.fromJson(e as Map<String, dynamic>))
              .toList(),
      skuStockList: (json['skuStockList'] as List<dynamic>?)
          ?.map((e) => SkuStockList.fromJson(e as Map<String, dynamic>))
          .toList(),
      couponList: (json['couponList'] as List<dynamic>?)
          ?.map((e) => CouponList.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ProductDetailToJson(ProductDetail instance) =>
    <String, dynamic>{
      'product': instance.product,
      'brand': instance.brand,
      'productAttributeList': instance.productAttributeList,
      'productAttributeValueList': instance.productAttributeValueList,
      'skuStockList': instance.skuStockList,
      'couponList': instance.couponList,
    };

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
      id: json['id'] as int?,
      brandId: json['brandId'] as int?,
      productCategoryId: json['productCategoryId'] as int?,
      feightTemplateId: json['feightTemplateId'] as int?,
      productAttributeCategoryId: json['productAttributeCategoryId'] as int?,
      name: json['name'] as String?,
      pic: json['pic'] as String?,
      productSn: json['productSn'] as String?,
      deleteStatus: json['deleteStatus'] as int?,
      publishStatus: json['publishStatus'] as int?,
      newStatus: json['newStatus'] as int?,
      recommandStatus: json['recommandStatus'] as int?,
      verifyStatus: json['verifyStatus'] as int?,
      sort: json['sort'] as int?,
      sale: json['sale'] as int?,
      price: json['price'] as double?,
      promotionPrice: json['promotionPrice'] as double?,
      giftGrowth: json['giftGrowth'] as int?,
      giftPoint: json['giftPoint'] as int?,
      usePointLimit: json['usePointLimit'] as int?,
      subTitle: json['subTitle'] as String?,
      originalPrice: json['originalPrice'] as double?,
      stock: json['stock'] as int?,
      lowStock: json['lowStock'] as int?,
      unit: json['unit'] as String?,
      weight: json['weight'] as double?,
      previewStatus: json['previewStatus'] as int?,
      serviceIds: json['serviceIds'] as String?,
      keywords: json['keywords'] as String?,
      note: json['note'] as String?,
      albumPics: json['albumPics'] as String?,
      detailTitle: json['detailTitle'] as String?,
      promotionStartTime: json['promotionStartTime'] as String?,
      promotionEndTime: json['promotionEndTime'] as String?,
      promotionPerLimit: json['promotionPerLimit'] as int?,
      promotionType: json['promotionType'] as int?,
      brandName: json['brandName'] as String?,
      productCategoryName: json['productCategoryName'] as String?,
      description: json['description'] as String?,
      detailDesc: json['detailDesc'] as String?,
      detailHtml: json['detailHtml'] as String?,
      detailMobileHtml: json['detailMobileHtml'] as String?,
    );

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'id': instance.id,
      'brandId': instance.brandId,
      'productCategoryId': instance.productCategoryId,
      'feightTemplateId': instance.feightTemplateId,
      'productAttributeCategoryId': instance.productAttributeCategoryId,
      'name': instance.name,
      'pic': instance.pic,
      'productSn': instance.productSn,
      'deleteStatus': instance.deleteStatus,
      'publishStatus': instance.publishStatus,
      'newStatus': instance.newStatus,
      'recommandStatus': instance.recommandStatus,
      'verifyStatus': instance.verifyStatus,
      'sort': instance.sort,
      'sale': instance.sale,
      'price': instance.price,
      'promotionPrice': instance.promotionPrice,
      'giftGrowth': instance.giftGrowth,
      'giftPoint': instance.giftPoint,
      'usePointLimit': instance.usePointLimit,
      'subTitle': instance.subTitle,
      'originalPrice': instance.originalPrice,
      'stock': instance.stock,
      'lowStock': instance.lowStock,
      'unit': instance.unit,
      'weight': instance.weight,
      'previewStatus': instance.previewStatus,
      'serviceIds': instance.serviceIds,
      'keywords': instance.keywords,
      'note': instance.note,
      'albumPics': instance.albumPics,
      'detailTitle': instance.detailTitle,
      'promotionStartTime': instance.promotionStartTime,
      'promotionEndTime': instance.promotionEndTime,
      'promotionPerLimit': instance.promotionPerLimit,
      'promotionType': instance.promotionType,
      'brandName': instance.brandName,
      'productCategoryName': instance.productCategoryName,
      'description': instance.description,
      'detailDesc': instance.detailDesc,
      'detailHtml': instance.detailHtml,
      'detailMobileHtml': instance.detailMobileHtml,
    };

Brand _$BrandFromJson(Map<String, dynamic> json) => Brand(
      id: json['id'] as int?,
      name: json['name'] as String?,
      firstLetter: json['firstLetter'] as String?,
      sort: json['sort'] as int?,
      factoryStatus: json['factoryStatus'] as int?,
      showStatus: json['showStatus'] as int?,
      productCount: json['productCount'] as int?,
      productCommentCount: json['productCommentCount'] as int?,
      logo: json['logo'] as String?,
      bigPic: json['bigPic'] as String?,
      brandStory: json['brandStory'] as String?,
    );

Map<String, dynamic> _$BrandToJson(Brand instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'firstLetter': instance.firstLetter,
      'sort': instance.sort,
      'factoryStatus': instance.factoryStatus,
      'showStatus': instance.showStatus,
      'productCount': instance.productCount,
      'productCommentCount': instance.productCommentCount,
      'logo': instance.logo,
      'bigPic': instance.bigPic,
      'brandStory': instance.brandStory,
    };

ProductAttributeList _$ProductAttributeListFromJson(
        Map<String, dynamic> json) =>
    ProductAttributeList(
      id: json['id'] as int?,
      productAttributeCategoryId: json['productAttributeCategoryId'] as int?,
      name: json['name'] as String?,
      selectType: json['selectType'] as int?,
      inputType: json['inputType'] as int?,
      inputList: json['inputList'] as String?,
      sort: json['sort'] as int?,
      filterType: json['filterType'] as int?,
      searchType: json['searchType'] as int?,
      relatedStatus: json['relatedStatus'] as int?,
      handAddStatus: json['handAddStatus'] as int?,
      type: json['type'] as int?,
    );

Map<String, dynamic> _$ProductAttributeListToJson(
        ProductAttributeList instance) =>
    <String, dynamic>{
      'id': instance.id,
      'productAttributeCategoryId': instance.productAttributeCategoryId,
      'name': instance.name,
      'selectType': instance.selectType,
      'inputType': instance.inputType,
      'inputList': instance.inputList,
      'sort': instance.sort,
      'filterType': instance.filterType,
      'searchType': instance.searchType,
      'relatedStatus': instance.relatedStatus,
      'handAddStatus': instance.handAddStatus,
      'type': instance.type,
    };

ProductAttributeValueList _$ProductAttributeValueListFromJson(
        Map<String, dynamic> json) =>
    ProductAttributeValueList(
      id: json['id'] as int?,
      productId: json['productId'] as int?,
      productAttributeId: json['productAttributeId'] as int?,
      value: json['value'] as String?,
    );

Map<String, dynamic> _$ProductAttributeValueListToJson(
        ProductAttributeValueList instance) =>
    <String, dynamic>{
      'id': instance.id,
      'productId': instance.productId,
      'productAttributeId': instance.productAttributeId,
      'value': instance.value,
    };

SkuStockList _$SkuStockListFromJson(Map<String, dynamic> json) => SkuStockList(
      id: json['id'] as int?,
      productId: json['productId'] as int?,
      skuCode: json['skuCode'] as String?,
      price: json['price'] as double?,
      stock: json['stock'] as int?,
      promotionPrice: json['promotionPrice'] as double?,
      lockStock: json['lockStock'] as int?,
      spData: json['spData'] as String?,
    );

Map<String, dynamic> _$SkuStockListToJson(SkuStockList instance) =>
    <String, dynamic>{
      'id': instance.id,
      'productId': instance.productId,
      'skuCode': instance.skuCode,
      'price': instance.price,
      'stock': instance.stock,
      'promotionPrice': instance.promotionPrice,
      'lockStock': instance.lockStock,
      'spData': instance.spData,
    };

CouponList _$CouponListFromJson(Map<String, dynamic> json) => CouponList(
      id: json['id'] as int?,
      type: json['type'] as int?,
      name: json['name'] as String?,
      platform: json['platform'] as int?,
      count: json['count'] as int?,
      amount: json['amount'] as double?,
      perLimit: json['perLimit'] as int?,
      minPoint: json['minPoint'] as double?,
      startTime: json['startTime'] as String?,
      endTime: json['endTime'] as String?,
      useType: json['useType'] as int?,
      publishCount: json['publishCount'] as int?,
      useCount: json['useCount'] as int?,
      receiveCount: json['receiveCount'] as int?,
      enableTime: json['enableTime'] as String?,
    );

Map<String, dynamic> _$CouponListToJson(CouponList instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'name': instance.name,
      'platform': instance.platform,
      'count': instance.count,
      'amount': instance.amount,
      'perLimit': instance.perLimit,
      'minPoint': instance.minPoint,
      'startTime': instance.startTime,
      'endTime': instance.endTime,
      'useType': instance.useType,
      'publishCount': instance.publishCount,
      'useCount': instance.useCount,
      'receiveCount': instance.receiveCount,
      'enableTime': instance.enableTime,
    };
