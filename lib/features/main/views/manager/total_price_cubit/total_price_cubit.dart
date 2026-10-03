import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'total_price_state.dart';

class TotalPriceCubit extends Cubit<TotalPriceState> {
  TotalPriceCubit() : super(TotalPriceInitial());

  static TotalPriceCubit get(BuildContext context) {
    return BlocProvider.of(context);
  }

  double totalPrice = 0;
  bool isCash = false;

  changeCash(bool status) {
    isCash = status;
    emit(TotalPriceInitial());
  }

  addTotalPrice(double? price, {bool withEmit = true}) {
    if (price != null) {
      totalPrice += price;
    } else {
      totalPrice = 0;
    }
    if (withEmit) emit(TotalPriceInitial());

    Future.delayed(Duration(milliseconds: 500), () {
      emit(TotalPriceInitial());
    });
  }
}
