import 'package:easy_plus_service_provider/features/main/data/home_repo_imp.dart';
import 'package:easy_plus_service_provider/features/main/model/common_quastions_response.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:bloc/bloc.dart';
import 'package:easy_plus_service_provider/features/main/model/qustion.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'common_quastions_state.dart';

class CommonQuastionsCubit extends Cubit<CommonQuastionsState> {
  final HomeRepoImp _homeRepoImp = HomeRepoImp();
  CommonQuastionsCubit() : super(CommonQuastionsInitial());

  static CommonQuastionsCubit get(BuildContext context) {
    return BlocProvider.of(context);
  }

  List<Qustion> listQustion = [];
  int total = 0;
  int page = 1;

  clearData({required bool withEmit}) {
    total = 0;
    page = 1;
    listQustion.clear();
    if (withEmit) {
      emit(CommonQuastionsInitial());
    }
  }

  Future getQustion(BuildContext context, {bool loadPagination = false}) async {
    if (loadPagination) {
      emit(QustionLoadingPagination());
      page++;
    } else {
      clearData(withEmit: false);
      emit(LoadingQustionData());
    }
    CommonQuastionsResponse? response = await _homeRepoImp.getCommonQus(page);

    if (response != null && response.status!) {
      total = response.meta!.total ?? 0;
      listQustion.addAll(response.data ?? []);
      emit(SuccessQustionData());
    }

    if (response == null) {
      emit(
        FailedQustionData(
            message:
                AppLocalizations.of(context)!.anErrorOccurredPleaseTryAgain),
      );
    } else if (!response.status!) {
      emit(FailedQustionData(message: response.message!));
    }
  }
}
