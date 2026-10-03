import 'package:easy_plus_service_provider/core/utils/remoteconfig_servoce.dart';
import 'package:easy_plus_service_provider/features/main/views/manager/home_cubit/home_cubit.dart';
import 'package:easy_plus_service_provider/features/on_boarding/data/onboarding_repo_imp.dart';
import 'package:easy_plus_service_provider/features/on_boarding/model/response_login_method.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'on_boarding_state.dart';

class OnBoardingCubit extends Cubit<OnBoardingState> {
  final OnboardingRepoImp _onboardingRepoImp = OnboardingRepoImp();
  OnBoardingCubit() : super(OnBoardingInitial());

  static OnBoardingCubit get(BuildContext context) {
    return BlocProvider.of(context);
  }

  ResponseLoginMethod? methods;
  bool isLoading = true;

  Future getMethods(BuildContext context) async {
    await HomeCubit.get(context).getAppConfig(context);
    bool check = await RemoteConfigService().checkOurAppForUpdate(context);
    if (!check) {
      ResponseLoginMethod? responseMethods =
          await _onboardingRepoImp.getLoginMethod();

      if (responseMethods != null && responseMethods.status!) {
        isLoading = false;
        methods = responseMethods;
        print(methods!.data!.length);

        emit(GetDataSuccess());
      }

      if (responseMethods == null) {
        emit(
          GetDataFailed(
              message:
                  AppLocalizations.of(context)!.anErrorOccurredPleaseTryAgain),
        );
      } else if (!responseMethods.status!) {
        if (responseMethods.is500!) {
          emit(GetDataFailed500());
        } else {
          emit(GetDataFailed(message: responseMethods.message!));
        }
      }
    }
  }
}
