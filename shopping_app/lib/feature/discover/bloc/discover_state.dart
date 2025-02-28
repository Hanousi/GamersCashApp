part of 'discover_bloc.dart';

abstract class DiscoverState extends Equatable {
  const DiscoverState();

  @override
  List<Object> get props => [];
}

class DiscoverLoading extends DiscoverState {}

class DiscoverLoadFinished extends DiscoverState {
  final bool isSuccess;
  final List<Product> products;
  final List<Product> onSale;
  final Product prize;
  final String cartId;

  DiscoverLoadFinished(
      {this.products = const [],
      this.isSuccess = false,
      this.cartId = '',
      this.prize,
      this.onSale = const []});

  @override
  List<Object> get props => [products.hashCode, isSuccess];

  @override
  String toString() {
    return 'DiscoverLoadFinished{products: $products}';
  }
}

class StartDiscoverLoad extends DiscoverState {}

class DiscoverLoadOnSaleFinished extends DiscoverState {
  final bool isSuccess;
  final List<Product> products;

  DiscoverLoadOnSaleFinished(
      {this.products = const [], this.isSuccess = false});

  @override
  List<Object> get props => [products.hashCode, isSuccess];

  @override
  String toString() {
    return 'DiscoverLoadOnSaleFinished{products: $products}';
  }
}
