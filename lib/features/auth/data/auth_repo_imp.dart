import 'package:easy_plus_service_provider/core/network/api/api_auth.dart';
import 'package:easy_plus_service_provider/features/auth/domin/auth_repo.dart';
import 'package:easy_plus_service_provider/features/auth/model/response_sign_up.dart';
import 'package:easy_plus_service_provider/features/auth/model/user.dart';
import 'package:easy_plus_service_provider/features/main/model/general_response.dart';

class AuthRepoImp extends AuthRepo {
  final ApiAuth _api = ApiAuth();

  @override
  Future<ResponseAuth?> forgetPassword({
    required String other,
    required int socialSelectedIndex,
  }) {
    return _api.forgetPassword(
      other: other,
      socialSelectedIndex: socialSelectedIndex,
    );
  }

  @override
  Future<ResponseAuth?> login({
    required String other,
    required String password,
    required int socialSelectedIndex,
  }) {
    return _api.loginAccount(
      other: other,
      password: password,
      socialSelectedIndex: socialSelectedIndex,
    );
  }

  @override
  Future<ResponseAuth?> register({
    required String name,
    required String other,
    required String gender,
    required String password,
    required int socialSelectedIndex,
  }) {
    return _api.registerAccount(
      name: name,
      other: other,
      gender: gender,
      password: password,
      socialSelectedIndex: socialSelectedIndex,
    );
  }

  @override
  Future<ResponseAuth?> resetPassword({
    required String other,
    required int socialSelectedIndex,
    required String password,
    required String passwordConfirmation,
  }) {
    return _api.resetPassword(
      password: password,
      passwordConfirmation: passwordConfirmation,
      socialSelectedIndex: socialSelectedIndex,
      other: other,
    );
  }

  @override
  Future<ResponseAuth?> verifyCode({
    required String other,
    required String code,
    required int socialSelectedIndex,
  }) {
    return _api.verifyCodeAccount(
      other: other,
      socialSelectedIndex: socialSelectedIndex,
      code: code,
    );
  }

  @override
  Future<ResponseAuth?> updateAccount({required User user}) {
    return _api.updateAccount(user: user);
  }

  @override
  Future<ResponseAuth?> logout() {
    return _api.logoutAccount();
  }

  @override
  Future<ResponseAuth?> changePassword({
    required String currentPass,
    required String newPass,
    required String confirmPass,
  }) {
    return _api.changePassword(
      currentPass: currentPass,
      newPass: newPass,
      confirmPass: confirmPass,
    );
  }

  @override
  Future<GeneralResponse?> updateService({
    required List<int> listCat,
    required int carTypeId,
    required int navRangeId,
  }) {
    return _api.updateServiceAccount(
      listCat: listCat,
      carTypeId: carTypeId,
      navRangeId: navRangeId,
    );
  }

  @override
  Future<ResponseAuth?> profile() {
    return _api.getProfile();
  }
}
