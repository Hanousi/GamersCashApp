import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shopping_app/feature/discover/model/product.dart';
import 'package:shopping_app/feature/discover/repository/discover_repository.dart';
import 'package:shopping_app/feature/discover/repository/firebase_discover_repository.dart';

part 'prize_event.dart';

part 'prize_state.dart';

class PrizeBloc extends Bloc<PrizeEvent, PrizeState> {
  DiscoverRepository _discoverRepository;
  StreamSubscription _streamSubscription;

  PrizeBloc()
      : _discoverRepository = FirebaseDiscoverRepository(),
        super(PrizeLoading());

  @override
  Stream<PrizeState> mapEventToState(PrizeEvent event,) async* {
    if (event is LoadingPrizeEvent) {
      yield* _mapLoadPrizeEvent(event);
    }
  }

  @override
  Future<void> close() {
    _streamSubscription.cancel();
    return super.close();
  }

  Stream<PrizeState> _mapLoadPrizeEvent(LoadingPrizeEvent event) async* {
    yield StartPrizeLoad();

    List<Product> prize = await _discoverRepository.getPrizeProduct();
    var competitionDate = prize[1].description != ''
        ? prize[1].description.split('/')
        : null;

    yield DiscoverPrizeFinished(
        prize: prize.first,
        duration: competitionDate != null ? DateTime.utc(
            int.parse(competitionDate[0]),
            int.parse(competitionDate[1]), int.parse(competitionDate[2]))
            .difference(DateTime.now()) : null,
        lastWinner: prize[2].description != '' ? prize[2].description : null,
        isSuccess: true);
  }
}
