import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'calender_state.dart';

class CalenderCubit extends Cubit<CalenderState> {
  CalenderCubit() : super(CalenderInitial());

  void changeDate(DateTime date) {
    emit(CalenderLoaded(selectedDate: date));
  }
}
