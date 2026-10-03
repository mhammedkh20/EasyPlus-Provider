import 'dart:developer';
import 'package:easy_plus_service_provider/features/main/model/home_response.dart';
import 'package:easy_plus_service_provider/features/main/model/order_object2.dart';
import 'package:easy_plus_service_provider/features/main/views/manager/language_cubit/language_cubit.dart';
import 'package:easy_plus_service_provider/features/main/views/manager/settings_cubit/settings_cubit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:bloc/bloc.dart';
import 'package:easy_plus_service_provider/features/main/data/home_repo_imp.dart';
import 'package:easy_plus_service_provider/features/main/model/response_app_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepoImp _homeRepoImp = HomeRepoImp();

  HomeCubit() : super(HomeInitial());

  static HomeCubit get(BuildContext context) {
    return BlocProvider.of(context);
  }

  setDataTourType(BuildContext context) {
    Future.delayed(Duration(milliseconds: 100), () {
      tourTypes = [
        CustomClass(
          id: 1,
          name: AppLocalizations.of(context)!.recreational,
        ),
        CustomClass(
          id: 2,
          name: AppLocalizations.of(context)!.training,
        ),
      ];
      reservationType = [
        CustomClass(
          id: 1,
          name: AppLocalizations.of(context)!.private,
        ),
        CustomClass(
          id: 2,
          name: AppLocalizations.of(context)!.sharingSeats,
        ),
      ];
    });
  }

  int indexSelectedService = -1;

  changeSelectedService(int index) {
    if (indexSelectedService == index) {
      indexSelectedService = -1;
    } else {
      indexSelectedService = index;
    }
    emit(HomeInitial());
  }

  ResponseAppConfig? appConfig;

  bool isloadingConfig = true;

  Future getAppConfig(BuildContext context) async {
    emit(LoadingGetAppConfig());
    ResponseAppConfig? responseAppConfig = await _homeRepoImp.getAppConfig();

    if (responseAppConfig != null && responseAppConfig.status!) {
      appConfig = responseAppConfig;
      log('success app config');
      isloadingConfig = false;
      emit(SuccessGetAppConfig());
      SettingsCubit.get(context).getMyServices(context);
    }

    if (responseAppConfig == null) {
      isloadingConfig = false;

      emit(
        FailedGetAppConfig(
            message:
                AppLocalizations.of(context)!.anErrorOccurredPleaseTryAgain),
      );
    } else if (!responseAppConfig.status!) {
      isloadingConfig = false;

      emit(FailedGetAppConfig(message: responseAppConfig.message!));
    }
  }

  clearData({required bool withEmit}) {
    total = 0;
    page = 1;
    listOrder.clear();
    if (withEmit) {
      emit(HomeInitial());
    }
  }

  HomeResponse? homeResponse;

  List<OrderObject2> listOrder = [];
  int total = 0;
  int page = 1;

  List<CustomClass> tourTypes = [];
  List<CustomClass> reservationType = [];

  Future getHomeData(
    BuildContext context, {
    // required double lat,
    // required double lng,
    bool loadPagination = false,
  }) async {
    if (loadPagination) {
      log('HomeLoadingPagination');

      emit(HomeLoadingPagination());
      page++;
    } else {
      clearData(withEmit: false);
      log('LoadingHomeData');

      emit(LoadingHomeData());
    }
    String? categoryId;
    String? orderTypeId;
    String? revisionTypeId;
    String? shoppingTypeId;
    String? tourType;
    String? tourTypeId;

    String? carTypeId;
    String? navRangeId;
    String? pickType;

    if (appConfig != null && indexSelectedService != -1) {
      categoryId = appConfig!.categories![indexSelectedService].id.toString();
      if (indexSelectedService == 0) {
        int index = appConfig!.ordersTypes!
            .indexWhere((element) => element.isSelected!);
        if (index >= 0) {
          orderTypeId = appConfig!.ordersTypes![index].id.toString();
        } else {
          orderTypeId = null;
        }
      }
      if (indexSelectedService == 1) {
        int index = appConfig!.revisionTypes!
            .indexWhere((element) => element.isSelected!);
        if (index >= 0) {
          revisionTypeId = appConfig!.revisionTypes![index].id.toString();
        } else {
          revisionTypeId = null;
        }
      }
      if (indexSelectedService == 2) {
        int index = appConfig!.shoppingTypes!
            .indexWhere((element) => element.isSelected!);
        if (index >= 0) {
          shoppingTypeId = appConfig!.shoppingTypes![index].id.toString();
        } else {
          shoppingTypeId = null;
        }
      }

      if (indexSelectedService == 3) {
        int index =
            appConfig!.tourTypes!.indexWhere((element) => element.isSelected!);
        if (index >= 0) {
          tourTypeId = appConfig!.tourTypes![index].id.toString();
        } else {
          tourTypeId = null;
        }

        int index2 = tourTypes.indexWhere((element) => element.isSelected!);
        if (index2 >= 0) {
          tourType = LanguageCubit.get(context).indexLang == 0
              ? tourTypes[index2].name == 'ترفيهية'
                  ? 'entertainment'
                  : 'training'
              : tourTypes[index2].name == 'entertainment'
                  ? 'entertainment'
                  : 'training';
        } else {
          tourType = null;
        }
      }
      if (indexSelectedService == 4) {
        int index =
            appConfig!.carTypes!.indexWhere((element) => element.isSelected!);
        if (index >= 0) {
          carTypeId = appConfig!.carTypes![index].id.toString();
        } else {
          carTypeId = null;
        }

        int index2 =
            reservationType.indexWhere((element) => element.isSelected!);
        if (index2 >= 0) {
          pickType = LanguageCubit.get(context).indexLang == 0
              ? reservationType[index2].name == 'خاص'
                  ? 'private'
                  : 'shared seats'
              : reservationType[index2].name == 'private'
                  ? 'private'
                  : 'shared seats';
        } else {
          pickType = null;
        }

        int index3 = appConfig!.navRangeTypes!
            .indexWhere((element) => element.isSelected!);
        if (index3 >= 0) {
          navRangeId = appConfig!.navRangeTypes![index3].id.toString();
        } else {
          navRangeId = null;
        }
      }
    }

    HomeResponse? response = await _homeRepoImp.getHomeData(
      page: page,
      // lat: lat,
      // lng: lng,
      categoryId: categoryId,
      orderTypeId: orderTypeId,
      revisionTypeId: revisionTypeId,
      shoppingTypeId: shoppingTypeId,
      tourTypeId: tourTypeId,
      carTypeId: carTypeId,
      navRangeId: navRangeId,
      tourType: tourType,
      pickType: pickType,
    );
    // log('message');

    if (response != null && response.status!) {
      total = response.meta!.total ?? 0;
      // if (response.data!.length > 0) {
      log('SuccessHomeData ${response.data!.length}');

      homeResponse = response;
      listOrder.addAll(response.data ?? []);
      // }
      emit(SuccessHomeData());
    }

    if (response == null) {
      log('FailedHomeData0');
      emit(
        FailedHomeData(
            message:
                AppLocalizations.of(context)!.anErrorOccurredPleaseTryAgain),
      );
    } else if (!response.status!) {
      log('FailedHomeData1');

      emit(FailedHomeData(message: response.message!));
    }
  }

  deleteOrder(int id) {
    int index = listOrder.indexWhere((element) => element.id == id);
    listOrder.removeAt(index);
    emit(HomeInitial());
  }

  changeSelectedDelivery(int index) {
    for (int i = 0; i < appConfig!.ordersTypes!.length; i++) {
      if (i == index) {
        appConfig!.ordersTypes![i].isSelected = true;
      } else {
        appConfig!.ordersTypes![i].isSelected = false;
      }
    }
    emit(HomeInitial());
  }

  changeSelectedRevision(int index) {
    for (int i = 0; i < appConfig!.revisionTypes!.length; i++) {
      if (i == index) {
        appConfig!.revisionTypes![i].isSelected = true;
      } else {
        appConfig!.revisionTypes![i].isSelected = false;
      }
    }
    emit(HomeInitial());
  }

  changeSelectedShoppingType(int index) {
    for (int i = 0; i < appConfig!.shoppingTypes!.length; i++) {
      if (i == index) {
        appConfig!.shoppingTypes![i].isSelected = true;
      } else {
        appConfig!.shoppingTypes![i].isSelected = false;
      }
    }
    emit(HomeInitial());
  }

  changeSelectedCarTypes(int index) {
    for (int i = 0; i < appConfig!.carTypes!.length; i++) {
      if (i == index) {
        appConfig!.carTypes![i].isSelected = true;
      } else {
        appConfig!.carTypes![i].isSelected = false;
      }
    }

    emit(HomeInitial());
  }

  changeSelectedNavigationRange(int index) {
    for (int i = 0; i < appConfig!.navRangeTypes!.length; i++) {
      if (i == index) {
        appConfig!.navRangeTypes![i].isSelected = true;
      } else {
        appConfig!.navRangeTypes![i].isSelected = false;
      }
    }

    emit(HomeInitial());
  }

  changeSelectedReservationType(BuildContext context, int index) {
    for (int i = 0; i < reservationType.length; i++) {
      if (i == index) {
        reservationType[i].isSelected = true;
      } else {
        reservationType[i].isSelected = false;
      }
    }
    emit(HomeInitial());
  }

  changeSelectedTourCategory(int index) {
    for (int i = 0; i < appConfig!.tourTypes!.length; i++) {
      if (i == index) {
        appConfig!.tourTypes![i].isSelected = true;
      } else {
        appConfig!.tourTypes![i].isSelected = false;
      }
    }
    emit(HomeInitial());
  } //! HERE

  changeSelectedTourType(BuildContext context, int index) {
    for (int i = 0; i < tourTypes.length; i++) {
      if (i == index) {
        tourTypes[i].isSelected = true;
      } else {
        tourTypes[i].isSelected = false;
      }
    }
    emit(HomeInitial());
  }

  theEmitCubit() {
    emit(HomeInitial());
  }
}
