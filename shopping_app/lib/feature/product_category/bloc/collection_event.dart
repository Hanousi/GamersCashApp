part of 'collection_bloc.dart';

abstract class CollectionEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadingCollectionEvent extends CollectionEvent {
  final String collection;

  LoadingCollectionEvent({this.collection});

  @override
  List<Object> get props => [collection];
}