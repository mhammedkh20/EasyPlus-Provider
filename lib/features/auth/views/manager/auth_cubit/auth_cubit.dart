// ignore_for_file: use_build_context_synchronously

import 'package:easy_plus_service_provider/core/storage/pref/shared_pref_controller.dart';
import 'package:easy_plus_service_provider/core/utils/app_dialogs.dart';
import 'package:easy_plus_service_provider/core/utils/app_helpers.dart';
import 'package:easy_plus_service_provider/features/auth/data/auth_repo_imp.dart';
import 'package:easy_plus_service_provider/features/auth/model/response_sign_up.dart';
import 'package:easy_plus_service_provider/features/auth/model/user.dart';
import 'package:easy_plus_service_provider/features/auth/views/pages/login_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:bloc/bloc.dart';
import 'package:country_pickers/country.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepoImp _authRepoImp = AuthRepoImp();

  AuthCubit() : super(AuthInitial());

  static AuthCubit get(BuildContext context) {
    return BlocProvider.of(context);
  }

  int socialSelectedIndex = 0;
  String type = 'phone';

  socialSelected(
    int index, {
    bool withEmait = true,
    bool changeType = false,
    required String type,
  }) {
    socialSelectedIndex = index;
    if (changeType) this.type = type;
    if (withEmait) emit(AuthInitial());
  }

  bool isSelectedToAgree = false;
  changeSelectedAgree() {
    isSelectedToAgree = !isSelectedToAgree;
    emit(AuthInitial());
  }

  Country selectedDialogCountry = Country(
    isoCode: 'SA',
    iso3Code: 'SAU',
    phoneCode: '966',
    name: 'Saudi Arabia',
  );
  selectCountry(Country country) {
    selectedDialogCountry = country;
    emit(AuthInitial());
  }

  User? user;

  Future userLogin(
    BuildContext context, {
    required String other,
    required String password,
  }) async {
    emit(LoginLoading());

    ResponseAuth? responseLogin = await _authRepoImp.login(
      other: other.trim(),
      password: password.trim(),
      socialSelectedIndex: AuthCubit.get(context).type.contains('Email') ||
              AuthCubit.get(context).type.contains('البريد الإلكتروني')
          ? 2
          : socialSelectedIndex,
    );

    if (responseLogin != null && responseLogin.status!) {
      user = responseLogin.user;
      await SharedPrefController().saveDataUser(responseLogin.user!);
      emit(LoginSuccess(message: responseLogin.message!));
    }

    if (responseLogin == null) {
      emit(
        LoginFailed(
            message:
                AppLocalizations.of(context)!.anErrorOccurredPleaseTryAgain),
      );
    } else if (!responseLogin.status!) {
      emit(LoginFailed(
          message: responseLogin.message!,
          unauthorized: responseLogin.unauthorized!));
    }
  }

  Future userRegister(
    BuildContext context, {
    required String name,
    required String other,
    required String password,
    required String gender,
  }) async {
    emit(RegisterLoading());

    ResponseAuth? responseRegister = await _authRepoImp.register(
      other: other,
      gender: gender,
      password: password,
      name: name,
      socialSelectedIndex: AuthCubit.get(context).type.contains('Email') ||
              AuthCubit.get(context).type.contains('البريد الإلكتروني')
          ? 2
          : socialSelectedIndex,
    );

    if (responseRegister != null && responseRegister.status!) {
      emit(RegisterSuccess(message: responseRegister.message!));
    }

    if (responseRegister == null) {
      emit(
        RegisterFailed(
            message:
                AppLocalizations.of(context)!.anErrorOccurredPleaseTryAgain),
      );
    } else if (!responseRegister.status!) {
      emit(RegisterFailed(message: responseRegister.message!));
    }
  }

  Future userVerifyCode(
    BuildContext context, {
    required String other,
    required String code,
  }) async {
    emit(VerifyCodeLoading());

    ResponseAuth? responseVerifyCode = await _authRepoImp.verifyCode(
      other: other,
      socialSelectedIndex: socialSelectedIndex,
      code: code,
    );

    if (responseVerifyCode != null && responseVerifyCode.status!) {
      SharedPrefController()
          .setTypeTextFeild(socialSelectedIndex == 2 ? "email" : "phone");
      user = responseVerifyCode.user;
      await SharedPrefController().saveDataUser(responseVerifyCode.user!);

      emit(VerifyCodeSuccess(message: responseVerifyCode.message!));
    }

    if (responseVerifyCode == null) {
      emit(
        VerifyCodeFailed(
            message:
                AppLocalizations.of(context)!.anErrorOccurredPleaseTryAgain),
      );
    } else if (!responseVerifyCode.status!) {
      emit(VerifyCodeFailed(message: responseVerifyCode.message!));
    }
  }

  Future forget(BuildContext context, {required String other}) async {
    emit(ForgetPasswordLoading());

    ResponseAuth? responseForget = await _authRepoImp.forgetPassword(
      other: other.trim(),
      socialSelectedIndex: AuthCubit.get(context).type.contains('Email') ||
              AuthCubit.get(context).type.contains('البريد الإلكتروني')
          ? 2
          : socialSelectedIndex,
    );

    if (responseForget != null && responseForget.status!) {
      user = responseForget.user;
      emit(ForgetPasswordSuccess(message: responseForget.message!));
    }

    if (responseForget == null) {
      emit(
        ForgetPasswordFailed(
            message:
                AppLocalizations.of(context)!.anErrorOccurredPleaseTryAgain),
      );
    } else if (!responseForget.status!) {
      emit(ForgetPasswordFailed(message: responseForget.message!));
    }
  }

  Future logout(BuildContext context) async {
    emit(LogoutLoading());

    ResponseAuth? responseLogout = await _authRepoImp.logout();

    if (responseLogout != null && responseLogout.status!) {
      emit(LogoutSuccess(message: responseLogout.message!));
    }

    if (responseLogout == null) {
      emit(
        LogoutFailed(
          message: AppLocalizations.of(context)!.anErrorOccurredPleaseTryAgain,
        ),
      );
    } else if (!responseLogout.status!) {
      emit(LogoutFailed(message: responseLogout.message!));
    }
  }

  Future verify(
    BuildContext context, {
    required String code,
    required String other,
  }) async {
    emit(VerifyPasswordLoading());

    ResponseAuth? responseForget = await _authRepoImp.verifyCode(
      other: other.trim(),
      code: code,
      socialSelectedIndex: AuthCubit.get(context).type.contains('Email') ||
              AuthCubit.get(context).type.contains('البريد الإلكتروني')
          ? 2
          : socialSelectedIndex,
    );

    if (responseForget != null && responseForget.status!) {
      user = responseForget.user;
      emit(VerifyPasswordSuccess(message: responseForget.message!));
    }

    if (responseForget == null) {
      emit(
        VerifyPasswordFailed(
            message:
                AppLocalizations.of(context)!.anErrorOccurredPleaseTryAgain),
      );
    } else if (!responseForget.status!) {
      emit(VerifyPasswordFailed(message: responseForget.message!));
    }
  }

  Future resetPassword(
    BuildContext context, {
    required String password,
    required String passwordConfirmation,
    required String other,
  }) async {
    emit(ResetPasswordLoading());

    ResponseAuth? responseForget = await _authRepoImp.resetPassword(
      other: other.trim(),
      password: password,
      passwordConfirmation: passwordConfirmation,
      socialSelectedIndex: socialSelectedIndex,
    );

    if (responseForget != null && responseForget.status!) {
      user = responseForget.user;
      emit(ResetPasswordSuccess(message: responseForget.message!));
    }

    if (responseForget == null) {
      emit(
        ResetPasswordFailed(
            message:
                AppLocalizations.of(context)!.anErrorOccurredPleaseTryAgain),
      );
    } else if (!responseForget.status!) {
      emit(ResetPasswordFailed(message: responseForget.message!));
    }
  }

  Future getProfile(BuildContext context) async {
    ResponseAuth? response = await _authRepoImp.profile();

    if (response != null && response.status!) {
      print('object ${response.user!.status}');
      if (response.user!.status == '0') {
        AppDialogs.showBlockFromAdminDialog(context, onPressedOk: () async {
          Navigator.of(context).pop();
          await AuthCubit.get(context).logout(context);
          await SharedPrefController().clearAllData();
          AppHelpers.navigationToPageAndExitAll(context, LoginScreen());
        });
      }
    } else if (response != null) {
      print("profile data  ${response.message}");
    }
  }
}
