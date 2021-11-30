part of 'wishlist_bloc.dart';

abstract class WishlistEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadingWishlistEvent extends WishlistEvent {
  final String query;

  LoadingWishlistEvent({this.query});

  @override
  List<Object> get props => [query];
}

class WishlistUpdatedEvent extends WishlistEvent {
  final List<Product> products;

  WishlistUpdatedEvent({this.products});


  @override
  List<Object> get props => [products,];
}
