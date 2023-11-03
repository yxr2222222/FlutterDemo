import 'package:json_annotation/json_annotation.dart';

part 'product_detail.g.dart';

@JsonSerializable()
class ProductDetail {
  final Product? product;
  final Brand? brand;
  final List<ProductAttributeList>? productAttributeList;
  final List<ProductAttributeValueList>? productAttributeValueList;
  final List<SkuStockList>? skuStockList;
  final List<CouponList>? couponList;

  const ProductDetail({
    this.product,
    this.brand,
    this.productAttributeList,
    this.productAttributeValueList,
    this.skuStockList,
    this.couponList,
  });

  factory ProductDetail.fromJson(Map<String, dynamic> json) =>
      _$ProductDetailFromJson(json);

  Map<String, dynamic> toJson() => _$ProductDetailToJson(this);
}

@JsonSerializable()
class Product {
  final int? id;
  final int? brandId;
  final int? productCategoryId;
  final int? feightTemplateId;
  final int? productAttributeCategoryId;
  final String? name;
  final String? pic;
  final String? productSn;
  final int? deleteStatus;
  final int? publishStatus;
  final int? newStatus;
  final int? recommandStatus;
  final int? verifyStatus;
  final int? sort;
  final int? sale;
  final double? price;
  final double? promotionPrice;
  final int? giftGrowth;
  final int? giftPoint;
  final int? usePointLimit;
  final String? subTitle;
  final double? originalPrice;
  final int? stock;
  final int? lowStock;
  final String? unit;
  final double? weight;
  final int? previewStatus;
  final String? serviceIds;
  final String? keywords;
  final String? note;
  final String? albumPics;
  final String? detailTitle;
  final String? promotionStartTime;
  final String? promotionEndTime;
  final int? promotionPerLimit;
  final int? promotionType;
  final String? brandName;
  final String? productCategoryName;
  final String? description;
  final String? detailDesc;
  final String? detailHtml;
  final String? detailMobileHtml;

  const Product({
    this.id,
    this.brandId,
    this.productCategoryId,
    this.feightTemplateId,
    this.productAttributeCategoryId,
    this.name,
    this.pic,
    this.productSn,
    this.deleteStatus,
    this.publishStatus,
    this.newStatus,
    this.recommandStatus,
    this.verifyStatus,
    this.sort,
    this.sale,
    this.price,
    this.promotionPrice,
    this.giftGrowth,
    this.giftPoint,
    this.usePointLimit,
    this.subTitle,
    this.originalPrice,
    this.stock,
    this.lowStock,
    this.unit,
    this.weight,
    this.previewStatus,
    this.serviceIds,
    this.keywords,
    this.note,
    this.albumPics,
    this.detailTitle,
    this.promotionStartTime,
    this.promotionEndTime,
    this.promotionPerLimit,
    this.promotionType,
    this.brandName,
    this.productCategoryName,
    this.description,
    this.detailDesc,
    this.detailHtml,
    this.detailMobileHtml,
  });

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);
}

@JsonSerializable()
class Brand {
  final int? id;
  final String? name;
  final String? firstLetter;
  final int? sort;
  final int? factoryStatus;
  final int? showStatus;
  final int? productCount;
  final int? productCommentCount;
  final String? logo;
  final String? bigPic;
  final String? brandStory;

  const Brand({
    this.id,
    this.name,
    this.firstLetter,
    this.sort,
    this.factoryStatus,
    this.showStatus,
    this.productCount,
    this.productCommentCount,
    this.logo,
    this.bigPic,
    this.brandStory,
  });

  factory Brand.fromJson(Map<String, dynamic> json) =>
      _$BrandFromJson(json);

  Map<String, dynamic> toJson() => _$BrandToJson(this);
}

@JsonSerializable()
class ProductAttributeList {
  final int? id;
  final int? productAttributeCategoryId;
  final String? name;
  final int? selectType;
  final int? inputType;
  final String? inputList;
  final int? sort;
  final int? filterType;
  final int? searchType;
  final int? relatedStatus;
  final int? handAddStatus;
  final int? type;

  const ProductAttributeList({
    this.id,
    this.productAttributeCategoryId,
    this.name,
    this.selectType,
    this.inputType,
    this.inputList,
    this.sort,
    this.filterType,
    this.searchType,
    this.relatedStatus,
    this.handAddStatus,
    this.type,
  });

  factory ProductAttributeList.fromJson(Map<String, dynamic> json) =>
      _$ProductAttributeListFromJson(json);

  Map<String, dynamic> toJson() => _$ProductAttributeListToJson(this);
}

@JsonSerializable()
class ProductAttributeValueList {
  final int? id;
  final int? productId;
  final int? productAttributeId;
  final String? value;

  const ProductAttributeValueList({
    this.id,
    this.productId,
    this.productAttributeId,
    this.value,
  });

  factory ProductAttributeValueList.fromJson(Map<String, dynamic> json) =>
      _$ProductAttributeValueListFromJson(json);

  Map<String, dynamic> toJson() => _$ProductAttributeValueListToJson(this);
}

@JsonSerializable()
class SkuStockList {
  final int? id;
  final int? productId;
  final String? skuCode;
  final double? price;
  final int? stock;
  final double? promotionPrice;
  final int? lockStock;
  final String? spData;

  const SkuStockList({
    this.id,
    this.productId,
    this.skuCode,
    this.price,
    this.stock,
    this.promotionPrice,
    this.lockStock,
    this.spData,
  });

  factory SkuStockList.fromJson(Map<String, dynamic> json) =>
      _$SkuStockListFromJson(json);

  Map<String, dynamic> toJson() => _$SkuStockListToJson(this);
}

@JsonSerializable()
class CouponList {
  final int? id;
  final int? type;
  final String? name;
  final int? platform;
  final int? count;
  final double? amount;
  final int? perLimit;
  final double? minPoint;
  final String? startTime;
  final String? endTime;
  final int? useType;
  final int? publishCount;
  final int? useCount;
  final int? receiveCount;
  final String? enableTime;

  const CouponList({
    this.id,
    this.type,
    this.name,
    this.platform,
    this.count,
    this.amount,
    this.perLimit,
    this.minPoint,
    this.startTime,
    this.endTime,
    this.useType,
    this.publishCount,
    this.useCount,
    this.receiveCount,
    this.enableTime,
  });

  factory CouponList.fromJson(Map<String, dynamic> json) =>
      _$CouponListFromJson(json);

  Map<String, dynamic> toJson() => _$CouponListToJson(this);
}
