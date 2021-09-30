import 'package:shopping_app/db/db_provider.dart';
import 'package:shopping_app/feature/cart/models/cart.dart';
import 'package:shopping_app/feature/cart/models/cart_item.dart';
import 'package:shopping_app/feature/discover/model/product.dart';
import 'package:shopping_app/feature/helpers/shopify_store.dart';
import 'package:sqflite_common/sqlite_api.dart';

import 'cart_repository.dart';

class CartRepositoryLocal extends CartRepository {
  @override
  Future<Cart> getCartItems() async {
    try {
      ShopifyStore shopifyStore = ShopifyStore.instance;
      return await shopifyStore.getCart();
    } catch(e) {
      print(e);
    }
  }

  Future<void> increaseQuantity(Product product) async {
    try {
      ShopifyStore shopifyStore = ShopifyStore.instance;
      return await shopifyStore.addToCart(product.merchandiseId);
    } catch(e) {
      print(e);
    }
  }

  Future<void> decreaseQuantity(CartItem cartItem, int quantity) async {
    try {
      ShopifyStore shopifyStore = ShopifyStore.instance;
      return await shopifyStore.updateCartItem(cartItem.id, quantity);
    } catch(e) {
      print(e);
    }
  }

  Future<void> removeCartItem(CartItem cartItem) async {
    try {
      ShopifyStore shopifyStore = ShopifyStore.instance;
      return await shopifyStore.removeFromCart(cartItem.id);
    } catch(e) {
      print(e);
    }
  }
}
