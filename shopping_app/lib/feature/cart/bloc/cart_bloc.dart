import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shopping_app/feature/cart/models/cart.dart';
import 'package:shopping_app/feature/cart/models/cart_item.dart';
import 'package:shopping_app/feature/cart/repository/cart_repository.dart';
import 'package:shopping_app/feature/cart/repository/cart_repository_local.dart';
import 'package:shopping_app/feature/discover/model/product.dart';

part 'cart_event.dart';

part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartRepository _cartRepositoryLocal;

  CartBloc()
      : _cartRepositoryLocal = CartRepositoryLocal(),
        super(CartInit());

  @override
  Stream<CartState> mapEventToState(
    CartEvent event,
  ) async* {
    if (event is CartLoadingEvent) {
      yield* _mapCartUpdatedEventToState(event);
    } else if (event is IncreaseQuantityCartItem) {
      yield* _mapCartIncreaseQuantityEventToState(event);
    } else if (event is DecreaseQuantityCartItem) {
      yield* _mapCartDecreaseQuantityEventToState(event);
    } else if (event is RemoveCartItem) {
      yield* _mapRemoveCartItemEventToState(event);
    }
  }

  Stream<CartState> _mapCartUpdatedEventToState(CartEvent event) async* {
    var result = await _cartRepositoryLocal.getCartItems();
    yield CartLoadFinished(result);
  }

  Stream<CartState> _mapCartIncreaseQuantityEventToState(
      IncreaseQuantityCartItem event) async* {
    await _cartRepositoryLocal.increaseQuantity(event.product);
    var result = await _cartRepositoryLocal.getCartItems();
    yield CartLoadFinished(result);
  }

  Stream<CartState> _mapCartDecreaseQuantityEventToState(
      DecreaseQuantityCartItem event) async* {
    await _cartRepositoryLocal.decreaseQuantity(event.cartItem, event.quantity);
    var result = await _cartRepositoryLocal.getCartItems();
    yield CartLoadFinished(result);
  }

  Stream<CartState> _mapRemoveCartItemEventToState(
      RemoveCartItem event) async* {
    await _cartRepositoryLocal.removeCartItem(event.cartItem);
    var result = await _cartRepositoryLocal.getCartItems();
    yield CartLoadFinished(result);
  }
}
