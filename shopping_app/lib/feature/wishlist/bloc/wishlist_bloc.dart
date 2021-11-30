import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shopping_app/feature/discover/model/product.dart';
import 'package:shopping_app/feature/discover/repository/discover_repository.dart';
import 'package:shopping_app/feature/discover/repository/firebase_discover_repository.dart';
part 'wishlist_state.dart';
part 'wishlist_event.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  DiscoverRepository _discoverRepository;
  StreamSubscription _streamSubscription;

  WishlistBloc()
      : _discoverRepository = FirebaseDiscoverRepository(), super(WishlistLoading());

  @override
  Stream<WishlistState> mapEventToState(
      WishlistEvent event,
      ) async* {
    if (event is LoadingWishlistEvent) {
      yield* _mapLoadWishlistEvent(event);
    } else if (event is WishlistUpdatedEvent) {
      yield* _mapWishlistUpdatedEventToState(event);
    }
  }

  @override
  Future<void> close() {
    _streamSubscription.cancel();
    return super.close();
  }

  Stream<WishlistState> _mapLoadWishlistEvent(
      LoadingWishlistEvent event) async* {
    List<Product> productList =
    await _discoverRepository.getSearchProduct(event.query);

    yield WishlistLoadFinished(products: productList, isSuccess: true);
  }

  Stream<WishlistState> _mapWishlistUpdatedEventToState(
      WishlistUpdatedEvent event) async* {
    yield WishlistLoadFinished(products: event.products, isSuccess: true);
  }
}
