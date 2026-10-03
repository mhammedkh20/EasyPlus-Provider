import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'tracking_state.dart';

class TrackingCubit extends Cubit<TrackingState> {
  TrackingCubit() : super(TrackingInitial());

  static TrackingCubit get(BuildContext context) {
    return BlocProvider.of(context);
  }

  int indexSelectedTrip = 0;

  changeSelectedTrip(int index) {
    indexSelectedTrip = index;
    emit(TrackingInitial());
  }
}
