part of 'calender_cubit.dart';

@immutable
sealed class CalenderState {}

final class CalenderInitial extends CalenderState {}

final class CalenderLoaded extends CalenderState {
  final DateTime selectedDate;

  CalenderLoaded({required this.selectedDate});
}
