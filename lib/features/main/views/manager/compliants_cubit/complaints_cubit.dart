import 'package:easy_plus_service_provider/features/main/data/home_repo_imp.dart';
import 'package:easy_plus_service_provider/features/main/model/complaints.dart';
import 'package:easy_plus_service_provider/features/main/model/complaints_response.dart';
import 'package:easy_plus_service_provider/features/main/model/show_order_ids_response.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'complaints_state.dart';

class ComplaintsCubit extends Cubit<ComplaintsState> {
  final HomeRepoImp _homeRepoImp = HomeRepoImp();

  ComplaintsCubit() : super(ComplaintsInitial());

  static ComplaintsCubit get(BuildContext context) {
    return BlocProvider.of(context);
  }

  List<Complaints> listComplaints = [];

  int total = 0;
  int page = 1;

  clearData({required bool withEmit}) {
    total = 0;
    page = 1;
    listComplaints.clear();
    if (withEmit) {
      emit(ComplaintsInitial());
    }
  }

  Future getComplaints(
    BuildContext context, {
    bool loadPagination = false,
  }) async {
    if (loadPagination) {
      emit(ComplaintsLoadingPagination());
      page++;
    } else {
      clearData(withEmit: false);
      emit(ComplaintsLoading());
    }

    ComplaintsResponse? responseData =
        await _homeRepoImp.getComplaintsResponse(page: page);

    if (responseData != null && responseData.status!) {
      total = responseData.meta!.total ?? 0;
      listComplaints.addAll(responseData.complaints ?? []);

      emit(ComplaintsSuccess(message: responseData.message!));
    }

    if (responseData == null) {
      emit(
        ComplaintsFailed(
            message:
                AppLocalizations.of(context)!.anErrorOccurredPleaseTryAgain),
      );
    } else if (!responseData.status!) {
      emit(ComplaintsFailed(message: responseData.message!));
    }
  }

  addCompaint(Complaints data) {
    listComplaints.insert(0, data);
    emit(ComplaintsInitial());
  }

  Future sendComplaint(
    BuildContext context, {
    required String orderId,
    required String desc,
  }) async {
    emit(ComplaintPostLoading());

    ComplaintsResponse? responseData = await _homeRepoImp.sendComplaints(
      orderId: orderId,
      desc: desc,
    );

    if (responseData != null && responseData.status!) {
      emit(ComplaintPostSuccess(
          message: responseData.message!, complaint: responseData.object!));
    }

    if (responseData == null) {
      emit(
        ComplaintPostFailed(
            message:
                AppLocalizations.of(context)!.anErrorOccurredPleaseTryAgain),
      );
    } else if (!responseData.status!) {
      emit(ComplaintPostFailed(message: responseData.message!));
    }
  }

  List<int> orderIds = [];

  Future getShowOrderIds(
    BuildContext context,
  ) async {
    emit(OrderIdsLoading());

    ShowOrderIdsResponse? responseData = await _homeRepoImp.showOrderIds();

    if (responseData != null && responseData.status!) {
      orderIds.addAll(responseData.data ?? []);
      print(responseData.data!.length);
      emit(OrderIdsSuccess(message: responseData.message!));
    }

    if (responseData == null) {
      emit(
        OrderIdsFailed(
            message:
                AppLocalizations.of(context)!.anErrorOccurredPleaseTryAgain),
      );
    } else if (!responseData.status!) {
      emit(OrderIdsFailed(message: responseData.message!));
    }
  }
}
