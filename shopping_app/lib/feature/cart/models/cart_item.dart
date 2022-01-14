import 'package:flutter/cupertino.dart';
import 'package:shopping_app/feature/discover/model/product.dart';

class CartItem {
  final String id;
  int quantity;
  Widget cartQuantity;
  Product product;

  CartItem({this.id, this.quantity, this.cartQuantity, this.product});

  Map<String, dynamic> toMap() {
    return {'quantity': quantity, 'product_id': product.id};
  }


}
