import 'package:shopping_app/feature/discover/model/product.dart';
import 'package:shopping_app/feature/discover/repository/discover_repository.dart';
import 'package:shopping_app/feature/helpers/shopify_store.dart';

class FirebaseDiscoverRepository extends DiscoverRepository {
  final discoverCollection = [];

  @override
  Future<List<Product>> getListProduct(String category) async {
    try {
      ShopifyStore shopifyStore = ShopifyStore.instance;
      return await shopifyStore.getNProductsFromCollection(250, category);
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
      return await shopifyStore.getNProducts(200, "title: ${query}");
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
