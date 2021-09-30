

import 'package:shopping_app/feature/cart/models/cart.dart';
import 'package:shopping_app/feature/cart/models/cart_item.dart';
import 'package:shopping_app/feature/discover/model/product.dart';

abstract class CartRepository {

  Future<Cart> getCartItems();
  Future<void> increaseQuantity(Product product);
  Future<void> decreaseQuantity(CartItem cartItem, int quantity);
  Future<void> removeCartItem(CartItem cartItem);
}
