import 'package:easy_plus_service_provider/features/auth/model/user.dart';
import 'package:easy_plus_service_provider/features/main/model/general_response.dart';
import '../model/response_sign_up.dart';

abstract class AuthRepo {
  // ! Auth
  Future<ResponseAuth?> login({
    required String other,
    required int socialSelectedIndex,
    required String password,
  });

  Future<ResponseAuth?> register({
    required String name,
    required String password,
    required String other,
    required String gender,
    required int socialSelectedIndex,
  });

  Future<ResponseAuth?> verifyCode({
    required String other,
    required String code,
    required int socialSelectedIndex,
  });

  Future<ResponseAuth?> resetPassword({
    required String other,
    required int socialSelectedIndex,
    required String password,
    required String passwordConfirmation,
  });

  Future<ResponseAuth?> forgetPassword({
    required String other,
    required int socialSelectedIndex,
  });

  Future<ResponseAuth?> updateAccount({required User user});

  Future<ResponseAuth?> changePassword({
    required String currentPass,
    required String newPass,
    required String confirmPass,
  });

  Future<ResponseAuth?> logout();

  Future<GeneralResponse?> updateService({
    required List<int> listCat,
    required int carTypeId,
    required int navRangeId,
  });

  Future<ResponseAuth?> profile();
}
