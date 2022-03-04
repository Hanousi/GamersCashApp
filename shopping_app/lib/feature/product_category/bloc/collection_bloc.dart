import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shopping_app/feature/discover/model/product.dart';
import 'package:shopping_app/feature/discover/repository/discover_repository.dart';
import 'package:shopping_app/feature/discover/repository/firebase_discover_repository.dart';

part 'collection_event.dart';

part 'collection_state.dart';

class CollectionBloc extends Bloc<CollectionEvent, CollectionState> {
  DiscoverRepository _discoverRepository;
  StreamSubscription _streamSubscription;

  CollectionBloc()
      : _discoverRepository = FirebaseDiscoverRepository(),
        super(CollectionLoading());

  @override
  Stream<CollectionState> mapEventToState(
      CollectionEvent event,
  ) async* {
    if (event is LoadingCollectionEvent) {
      yield* _mapLoadCollectionEvent(event);
    }
  }

  @override
  Future<void> close() {
    _streamSubscription.cancel();
    return super.close();
  }

  Stream<CollectionState> _mapLoadCollectionEvent(
      LoadingCollectionEvent event) async* {
    yield StartCollectionLoad();

    List<Product> collection = await _discoverRepository.getListProduct(event.collection);

    yield CollectionFinished(
        products: collection,
        isSuccess: true);
  }
}
