import 'dart:developer';

import 'package:easy_plus_service_provider/core/storage/pref/shared_pref_controller.dart';
import 'package:easy_plus_service_provider/features/auth/data/auth_repo_imp.dart';
import 'package:easy_plus_service_provider/features/auth/model/response_privacy.dart';
import 'package:easy_plus_service_provider/features/auth/model/response_sign_up.dart';
import 'package:easy_plus_service_provider/features/main/data/home_repo_imp.dart';
import 'package:easy_plus_service_provider/features/main/model/general_response.dart';
import 'package:easy_plus_service_provider/features/main/model/notification_model.dart';
import 'package:easy_plus_service_provider/features/main/model/response_data.dart';
import 'package:easy_plus_service_provider/features/main/model/response_notification.dart';
import 'package:easy_plus_service_provider/features/main/views/manager/home_cubit/home_cubit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:bloc/bloc.dart';
import 'package:easy_plus_service_provider/features/main/model/item_settings_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(SettingsInitial());
  final AuthRepoImp _authRepoImp = AuthRepoImp();
  final HomeRepoImp _homeRepoImp = HomeRepoImp();

  static SettingsCubit get(BuildContext context) {
    return BlocProvider.of(context);
  }

  List<ItemSettingsModel> itemSettings(BuildContext context) {
    return [
      ItemSettingsModel(
        icPath: 'assets/images/ic_settings/ic_walet.svg',
        title: AppLocalizations.of(context)!.wallet,
      ),
      ItemSettingsModel(
        icPath: 'assets/images/ic_settings/ic_complaints.svg',
        title: AppLocalizations.of(context)!.complaintsAndSuggestions,
      ),
      ItemSettingsModel(
        icPath: 'assets/images/ic_settings/ic_contact_us.svg',
        title: AppLocalizations.of(context)!.connectUs,
      ),
      ItemSettingsModel(
        icPath: 'assets/images/ic_settings/ic_qustions.svg',
        title: AppLocalizations.of(context)!.commonQuestions,
      ),
      ItemSettingsModel(
        icPath: 'assets/images/ic_settings/ic_privicy.svg',
        title: AppLocalizations.of(context)!.privacyPolicy,
      ),
      ItemSettingsModel(
        icPath: 'assets/images/ic_terms_and_conditions.svg',
        title: AppLocalizations.of(context)!.termsAndConditions,
      ),
      ItemSettingsModel(
        icPath: 'assets/images/ic_settings/ic_settings.svg',
        title: AppLocalizations.of(context)!.settings,
      ),
      ItemSettingsModel(
        icPath: 'assets/images/ic_settings/ic_my_services.svg',
        title: AppLocalizations.of(context)!.myServices,
      ),
      // ItemSettingsModel(
      //   icPath: 'assets/images/ic_settings/ic_rate.svg',
      //   title: AppLocalizations.of(context)!.applicationEvaluation,
      // ),
      ItemSettingsModel(
        icPath: 'assets/images/ic_logout.svg',
        title: AppLocalizations.of(context)!.logOut,
      ),
      ItemSettingsModel(
        icPath: 'assets/images/ic_settings/ic_delete.svg',
        title: AppLocalizations.of(context)!.deleteAccount,
      ),
    ];
  }

  getMyServices(BuildContext context) async {
    indexVehicleClass = SharedPrefController().getCarTypeId ?? -1;
    if (indexVehicleClass != -1) {
      for (int i = 0;
          i < HomeCubit.get(context).appConfig!.carTypes!.length;
          i++) {
        if (indexVehicleClass ==
            HomeCubit.get(context).appConfig!.carTypes![i].id) {
          indexSelectedToList = i;
        }
      }
    }
    if (SharedPrefController().getListCat != null) {
      List<String> newListIdCat = SharedPrefController().getListCat!;
      List<int> finshList = newListIdCat.map((i) => int.parse(i)).toList();
      listIdCat = finshList;
      for (int i = 0; i < listIdCat.length; i++) {
        for (int j = 0;
            j < HomeCubit.get(context).appConfig!.categories!.length;
            j++) {
          if (listIdCat[i] ==
              HomeCubit.get(context).appConfig!.categories![j].id) {
            HomeCubit.get(context).appConfig!.categories![j].isSelected = true;
            break;
          }
        }
      }
    }

    indexTypeNavigationRange = SharedPrefController().getNavRangeId ?? -1;
  }

  List<int> listIdCat = [];

  changeSelectedCat(BuildContext context, int id) {
    for (int i = 0;
        i < HomeCubit.get(context).appConfig!.categories!.length;
        i++) {
      if (id == HomeCubit.get(context).appConfig!.categories![i].id) {
        if (HomeCubit.get(context).appConfig!.categories![i].isSelected!) {
          HomeCubit.get(context).appConfig!.categories![i].isSelected = false;
        } else {
          HomeCubit.get(context).appConfig!.categories![i].isSelected = true;
        }
      }
    }
    emit(SettingsInitial());
  }

  int indexVehicleClass = -1;
  int indexSelectedToList = -1;
  changeVehicleClass(BuildContext context, int id) {
    for (int i = 0;
        i < HomeCubit.get(context).appConfig!.carTypes!.length;
        i++) {
      if (id == HomeCubit.get(context).appConfig!.carTypes![i].id) {
        HomeCubit.get(context).appConfig!.carTypes![i].isSelected = true;
        indexVehicleClass = HomeCubit.get(context).appConfig!.carTypes![i].id!;
        indexSelectedToList = i;
      } else {
        HomeCubit.get(context).appConfig!.carTypes![i].isSelected = false;
      }
    }
    emit(SettingsInitial());
  }

  bool isExpandedVehicleClass = true;
  changeIsExpandedVehicleClass(bool status) {
    isExpandedVehicleClass = status;
    emit(SettingsInitial());
  }

  int indexTypeNavigationRange = -1;
  changeTypeNavigationRange(int index) {
    indexTypeNavigationRange = index;
    emit(SettingsInitial());
  }

  int indexTypeNavigationRange2 = 0;
  changeTypeNavigationRange2(int index) {
    indexTypeNavigationRange2 = index;
    emit(SettingsInitial());
  }

  int indexRequestCategory = 0;
  changeRequestCategory(int index) {
    indexRequestCategory = index;
    emit(SettingsInitial());
  }

  bool isExpandedRequestCategory = true;
  changeIsExpandedRequestCategory(bool status) {
    isExpandedRequestCategory = status;
    emit(SettingsInitial());
  }

  int indexReviewType = 0;
  changeReviewType(int index) {
    indexReviewType = index;
    emit(SettingsInitial());
  }

  bool isExpandedReviewType = true;
  changeIsExpandedReviewType(bool status) {
    isExpandedReviewType = status;
    emit(SettingsInitial());
  }

  bool isExpandedShoppingType = true;
  changeIsExpandedShoppingType(bool status) {
    isExpandedShoppingType = status;
    emit(SettingsInitial());
  }

  int indexShoppingType = 0;
  changeShoppingType(int index) {
    indexShoppingType = index;
    emit(SettingsInitial());
  }

  int indexVehicleClass2 = 0;
  changeVehicleClass2(int index) {
    indexVehicleClass2 = index;
    emit(SettingsInitial());
  }

  int indexDriversGender = 0;
  changeDriversGender(int index) {
    indexDriversGender = index;
    emit(SettingsInitial());
  }

  int indexTypeOfRide = 0;
  changeTypeOfRide(int index) {
    indexTypeOfRide = index;
    emit(SettingsInitial());
  }

  int indexTourType = 0;
  changeTourType(int index) {
    indexTourType = index;
    emit(SettingsInitial());
  }

  bool isExpandedTourType = true;
  changeIsExpandedTourType(bool status) {
    isExpandedTourType = status;
    emit(SettingsInitial());
  }

  int indexRoundCategory = 0;
  changeRoundCategory(int index) {
    indexRoundCategory = index;
    emit(SettingsInitial());
  }

  Future updateService(
    BuildContext context, {
    required List<int> listCat,
    required int carTypeId,
    required int navRangeId,
  }) async {
    emit(UpdateServiceLoading());

    GeneralResponse? responseUpdateService = await _authRepoImp.updateService(
        listCat: listCat, carTypeId: carTypeId, navRangeId: navRangeId);

    if (responseUpdateService != null && responseUpdateService.status!) {
      await SharedPrefController().setCarTypeId(carTypeId);
      await SharedPrefController().setNavRangeId(navRangeId);

      List<String> strList = listCat.map((i) => i.toString()).toList();
      await SharedPrefController().setListCat(strList);
      emit(UpdateServiceSuccess(message: responseUpdateService.message!));
    }

    if (responseUpdateService == null) {
      emit(
        UpdateServiceFailed(
            message:
                AppLocalizations.of(context)!.anErrorOccurredPleaseTryAgain),
      );
    } else if (!responseUpdateService.status!) {
      emit(UpdateServiceFailed(message: responseUpdateService.message!));
    }
  }

  changeSubCategory(
      BuildContext context, int categoryIndex, int subCategoryId) {
    switch (categoryIndex) {
      case 0:
        for (int i = 0;
            i < HomeCubit.get(context).appConfig!.ordersTypes!.length;
            i++) {
          if (HomeCubit.get(context).appConfig!.ordersTypes![i].id ==
              subCategoryId) {
            HomeCubit.get(context).appConfig!.ordersTypes![i].isSelected =
                !HomeCubit.get(context).appConfig!.ordersTypes![i].isSelected!;
          }
        }

        break;
      case 1:
        for (int i = 0;
            i < HomeCubit.get(context).appConfig!.revisionTypes!.length;
            i++) {
          if (HomeCubit.get(context).appConfig!.revisionTypes![i].id ==
              subCategoryId) {
            HomeCubit.get(context).appConfig!.revisionTypes![i].isSelected =
                !HomeCubit.get(context)
                    .appConfig!
                    .revisionTypes![i]
                    .isSelected!;
          }
        }

        break;
      case 2:
        for (int i = 0;
            i < HomeCubit.get(context).appConfig!.shoppingTypes!.length;
            i++) {
          if (HomeCubit.get(context).appConfig!.shoppingTypes![i].id ==
              subCategoryId) {
            HomeCubit.get(context).appConfig!.shoppingTypes![i].isSelected =
                !HomeCubit.get(context)
                    .appConfig!
                    .shoppingTypes![i]
                    .isSelected!;
          }
        }

        break;
      case 3:
        for (int i = 0;
            i < HomeCubit.get(context).appConfig!.tourTypes!.length;
            i++) {
          if (HomeCubit.get(context).appConfig!.tourTypes![i].id ==
              subCategoryId) {
            HomeCubit.get(context).appConfig!.tourTypes![i].isSelected =
                !HomeCubit.get(context).appConfig!.tourTypes![i].isSelected!;
          }
        }

        break;
      case 4:
        for (int i = 0;
            i < HomeCubit.get(context).appConfig!.carTypes!.length;
            i++) {
          if (HomeCubit.get(context).appConfig!.carTypes![i].id ==
              subCategoryId) {
            HomeCubit.get(context).appConfig!.carTypes![i].isSelected =
                !HomeCubit.get(context).appConfig!.carTypes![i].isSelected!;
          }
        }

        break;
    }
    emit(SettingsInitial());
  }

  selectNavRange(BuildContext context, int id) {
    for (int i = 0;
        i < HomeCubit.get(context).appConfig!.navRangeTypes!.length;
        i++) {
      if (HomeCubit.get(context).appConfig!.navRangeTypes![i].id == id) {
        HomeCubit.get(context).appConfig!.navRangeTypes![i].isSelected =
            !HomeCubit.get(context).appConfig!.navRangeTypes![i].isSelected!;
      }
    }
    emit(SettingsInitial());
  }

  selectMashuar(BuildContext context, int id) {
    for (int i = 0;
        i < HomeCubit.get(context).appConfig!.mishwarTypes!.length;
        i++) {
      if (HomeCubit.get(context).appConfig!.mishwarTypes![i].id == id) {
        HomeCubit.get(context).appConfig!.mishwarTypes![i].isSelected =
            !HomeCubit.get(context).appConfig!.mishwarTypes![i].isSelected!;
      }
    }
    emit(SettingsInitial());
  }

  Future sendContactUs(
    BuildContext context, {
    required String title,
    required String message,
  }) async {
    emit(ContactUsLoading());

    ResponseData? responseData = await _homeRepoImp.sendContactUs(
      title: title.trim(),
      message: message.trim(),
    );

    if (responseData != null && responseData.status!) {
      emit(ContactUsSuccess(message: responseData.message!));
    }

    if (responseData == null) {
      emit(
        ContactUsFailed(
            message:
                AppLocalizations.of(context)!.anErrorOccurredPleaseTryAgain),
      );
    } else if (!responseData.status!) {
      emit(ContactUsFailed(message: responseData.message!));
    }
  }

  Future requestMoney(
    BuildContext context, {
    required String name,
    required String amount,
    required String ibanNumber,
    required String accountNumber,
    required String bankName,
  }) async {
    emit(PullRequestLoading());

    ResponseData? responseData = await _homeRepoImp.requestMoney(
      name: name.trim(),
      amount: amount.trim(),
      ibanNumber: ibanNumber.trim(),
      accountNumber: accountNumber.trim(),
      bankName: bankName,
    );

    if (responseData != null && responseData.status!) {
      emit(PullRequestSuccess(message: responseData.message!));
    }

    if (responseData == null) {
      emit(
        PullRequestFailed(
            message:
                AppLocalizations.of(context)!.anErrorOccurredPleaseTryAgain),
      );
    } else if (!responseData.status!) {
      emit(PullRequestFailed(message: responseData.message!));
    }
  }

  ResponsePrivacy? responsePrivacy;
  Future getPrivacy(BuildContext context) async {
    emit(PrivacyPolicyLoading());

    ResponsePrivacy? responseData = await _homeRepoImp.privacyPolicy();

    if (responseData != null && responseData.status!) {
      responsePrivacy = responseData;
      emit(PrivacyPolicySuccess(message: responseData.message!));
    }

    if (responseData == null) {
      emit(
        PrivacyPolicyFailed(
            message:
                AppLocalizations.of(context)!.anErrorOccurredPleaseTryAgain),
      );
    } else if (!responseData.status!) {
      emit(PrivacyPolicyFailed(message: responseData.message!));
    }
  }

  ResponsePrivacy? responseTerms;
  Future getTermsOfUse(BuildContext context) async {
    emit(PrivacyPolicyLoading());

    ResponsePrivacy? responseData = await _homeRepoImp.termsOfUse();

    if (responseData != null && responseData.status!) {
      responseTerms = responseData;
      emit(PrivacyPolicySuccess(message: responseData.message!));
    }

    if (responseData == null) {
      emit(
        PrivacyPolicyFailed(
            message:
                AppLocalizations.of(context)!.anErrorOccurredPleaseTryAgain),
      );
    } else if (!responseData.status!) {
      emit(PrivacyPolicyFailed(message: responseData.message!));
    }
  }

  Future changePassword(
    BuildContext context, {
    required String currentPass,
    required String newPass,
    required String confirmPass,
  }) async {
    emit(ChangePasswordLoading());

    ResponseAuth? responseData = await _authRepoImp.changePassword(
      confirmPass: confirmPass,
      currentPass: currentPass,
      newPass: newPass,
    );

    if (responseData != null && responseData.status!) {
      emit(ChangePasswordSuccess(message: responseData.message!));
    }

    if (responseData == null) {
      emit(
        ChangePasswordFailed(
          message: AppLocalizations.of(context)!.anErrorOccurredPleaseTryAgain,
        ),
      );
    } else if (!responseData.status!) {
      emit(ChangePasswordFailed(message: responseData.message!));
    }
  }

  String? pathImage;
  setBankImage(String? s) {
    pathImage = s;
    emit(SettingsInitial());
  }

  pickImageBank() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      pathImage = image.path;

      emit(SettingsInitial());
    }
  }

  Future requestBalance(
    BuildContext context, {
    required String image,
    required int bankId,
  }) async {
    emit(BalanceLoading());

    GeneralResponse? responseData = await _homeRepoImp.requestBalance(
      bankId: bankId,
      image: image,
      name: SharedPrefController().getDataUser().name ?? "",
    );

    if (responseData != null && responseData.status!) {
      emit(BalanceSuccess(message: responseData.message!));
    }

    if (responseData == null) {
      emit(
        BalanceFailed(
          message: AppLocalizations.of(context)!.anErrorOccurredPleaseTryAgain,
        ),
      );
    } else if (!responseData.status!) {
      emit(BalanceFailed(message: responseData.message!));
    }
  }

  Future addBalance(
    BuildContext context, {
    required double amount,
    int? id,
  }) async {
    emit(BalanceLoading());

    GeneralResponse? responseData =
        await _homeRepoImp.addBalance(amount: amount);

    if (responseData != null && responseData.status!) {
      log('addBalance $addBalance  Success');
      emit(BalanceSuccess(message: responseData.message!, id: id));
    }

    if (responseData == null) {
      log('addBalance  fail');

      emit(
        BalanceFailed(
          message: AppLocalizations.of(context)!.anErrorOccurredPleaseTryAgain,
        ),
      );
    } else if (!responseData.status!) {
      log('addBalance fail');

      emit(BalanceFailed(message: responseData.message!));
    }
  }

  List<NotificationModel> listNotification = [];
  Future showNotifications(BuildContext context) async {
    emit(NotificationsLoading());

    ResponseNotification? responseData = await _homeRepoImp.showNotifications();

    if (responseData != null && responseData.status!) {
      listNotification = responseData.data ?? [];
      emit(NotificationsSuccess());
    }

    if (responseData == null) {
      emit(
        NotificationsFailed(
            message:
                AppLocalizations.of(context)!.anErrorOccurredPleaseTryAgain),
      );
    } else if (!responseData.status!) {
      emit(NotificationsFailed(message: responseData.message!));
    }
  }
}
