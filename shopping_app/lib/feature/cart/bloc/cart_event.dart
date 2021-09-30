part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class CartItemUpdated extends CartEvent {
  final List<CartItem> cartItems;

  CartItemUpdated(this.cartItems);

  @override
  List<Object> get props => [cartItems];
}

class CartLoadingEvent extends CartEvent {
}
class RemoveCartItem extends CartEvent {
  final CartItem cartItem;

  RemoveCartItem(this.cartItem);

  @override
  List<Object> get props => [cartItem];
}

class IncreaseQuantityCartItem extends CartEvent {
  final Product product;

  IncreaseQuantityCartItem(this.product);

  @override
  List<Object> get props => [product];
}

class DecreaseQuantityCartItem extends CartEvent {
  final CartItem cartItem;
  final int quantity;

  DecreaseQuantityCartItem(this.cartItem, this.quantity);

  @override
  List<Object> get props => [cartItem, quantity];
}

