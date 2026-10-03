import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:easy_plus_service_provider/core/network/api/settings_api.dart';
import 'package:easy_plus_service_provider/core/storage/pref/shared_pref_controller.dart';
import 'package:easy_plus_service_provider/core/utils/app_helpers.dart';
import 'package:easy_plus_service_provider/features/auth/model/response_sign_up.dart';
import 'package:easy_plus_service_provider/features/auth/model/user.dart';
import 'package:easy_plus_service_provider/features/main/model/general_response.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;

class ApiAuth {
  final SharedPrefController _shared = SharedPrefController();

  Future<ResponseAuth?> registerAccount({
    required String other,
    required String gender,
    required String name,
    required String password,
    required int socialSelectedIndex,
  }) async {
    ResponseAuth? responseSignUp;
    try {
      final response;
      response = await http.post(
        Uri.parse(SittingsApi.REGISTR),
        headers: AppHelpers.getHeader(_shared),
        body: socialSelectedIndex == 2
            ? {
                "name": name,
                "email": other,
                'fcm_token': await FirebaseMessaging.instance.getToken(),
                "gender": gender,
                "password": password
              }
            : {
                "name": name,
                "phone": other,
                'fcm_token': await FirebaseMessaging.instance.getToken(),
                "gender": gender,
                "password": password
              },
      );
      if (response.statusCode == 200) {
        responseSignUp = ResponseAuth.fromJson(jsonDecode(response.body));
        responseSignUp.status = true;
      } else if (response.statusCode >= 400) {
        responseSignUp = ResponseAuth();
        responseSignUp.message = jsonDecode(response.body)['message'];
        responseSignUp.status = false;
      }
    } catch (ex) {
      responseSignUp = ResponseAuth();
      responseSignUp.message = ex.toString();
      responseSignUp.status = false;
    }

    return responseSignUp;
  }

  Future<ResponseAuth?> loginAccount({
    required String other,
    required String password,
    required int socialSelectedIndex,
  }) async {
    ResponseAuth? responseSignIn;

    try {
      final response = await http.post(
        Uri.parse(SittingsApi.LOGIN),
        headers: AppHelpers.getHeader(_shared),
        body: socialSelectedIndex == 2
            ? {
                "email": other,
                "password": password,
                'fcm_token': await FirebaseMessaging.instance.getToken(),
              }
            : {
                "phone": other,
                "password": password,
                'fcm_token': await FirebaseMessaging.instance.getToken(),
              },
      );

      if (response.statusCode == 200) {
        print(response.body);
        responseSignIn = ResponseAuth.fromJson(jsonDecode(response.body));
        responseSignIn.status = true;
      } else if (response.statusCode >= 400) {
        responseSignIn = ResponseAuth();
        if (response.statusCode == 401) {
          responseSignIn.unauthorized = true;
        }
        responseSignIn.message = jsonDecode(response.body)['message'];
        responseSignIn.status = false;
      }
    } catch (ex) {
      responseSignIn = ResponseAuth();
      responseSignIn.message = ex.toString();
      responseSignIn.status = false;
    }

    return responseSignIn;
  }

  Future<ResponseAuth?> logoutAccount() async {
    ResponseAuth? responselogout;

    try {
      final response = await http.delete(
        Uri.parse(SittingsApi.LOGOUT),
        headers: AppHelpers.getHeader(_shared),
      );
      if (response.statusCode == 200) {
        responselogout = ResponseAuth.fromJson(jsonDecode(response.body));
        responselogout.status = true;
      } else if (response.statusCode >= 400) {
        responselogout = ResponseAuth();
        responselogout.message = jsonDecode(response.body)['message'];
        responselogout.status = false;
      }
    } catch (ex) {
      responselogout = ResponseAuth();
      responselogout.message = ex.toString();
      responselogout.status = false;
    }

    return responselogout;
  }

  Future<ResponseAuth?> changePassword({
    required String currentPass,
    required String newPass,
    required String confirmPass,
  }) async {
    ResponseAuth? responseChangePass;

    try {
      final response = await http.post(
        Uri.parse(SittingsApi.CHANGE_PASSWORD),
        headers: AppHelpers.getHeader(_shared),
        body: {
          "current_password": currentPass,
          "password": newPass,
          "password_confirmation": confirmPass,
        },
      );
      if (response.statusCode == 200) {
        responseChangePass = ResponseAuth.fromJson(jsonDecode(response.body));
        responseChangePass.status = true;
      } else if (response.statusCode >= 400) {
        responseChangePass = ResponseAuth();
        responseChangePass.message = jsonDecode(response.body)['message'];
        responseChangePass.status = false;
      }
    } catch (ex) {
      responseChangePass = ResponseAuth();
      responseChangePass.message = ex.toString();
      responseChangePass.status = false;
    }

    return responseChangePass;
  }

  Future<ResponseAuth?> updateAccount({required User user}) async {
    ResponseAuth? responseUpdateAccount;

    try {
      FormData formData = FormData.fromMap(await user.toJsonUpdateUser());
      if (user.carImages != null) {
        for (int i = 0; i < user.carImages!.length; i++) {
          formData.files.add(MapEntry(
            'car_images[$i]',
            await MultipartFile.fromFile(user.carImages![i].image!),
          ));
        }
      }
      final response = await Dio().post(
        SittingsApi.UPDATE_ACCOUNT,
        data: formData,
        options: Options(
          headers: AppHelpers.getHeader(_shared),
          followRedirects: false,
          validateStatus: (int? status) {
            return status! < 500;
          },
        ),
      );

      log('message');
      if (response.statusCode == 200) {
        responseUpdateAccount = ResponseAuth.fromJsonData(response.data);
        responseUpdateAccount.status = true;
      } else if (response.statusCode! >= 400) {
        responseUpdateAccount = ResponseAuth();
        responseUpdateAccount.message = response.data['message'];
        responseUpdateAccount.status = false;
      }
    } catch (ex) {
      responseUpdateAccount = ResponseAuth();
      responseUpdateAccount.message = ex.toString();
      responseUpdateAccount.status = false;
    }

    return responseUpdateAccount;
  }

  Future<GeneralResponse?> updateServiceAccount({
    required List<int> listCat,
    required int carTypeId,
    required int navRangeId,
  }) async {
    GeneralResponse? responseUpdateService;

    try {
      final response = await Dio().post(
        SittingsApi.UPDATE_SERVICES,
        data: {
          'my_categories': listCat,
          'car_type_id': carTypeId,
          'nav_range_id': navRangeId,
        },
        options: Options(
          headers: AppHelpers.getHeader(_shared),
          followRedirects: false,
          validateStatus: (int? status) {
            return status! < 500;
          },
        ),
      );

      if (response.statusCode == 200) {
        responseUpdateService = GeneralResponse.fromJson(response.data);
        responseUpdateService.status = true;
      } else if (response.statusCode! >= 400) {
        responseUpdateService = GeneralResponse();
        responseUpdateService.message = response.data['message'];
        responseUpdateService.status = false;
      }
    } catch (ex) {
      responseUpdateService = GeneralResponse();
      responseUpdateService.message = ex.toString();
      responseUpdateService.status = false;
    }

    return responseUpdateService;
  }

  Future<ResponseAuth?> verifyCodeAccount({
    required String other,
    required String code,
    required int socialSelectedIndex,
  }) async {
    ResponseAuth? responseSignUp;

    try {
      final response = await http.post(
        Uri.parse(SittingsApi.VERIFY_CODE),
        headers: AppHelpers.getHeader(_shared),
        body: socialSelectedIndex == 2
            ? {"email": other, "code": code}
            : {"phone": other, "code": code},
      );

      if (response.statusCode == 200) {
        responseSignUp = ResponseAuth.fromJson(jsonDecode(response.body));
        responseSignUp.status = true;
      } else if (response.statusCode >= 400) {
        responseSignUp = ResponseAuth();
        responseSignUp.message = jsonDecode(response.body)['message'];
        responseSignUp.status = false;
      }
    } catch (ex) {
      responseSignUp = ResponseAuth();
      responseSignUp.message = ex.toString();
      responseSignUp.status = false;
    }

    return responseSignUp;
  }

  Future<ResponseAuth?> resetPassword({
    required String other,
    required int socialSelectedIndex,
    required String password,
    required String passwordConfirmation,
  }) async {
    ResponseAuth? responseSignUp;

    try {
      final response = await http.post(
        Uri.parse(SittingsApi.RESET_PASSWORD),
        headers: AppHelpers.getHeader(_shared),
        body: socialSelectedIndex == 2
            ? {
                "email": other,
                "password": password,
                "password_confirmation": passwordConfirmation
              }
            : {
                "phone": other,
                "password": password,
                "password_confirmation": passwordConfirmation
              },
      );

      if (response.statusCode == 200) {
        responseSignUp = ResponseAuth.fromJson(jsonDecode(response.body));
        responseSignUp.status = true;
      } else if (response.statusCode >= 400) {
        responseSignUp = ResponseAuth();
        responseSignUp.message = jsonDecode(response.body)['message'];
        responseSignUp.status = false;
      }
    } catch (ex) {
      responseSignUp = ResponseAuth();
      responseSignUp.message = ex.toString();
      responseSignUp.status = false;
    }

    return responseSignUp;
  }

  Future<ResponseAuth?> forgetPassword({
    required String other,
    required int socialSelectedIndex,
  }) async {
    ResponseAuth? responseforgetPassword;

    try {
      final response = await http.post(
        Uri.parse(SittingsApi.FORGET_PASSWORD),
        headers: {"Accept": "application/json"},
        body: socialSelectedIndex == 2 ? {"email": other} : {"phone": other},
      );
      if (response.statusCode == 200) {
        responseforgetPassword =
            ResponseAuth.fromJson(jsonDecode(response.body));
        responseforgetPassword.status = true;
      } else if (response.statusCode >= 400) {
        responseforgetPassword = ResponseAuth();
        responseforgetPassword.message = jsonDecode(response.body)['message'];
        responseforgetPassword.status = false;
      }
    } catch (ex) {
      responseforgetPassword = ResponseAuth();
      responseforgetPassword.message = ex.toString();
      responseforgetPassword.status = false;
    }

    return responseforgetPassword;
  }

  Future<ResponseAuth?> logout() async {
    ResponseAuth? responselogout;

    try {
      final response = await http.delete(
        Uri.parse(SittingsApi.LOGOUT),
        headers: AppHelpers.getHeader(_shared),
      );
      if (response.statusCode == 200) {
        responselogout = ResponseAuth.fromJson(jsonDecode(response.body));
        responselogout.status = true;
      } else if (response.statusCode >= 400) {
        responselogout = ResponseAuth();
        responselogout.message = jsonDecode(response.body)['message'];
        responselogout.status = false;
      }
    } catch (ex) {
      responselogout = ResponseAuth();
      responselogout.message = ex.toString();
      responselogout.status = false;
    }

    return responselogout;
  }

  Future<ResponseAuth?> getProfile() async {
    ResponseAuth? responselogout;

    try {
      final response = await http.get(
        Uri.parse(SittingsApi.PROFILE_ACCOUNT),
        headers: AppHelpers.getHeader(_shared),
      );
      if (response.statusCode == 200) {
        responselogout = ResponseAuth.fromJsonData(jsonDecode(response.body));
        responselogout.status = true;
      } else if (response.statusCode >= 400) {
        responselogout = ResponseAuth();
        responselogout.message = jsonDecode(response.body)['message'];
        responselogout.status = false;
      }
    } catch (ex) {
      responselogout = ResponseAuth();
      responselogout.message = ex.toString();
      responselogout.status = false;
    }

    return responselogout;
  }
}
