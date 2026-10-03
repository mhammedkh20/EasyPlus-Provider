import 'package:easy_plus_service_provider/features/main/data/home_repo_imp.dart';
import 'package:easy_plus_service_provider/features/main/model/general_response.dart';
import 'package:easy_plus_service_provider/features/main/model/my_offers_response.dart';
import 'package:easy_plus_service_provider/features/main/model/order_response.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:bloc/bloc.dart';
import 'package:easy_plus_service_provider/features/main/model/offer2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'my_request_state.dart';

class MyRequestCubit extends Cubit<MyRequestState> {
  final HomeRepoImp _homeRepoImp = HomeRepoImp();

  MyRequestCubit() : super(MyRequestInitial());

  static MyRequestCubit get(BuildContext context) {
    return BlocProvider.of(context);
  }

  int indexStatusMyRequest = 0;
  changeStatusMyRequest(int index) {
    indexStatusMyRequest = index;
    emit(MyRequestInitial());
  }

  int indexOrderDetails = 0;
  changeOrderDetails(int index) {
    indexOrderDetails = index;
    emit(MyRequestInitial());
  }

  clearData({required bool withEmit}) {
    total = 0;
    page = 1;
    listOffers.clear();
    if (withEmit) {
      emit(MyRequestInitial());
    }
  }

  List<Offer> listOffers = [];
  int total = 0;
  int page = 1;
  Future getOffers(BuildContext context, {bool loadPagination = false}) async {
    if (loadPagination) {
      emit(MyOfferLoadingPagination());
      page++;
    } else {
      clearData(withEmit: false);
      emit(MyOfferLoading());
    }

    String status = '';
    if (indexStatusMyRequest == 0) {
      status = 'pending';
    }
    if (indexStatusMyRequest == 1) {
      status = 'accepted';
    }
    if (indexStatusMyRequest == 2) {
      status = 'done';
    }

    MyOffersResponse? responseData = await _homeRepoImp.getOffers(
      status,
      page,
    );

    if (responseData != null && responseData.status!) {
      total = responseData.meta!.total ?? 0;
      if (loadPagination) {
        listOffers.addAll(responseData.data ?? []);
      } else {
        listOffers = responseData.data ?? [];
      }

      emit(MyOfferSuccess(message: responseData.message!));
    }

    if (responseData == null) {
      emit(
        MyOfferFailed(
            message:
                AppLocalizations.of(context)!.anErrorOccurredPleaseTryAgain),
      );
    } else if (!responseData.status!) {
      emit(MyOfferFailed(message: responseData.message!));
    }
  }

  OrderResponse? dataOrderDetails;

  Future getOrderDetails(BuildContext context, String id) async {
    emit(OrderDetailsLoading());

    OrderResponse? responseData = await _homeRepoImp.getOrderDetails(id);

    if (responseData != null && responseData.status!) {
      dataOrderDetails = responseData;
      emit(OrderDetailsSuccess(message: responseData.message!));
    }

    if (responseData == null) {
      emit(
        OrderDetailsFailed(
            message:
                AppLocalizations.of(context)!.anErrorOccurredPleaseTryAgain),
      );
    } else if (!responseData.status!) {
      emit(OrderDetailsFailed(message: responseData.message!));
    }
  }

  Future mackOffer(
    BuildContext context, {
    required int orderId,
    required double price,
    required double tax,
    required int isCash,
  }) async {
    emit(MackOfferLoading());

    GeneralResponse? responseData = await _homeRepoImp.mackOffer(
      orderId,
      price,
      tax,
      isCash,
    );

    if (responseData != null && responseData.status!) {
      emit(MackOfferSuccess(message: responseData.message!));
    }

    if (responseData == null) {
      emit(
        MackOfferFailed(
            message:
                AppLocalizations.of(context)!.anErrorOccurredPleaseTryAgain),
      );
    } else if (!responseData.status!) {
      emit(MackOfferFailed(message: responseData.message!));
    }
  }

  Future cancelOrder(BuildContext context, int orderId) async {
    emit(CancelLoading());

    GeneralResponse? responseData = await _homeRepoImp.cancelOrder(orderId);

    if (responseData != null && responseData.status!) {
      int index =
          listOffers.indexWhere((element) => element.orderId == orderId);
      listOffers.removeAt(index);
      emit(CancelSuccess(message: responseData.message!));
    }

    if (responseData == null) {
      emit(
        CancelFailed(
            message:
                AppLocalizations.of(context)!.anErrorOccurredPleaseTryAgain),
      );
    } else if (!responseData.status!) {
      emit(CancelFailed(message: responseData.message!));
    }
  }
}
