import 'package:shopping_app/feature/cart/models/cart_item.dart';

class Cart {
  List<CartItem> listCartItem = [];
  String url;

  Cart(this.listCartItem, this.url);

  double getTotalPrice() {
    double sum = 0;
    listCartItem.forEach((element) {
      sum += (element.quantity * double.parse(element.product.price));
    });

    return sum;
  }
}
