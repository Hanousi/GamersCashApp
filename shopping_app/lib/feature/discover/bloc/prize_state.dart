part of 'prize_bloc.dart';

abstract class PrizeState extends Equatable {
  const PrizeState();

  @override
  List<Object> get props => [];
}

class PrizeLoading extends PrizeState {}

class DiscoverPrizeFinished extends PrizeState {
  final bool isSuccess;
  final Product prize;

  DiscoverPrizeFinished({this.isSuccess = false, this.prize});
}

class StartPrizeLoad extends PrizeState {}
