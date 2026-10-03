import 'dart:convert';

import 'package:easy_plus_service_provider/core/network/api/settings_api.dart';
import 'package:easy_plus_service_provider/features/on_boarding/model/response_login_method.dart';
import 'package:http/http.dart' as http;

class ApiOnboarding {
  Future<ResponseLoginMethod?> getLoginMethods() async {
    ResponseLoginMethod? responseData;
    try {
      final response = await http.get(
        Uri.parse(SittingsApi.SHOW_LOGIN_METHOD),
      );

      if (response.statusCode == 200) {
        responseData = ResponseLoginMethod.fromJson(jsonDecode(response.body));
        responseData.status = true;
        responseData.is500 = false;
      } else if (response.statusCode >= 400 && response.statusCode < 500) {
        responseData = ResponseLoginMethod();
        responseData.message = jsonDecode(response.body)['message'];
        responseData.status = false;
        responseData.is500 = false;
      } else if (response.statusCode >= 500) {
        responseData = ResponseLoginMethod();
        responseData.message = jsonDecode(response.body)['message'];
        responseData.status = false;
        responseData.is500 = true;
      }
    } catch (ex) {
      responseData = ResponseLoginMethod();
      responseData.message = ex.toString();
      responseData.status = false;
      responseData.is500 = false;
    }

    return responseData;
  }
}
