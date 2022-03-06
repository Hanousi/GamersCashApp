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
  final Duration duration;
  final String lastWinner;

  DiscoverPrizeFinished({this.isSuccess = false, this.prize, this.duration, this.lastWinner});
}

class StartPrizeLoad extends PrizeState {}
