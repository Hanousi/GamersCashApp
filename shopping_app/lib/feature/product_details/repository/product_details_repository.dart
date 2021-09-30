import 'package:shopping_app/db/db_provider.dart';
import 'package:shopping_app/feature/cart/models/cart_item.dart';
import 'package:shopping_app/feature/discover/model/product.dart';
import 'package:shopping_app/feature/helpers/shopify_store.dart';
import 'package:sqflite_common/sqlite_api.dart';

class ProductDetailsRepository {
  Database db;

  ProductDetailsRepository() {
    db = DBProvider.instance.database;
  }

  Future<int> insertProductToCart(Product product) async {
    try {
      ShopifyStore shopifyStore = ShopifyStore.instance;
      return await shopifyStore.addToCart(product.merchandiseId);
    } catch(e) {
      print(e);
    }
  }

  Future<void> addToWishlist(Product product) {
  }

  Future<Product> getProductDetails(String id) async {
  }

  Product _productListFromSnapshot(String doc) {
  }

/*  Future<void> query() async{
    var result = await db.query(DBProvider.TABLE_PRODUCT);
    print('------------ $result');
    var result1 = await db.query(DBProvider.TABLE_CART_ITEMS);
    print('------------ $result1');
  }*/
}
