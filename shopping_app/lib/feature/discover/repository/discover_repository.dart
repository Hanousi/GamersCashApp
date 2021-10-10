import 'package:shopping_app/feature/discover/model/product.dart';

abstract class DiscoverRepository {

  Future<List<Product>> getListProduct(String tag1, String tag2);
  Future<List<Product>> getSearchProduct(String query);
  Future<List<Product>> getOnSaleProducts();
  Future<List<Product>> getPrizeProduct();
  Future<String> createCart();
  Future<void> addListProduct(List<Product> products);

}
