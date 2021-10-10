import 'package:shopping_app/feature/discover/model/product.dart';
import 'package:shopping_app/feature/discover/repository/discover_repository.dart';
import 'package:shopping_app/feature/helpers/shopify_store.dart';

class FirebaseDiscoverRepository extends DiscoverRepository {
  final discoverCollection = [];

  @override
  Future<List<Product>> getListProduct(String tag1, String tag2) async {
    try {
      ShopifyStore shopifyStore = ShopifyStore.instance;
      return await shopifyStore.getNProducts(6, "tag:${tag1} AND tag:${tag2}");
    } catch (e) {
      print(e);
    }
  }

  @override
  Future<List<Product>> getPrizeProduct() async {
    try {
      ShopifyStore shopifyStore = ShopifyStore.instance;
      return await shopifyStore.getPrizeProduct();
    } catch (e) {
      print(e);
    }
  }

  @override
  Future<List<Product>> getSearchProduct(String query) async {
    try {
      ShopifyStore shopifyStore = ShopifyStore.instance;
      return await shopifyStore.getNProducts(30, "title: ${query} AND available_for_sale:true");
    } catch (e) {
      print(e);
    }
  }

  @override
  Future<String> createCart() async {
    try {
      ShopifyStore shopifyStore = ShopifyStore.instance;
      return await shopifyStore.createCart();
    } catch (e) {
      print(e);
    }
  }

  Future<List<Product>> getOnSaleProducts() async {
    try {
      ShopifyStore shopifyStore = ShopifyStore.instance;
      return await shopifyStore.getOnSaleCollection();
    } catch (e) {
      print(e);
    }
  }

  @override
  Future<void> addListProduct(List<Product> products) async {
    products.forEach((element) {
      discoverCollection.add(element.toMap());
    });
  }
}
