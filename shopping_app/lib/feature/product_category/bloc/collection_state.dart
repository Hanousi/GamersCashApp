part of 'collection_bloc.dart';

abstract class CollectionState extends Equatable {
  const CollectionState();

  @override
  List<Object> get props => [];
}

class CollectionLoading extends CollectionState {}

class CollectionFinished extends CollectionState {
  final bool isSuccess;
  final List<Product> products;

  CollectionFinished({this.isSuccess = false, this.products});
}

class StartCollectionLoad extends CollectionState {}
