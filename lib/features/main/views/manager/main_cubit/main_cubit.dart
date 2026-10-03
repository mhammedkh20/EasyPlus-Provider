import 'dart:developer';
import 'package:easy_plus_service_provider/core/utils/app_helpers.dart';
import 'package:easy_plus_service_provider/features/main/data/home_repo_imp.dart';
import 'package:easy_plus_service_provider/features/main/model/general_response.dart';
import 'package:easy_plus_service_provider/features/main/views/pages/bottom_nav/home/home.dart';
import 'package:easy_plus_service_provider/features/main/views/pages/bottom_nav/my_offer/my_offers.dart';
import 'package:easy_plus_service_provider/features/main/views/pages/bottom_nav/profile.dart';
import 'package:easy_plus_service_provider/features/main/views/pages/bottom_nav/settings/settings.dart';
import 'package:easy_plus_service_provider/features/main/model/bottom_nav_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

part 'main_state.dart';

class MainCubit extends Cubit<MainState> {
  final HomeRepoImp _homeRepoImp = HomeRepoImp();
  Position? _currentPosition;

  MainCubit() : super(MainInitial());

  static MainCubit get(BuildContext context) {
    return BlocProvider.of(context);
  }

  List<BottomNavModel> getPage(BuildContext context) {
    return [
      BottomNavModel(
        title: AppLocalizations.of(context)!.main,
        widget: Home(),
      ),
      BottomNavModel(
        title: AppLocalizations.of(context)!.myOffers,
        widget: MyOffers(),
      ),
      BottomNavModel(
        title: AppLocalizations.of(context)!.profile,
        widget: Profile(),
      ),
      BottomNavModel(
        title: AppLocalizations.of(context)!.settings,
        widget: Settings(),
      ),
    ];
  }

  int indexPageNav = 0;
  changeIndex(int index) {
    indexPageNav = index;
    emit(MainInitial());
  }

  Future<bool> _handleLocationPermission(BuildContext context) async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      AppHelpers.showSnackBar(context,
          message: AppLocalizations.of(context)!.descLocation);
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        AppHelpers.showSnackBar(context,
            message: AppLocalizations.of(context)!.locationPermissionsDenied);
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      AppHelpers.showSnackBar(context,
          message: AppLocalizations.of(context)!.alwasDenid);
      return false;
    }
    return true;
  }

  Future<void> getCurrentPosition(context) async {
    final hasPermission = await _handleLocationPermission(context);
    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) async {
      _currentPosition = position;
      //! send LatLng For Api
      if (_currentPosition != null) {
        updateLocation(
          context,
          address: await _getAddressFromLatLng(_currentPosition!) ?? "",
          lat: _currentPosition!.latitude.toString(),
          lng: _currentPosition!.longitude.toString(),
        );
      }
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Future<String?> _getAddressFromLatLng(Position position) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          _currentPosition!.latitude, _currentPosition!.longitude);
      Placemark place = placemarks[0];
      return '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}';
    } catch (ex) {
      return null;
    }
  }

  Future updateLocation(
    BuildContext context, {
    required String address,
    required String lat,
    required String lng,
  }) async {
    GeneralResponse? responseUpdatedLocation =
        await _homeRepoImp.updateLocation(
      address: address,
      lat: lat,
      lng: lng,
    );

    if (responseUpdatedLocation != null && responseUpdatedLocation.status!) {
      log("im here update location");
      log(responseUpdatedLocation.message.toString());
    }

    if (responseUpdatedLocation == null) {
      log('fail');
    } else if (!responseUpdatedLocation.status!) {
      log(responseUpdatedLocation.message.toString());
    }
  }
}
