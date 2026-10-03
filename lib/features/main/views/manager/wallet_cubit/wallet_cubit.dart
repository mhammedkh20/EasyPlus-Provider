import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:easy_plus_service_provider/features/main/data/home_repo_imp.dart';
import 'package:easy_plus_service_provider/features/main/model/wallet/transactions.dart';
import 'package:easy_plus_service_provider/features/main/model/wallet/wallet_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'wallet_state.dart';

class WalletCubit extends Cubit<WalletState> {
  final HomeRepoImp _homeRepoImp = HomeRepoImp();

  WalletCubit() : super(WalletInitial());

  static WalletCubit get(BuildContext context) {
    return BlocProvider.of(context);
  }

  List<Transactions> listTransactions = [];

  double total = 0;
  double totalPayment = 0;
  changeTax(double tax, double price) {
    total = price - (price * tax) / 100;
    totalPayment = price + (price * tax) / 100;
    emit(WalletInitial());
  }

  String balnce = '0';
  String currency = 'SAR';

  Future getTransactions(BuildContext context, {int? index, int? id}) async {
    balnce = '0';
    emit(WalletLoading());

    WalletResponse? responseData = await _homeRepoImp.getTransactions();

    if (responseData != null && responseData.status!) {
      if (responseData.data!.balance != null) {
        balnce = responseData.data!.balance!;
      }
      if (responseData.data!.currency != null) {
        currency = responseData.data!.currency!;
      }
      listTransactions = responseData.data!.transactions ?? [];
      emit(WalletSuccess(message: responseData.message!, index: index, id: id));
    }

    if (responseData == null) {
      emit(
        WalletFailed(
          message: AppLocalizations.of(context)!.anErrorOccurredPleaseTryAgain,
        ),
      );
    } else if (!responseData.status!) {
      emit(WalletFailed(message: responseData.message!));
    }
  }
}
