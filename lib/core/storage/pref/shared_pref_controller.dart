import 'dart:convert';

import 'package:easy_plus_service_provider/core/storage/pref/pref_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../features/auth/model/user.dart';

class SharedPrefController {
  static final SharedPrefController _instance =
      SharedPrefController._internal();

  late SharedPreferences _preferences;

  SharedPrefController._internal();

  factory SharedPrefController() => _instance;

  Future<SharedPreferences> initSharedPref() async =>
      _preferences = await SharedPreferences.getInstance();

  SharedPreferences get prefManager => _preferences;

  Future<bool> setToken(String token) async =>
      await _preferences.setString(PrefKeys.TOKEN, token);

  String? get getToken => _preferences.getString(PrefKeys.TOKEN);

  Future<bool> setNavigationFromService(bool status) async =>
      await _preferences.setBool(PrefKeys.NAVIGATION_FROM_MYSERVICE, status);

  bool? get getNavigationFromService =>
      _preferences.getBool(PrefKeys.NAVIGATION_FROM_MYSERVICE) ?? true;

  Future<bool> saveDataUser(User user) async {
    await _preferences.setInt(PrefKeys.ID_USER, user.id ?? -1);
    await _preferences.setString(PrefKeys.ID_NUMBER_USER, user.idNumber ?? '');
    await _preferences.setString(PrefKeys.NAME_USER, user.name ?? "");
    await _preferences.setString(PrefKeys.PHONE_USER, user.phone ?? "");
    await _preferences.setString(PrefKeys.TOKEN, user.token ?? "");
    await _preferences.setString(PrefKeys.STATUS_USER, user.status ?? "");
    await _preferences.setString(PrefKeys.GENDER_USER, user.gender ?? "");
    await _preferences.setString(PrefKeys.IMAGE_USER, user.image ?? "");

    await _preferences.setString(
        PrefKeys.BIRTH_DATE_USER, user.birthDate ?? "");

    await _preferences.setString(
        PrefKeys.LICENSE_NUMBER_USER, user.licenseNumber ?? "");
    await _preferences.setString(PrefKeys.CAR_MODEL, user.carModel ?? "");
    await _preferences.setString(PrefKeys.CAR_MAKE, user.carMake ?? "");
    await _preferences.setString(PrefKeys.YEAR, user.year ?? "");
    await _preferences.setString(PrefKeys.CAR_COLOR, user.carColor ?? "");
    await _preferences.setString(PrefKeys.PLATE_NUMBER, user.plateNumber ?? "");
    await _preferences.setString(PrefKeys.ID_IMAGE, user.idImage ?? "");
    await _preferences.setString(
        PrefKeys.LICENSE_IMAGE, user.licenseImage ?? "");
    await _preferences.setString(PrefKeys.CAR_IMAGE, user.carImage ?? "");

    if (user.carImages != null) {
      await _preferences.setString(
          PrefKeys.CAR_IMAGES, jsonEncode(user.toJsonCarImages()));
    }
    return await _preferences.setDouble(
        PrefKeys.RATE, double.parse(user.rate.toString()));
  }

  User getDataUser() {
    int id = _preferences.getInt(PrefKeys.ID_USER) ?? -1;
    String idNumber = _preferences.getString(PrefKeys.ID_NUMBER_USER) ?? '';
    String name = _preferences.getString(PrefKeys.NAME_USER) ?? "";
    String phone = _preferences.getString(PrefKeys.PHONE_USER) ?? "";
    String token = _preferences.getString(PrefKeys.TOKEN) ?? "";
    String status = _preferences.getString(PrefKeys.STATUS_USER) ?? "";
    String gender = _preferences.getString(PrefKeys.GENDER_USER) ?? "";
    String birthDate = _preferences.getString(PrefKeys.BIRTH_DATE_USER) ?? "";
    String image = _preferences.getString(PrefKeys.IMAGE_USER) ?? "";
    String licenseNumber =
        _preferences.getString(PrefKeys.LICENSE_NUMBER_USER) ?? "";
    String carModel = _preferences.getString(PrefKeys.CAR_MODEL) ?? "";
    String carMake = _preferences.getString(PrefKeys.CAR_MAKE) ?? "";
    String year = _preferences.getString(PrefKeys.YEAR) ?? "";
    String carColor = _preferences.getString(PrefKeys.CAR_COLOR) ?? "";
    String plateNumber = _preferences.getString(PrefKeys.PLATE_NUMBER) ?? "";
    String idImage = _preferences.getString(PrefKeys.ID_IMAGE) ?? "";
    String licenseImage = _preferences.getString(PrefKeys.LICENSE_IMAGE) ?? "";
    String carImage = _preferences.getString(PrefKeys.CAR_IMAGE) ?? "";
    double rate = _preferences.getDouble(PrefKeys.RATE) ?? 0;
    String? carImages = _preferences.getString(PrefKeys.CAR_IMAGES);

    return User(
        id: id,
        name: name,
        phone: phone,
        birthDate: birthDate,
        idNumber: idNumber,
        token: token,
        status: status,
        gender: gender,
        image: image,
        rate: rate,
        carImage: carImage,
        licenseImage: licenseImage,
        idImage: idImage,
        plateNumber: plateNumber,
        carColor: carColor,
        year: year,
        carMake: carMake,
        licenseNumber: licenseNumber,
        carModel: carModel,
        carImages: User().fromJsonCarImages(carImages));
  }

  Future<bool> setLang(String token) async =>
      await _preferences.setString(PrefKeys.LANG, token);

  String get getLang => _preferences.getString(PrefKeys.LANG) ?? 'ar';

  // ! type email or phone
  Future<bool> setTypeTextFeild(String type) async =>
      await _preferences.setString(PrefKeys.TYPE_LOGIN, type);

  String? get getTypeTextFeild => _preferences.getString(PrefKeys.TYPE_LOGIN);

  // ! My service
  Future<bool> setListCat(List<String> listCat) async =>
      await _preferences.setStringList(PrefKeys.LIST_CAT, listCat);

  List<String>? get getListCat => _preferences.getStringList(PrefKeys.LIST_CAT);

  Future<bool> setCarTypeId(int carTypeId) async =>
      await _preferences.setInt(PrefKeys.CAR_TYPE_ID, carTypeId);

  int? get getCarTypeId => _preferences.getInt(PrefKeys.CAR_TYPE_ID);

  Future<bool> setNavRangeId(int navRangeId) async =>
      await _preferences.setInt(PrefKeys.NAV_RANGE_ID, navRangeId);

  int? get getNavRangeId => _preferences.getInt(PrefKeys.NAV_RANGE_ID);

  Future clearAllData() async {
    await _preferences.clear();
  }
}
