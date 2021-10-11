import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shopping_app/feature/discover/model/product.dart';
import 'package:shopping_app/feature/discover/repository/discover_repository.dart';
import 'package:shopping_app/feature/discover/repository/firebase_discover_repository.dart';

part 'discover_event.dart';

part 'discover_state.dart';

class DiscoverBloc extends Bloc<DiscoverEvent, DiscoverState> {
  DiscoverRepository _discoverRepository;
  StreamSubscription _streamSubscription;

  DiscoverBloc()
      : _discoverRepository = FirebaseDiscoverRepository(),
        super(DiscoverLoading());

  @override
  Stream<DiscoverState> mapEventToState(
    DiscoverEvent event,
  ) async* {
    if (event is LoadingDiscoverEvent) {
      yield* _mapLoadDiscoverEvent(event);
    } else if (event is LoadingOnSaleEvent) {
      yield* _mapLoadOnSaleEvent(event);
    } else if (event is DiscoverUpdatedEvent) {
      yield* _mapDiscoverUpdatedEventToState(event);
    } else if (event is LoadingWishlistEvent) {
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

  Stream<DiscoverState> _mapLoadDiscoverEvent(
      LoadingDiscoverEvent event) async* {
    yield StartDiscoverLoad();

    List<Product> productList = await _discoverRepository.getListProduct(
        event.category);
    List<Product> salesList = await _discoverRepository.getOnSaleProducts();
    List<Product> prize = await _discoverRepository.getPrizeProduct();
    String cartId = await _discoverRepository.createCart();

    yield DiscoverLoadFinished(
        products: productList,
        onSale: salesList,
        cartId: cartId,
        prize: prize.first,
        isSuccess: true);
  }

  Stream<DiscoverState> _mapLoadOnSaleEvent(LoadingOnSaleEvent event) async* {
    List<Product> productList = await _discoverRepository.getOnSaleProducts();
    yield DiscoverLoadOnSaleFinished(products: productList, isSuccess: true);
  }

  Stream<DiscoverState> _mapDiscoverUpdatedEventToState(
      DiscoverUpdatedEvent event) async* {
    // var filterList = event.products.where((element) {
    //   return element.productType == event.productType &&
    //       element.category == event.category;
    // }).toList();
    const filterList = [];
    yield DiscoverLoadFinished(products: filterList, isSuccess: true);
  }

  Stream<DiscoverState> _mapLoadWishlistEvent(
      LoadingWishlistEvent event) async* {
    List<Product> productList =
        await _discoverRepository.getSearchProduct(event.query);

    yield WishlistLoadFinished(products: productList, isSuccess: true);
  }

  Stream<DiscoverState> _mapWishlistUpdatedEventToState(
      WishlistUpdatedEvent event) async* {
    yield WishlistLoadFinished(products: event.products, isSuccess: true);
  }
}
