import 'dart:convert';

import 'package:shopping_app/resources/R.dart';

class ProductType {
  static const UPCOMMING = 'قريبا';
  static const FEATURED = 'الأكثر طلب';
  static const NEW = 'جديد';

  static List<String> values() => [NEW, FEATURED, UPCOMMING];
}

class ShopifyImage {
  final String originalSource;

  const ShopifyImage({this.originalSource});

  static ShopifyImage fromJson(Map<String, dynamic> json) {
    return ShopifyImage(originalSource: json['originalSrc']);
  }
}

class Collections {
  final List<Product> productList;
  final bool hasNextPage;

  Collections({this.productList, this.hasNextPage});

  static Products fromJson(Map<String, dynamic> json) {
    return Products(
        productList: _getProductList(json['edges'][0]['node']['products']),
        hasNextPage: (json['pageInfo'] ?? const {})['hasNextPage']);
  }

  static List<Product> _getProductList(Map<String, dynamic> json) {
    return (json['edges'] as List)
            ?.map((e) => Product.fromJson(e ?? const {}))
            ?.toList() ??
        const <Product>[];
  }
}

class Products {
  final List<Product> productList;
  final bool hasNextPage;

  Products({this.productList, this.hasNextPage});

  static Products fromJson(Map<String, dynamic> json) {
    return Products(
        productList: _getProductList(json),
        hasNextPage: (json['pageInfo'] ?? const {})['hasNextPage']);
  }

  static List<Product> _getProductList(Map<String, dynamic> json) {
    return (json['edges'] as List)
            ?.map((e) => Product.fromJson(e ?? const {}))
            ?.toList() ??
        const <Product>[];
  }
}

class Product {
  final String id;
  final String merchandiseId;
  final bool outOfStock;
  final List<dynamic> tags;
  String title, description, productType, compareAtPrice, price;
  List<ShopifyImage> images;

  Product({
    this.id,
    this.merchandiseId,
    this.images,
    this.title,
    this.price,
    this.tags,
    this.outOfStock,
    this.compareAtPrice,
    this.productType,
    this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      'images': images,
      'title': title,
      'price': price,
      'description': description.toString().split('.').last,
    };
  }

  static Product fromMap(Map<String, dynamic> map) {
    return Product(
        id: map['product_id'],
        images: List<ShopifyImage>.from(json.decode(map['images'])),
        title: map['title'],
        price: map['variants']['edges'][0]['node']['price'],
        description: map['description']);
  }

  static Product fromJson(Map<String, dynamic> json) {
    return Product(
        id: (json['node'] ?? const {})['id'],
        title: (json['node'] ?? const {})['title'],
        tags: _getTagList((json['node'] ?? const {})['tags']),
        description: (json['node'] ?? const {})['description'],
        price: (json['node'] ?? const {})['variants']['edges'][0]['node']
            ['price'],
        merchandiseId: (json['node'] ?? const {})['variants']['edges'][0]
            ['node']['id'],
        outOfStock: (json['node'] ?? const {})['variants']['edges'][0]
        ['node']['availableForSale'],
        compareAtPrice: (json['node'] ?? const {})['variants']['edges'][0]
            ['node']['compareAtPrice'],
        productType: (json['node'] ?? const {})['productType'],
        images:
            _getImageList((json['node'] ?? const {})['images'] ?? const {}));
  }

  static Product fromCartJson(Map<String, dynamic> json) {
    return Product(
        id: (json ?? const {})['id'],
        title: (json ?? const {})['title'],
        description: (json ?? const {})['description'],
        price: (json ?? const {})['variants']['edges'][0]['node']['price'],
        merchandiseId: (json ?? const {})['variants']['edges'][0]['node']['id'],
        compareAtPrice: (json ?? const {})['variants']['edges'][0]['node']
            ['compareAtPrice'],
        productType: (json ?? const {})['productType'],
        images: _getImageList((json ?? const {})['images'] ?? const {}));
  }

  static _getImageList(Map<String, dynamic> json) {
    List<ShopifyImage> imageList = [];
    if (json != null && json['edges'] != null) {
      json['edges'].forEach((image) =>
          imageList.add(ShopifyImage.fromJson(image['node'] ?? const {})));
    }
    return imageList;
  }

  static _getTagList(List<Object> list) {
    List<String> tagList = [];
    try {
      list.forEach((element) {
        tagList.add(element as String);
      });
    } catch (e) {
      return [];
    }
    return tagList;
  }

  Map<String, dynamic> toMapSql() {
    return {
      'product_id': id,
      'images': json.encode(images),
      'title': title,
      'price': price,
      'description': description,
    };
  }

  @override
  String toString() {
    return 'Product{id: $id, title: $title, description: $description, images: $images, price: $price}';
  }
}

List<String> categories = [
  'سماعات',
  'كيبوردات',
  'ماوسات',
  'كرسي وطاولة',
  'اكسسوارات و انارة للغرفة',
  'جميع اكسسوارات الكمبيوتر',
  'جميع اكسسوارات البلايستيشن',
  'ادوات تصوير و مايكات',
  'بطاقات'
];
