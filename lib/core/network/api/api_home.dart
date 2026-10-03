import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:easy_plus_service_provider/core/network/api/settings_api.dart';
import 'package:easy_plus_service_provider/core/storage/pref/shared_pref_controller.dart';
import 'package:easy_plus_service_provider/core/utils/app_helpers.dart';
import 'package:easy_plus_service_provider/features/auth/model/response_privacy.dart';
import 'package:easy_plus_service_provider/features/main/model/common_quastions_response.dart';
import 'package:easy_plus_service_provider/features/main/model/complaints_response.dart';
import 'package:easy_plus_service_provider/features/main/model/general_response.dart';
import 'package:easy_plus_service_provider/features/main/model/home_response.dart';
import 'package:easy_plus_service_provider/features/main/model/my_offers_response.dart';
import 'package:easy_plus_service_provider/features/main/model/order_response.dart';
import 'package:easy_plus_service_provider/features/main/model/response_app_config.dart';
import 'package:easy_plus_service_provider/features/main/model/response_data.dart';
import 'package:easy_plus_service_provider/features/main/model/response_notification.dart';
import 'package:easy_plus_service_provider/features/main/model/show_order_ids_response.dart';
import 'package:easy_plus_service_provider/features/main/model/wallet/wallet_response.dart';
import 'package:http/http.dart' as http;

class ApiHome {
  final SharedPrefController _shared = SharedPrefController();

  Future<ResponseAppConfig?> getAppConfig() async {
    ResponseAppConfig? responseAppConfig;
    final response;
    try {
      response = await http.get(
        Uri.parse(SittingsApi.APP_CONFIG),
        headers: AppHelpers.getHeader(_shared),
      );

      if (response.statusCode == 200) {
        responseAppConfig =
            ResponseAppConfig.fromJson(jsonDecode(response.body));
        responseAppConfig.status = true;
      } else if (response.statusCode >= 400) {
        responseAppConfig = ResponseAppConfig();
        responseAppConfig.message = jsonDecode(response.body)['message'];
        responseAppConfig.status = false;
      }
    } catch (ex) {
      responseAppConfig = ResponseAppConfig();
      responseAppConfig.message = ex.toString();
      responseAppConfig.status = false;
    }

    return responseAppConfig;
  }

  Future<HomeResponse?> getHomeData({
    required int page,
    // required double lat,
    // required double lng,
    String? categoryId,
    String? orderTypeId,
    String? revisionTypeId,
    String? shoppingTypeId,
    String? tourTypeId,
    String? tourType,
    String? carTypeId,
    String? navRangeId,
    String? pickType,
  }) async {
    HomeResponse? responseHomeData;
    try {
      final response;
      String filter = '?page=$page';
      if (categoryId != null) {
        filter += '&category_id=$categoryId';
      }
      if (orderTypeId != null) {
        filter += '&order_type_id=$orderTypeId';
      }
      if (revisionTypeId != null) {
        filter += '&revision_type_id=$revisionTypeId';
      }
      if (shoppingTypeId != null) {
        filter += '&shopping_type_id=$shoppingTypeId';
      }
      if (tourTypeId != null) {
        filter += '&tour_type_id=$tourTypeId';
      }
      if (tourType != null) {
        filter += '&tour_type=$tourType';
      }

      if (pickType != null) {
        filter += '&pick_type=$pickType';
      }
      if (navRangeId != null) {
        filter += '&nav_range_id=$navRangeId';
      }
      if (carTypeId != null) {
        filter += '&car_type_id=$carTypeId';
      }

      log(SittingsApi.HOME + filter);

      Uri url = Uri.parse(
          SittingsApi.HOME + filter); // Replace with your API endpoint

      // var queryParams = {
      //   'lat': lat,
      //   'lng': lng,
      // };

      // var uri = url.replace(queryParameters: queryParams);

      response = await http.get(
        url,
        headers: AppHelpers.getHeader(_shared),
      );

      if (response.statusCode == 200) {
        responseHomeData = HomeResponse.fromJson(jsonDecode(response.body));
        responseHomeData.status = true;
      } else if (response.statusCode >= 400) {
        responseHomeData = HomeResponse();
        responseHomeData.message = jsonDecode(response.body)['message'];
        responseHomeData.status = false;
      }
    } catch (ex) {
      responseHomeData = HomeResponse();
      responseHomeData.message = ex.toString();
      responseHomeData.status = false;
    }

    return responseHomeData;
  }

  // ! My Offers
  Future<MyOffersResponse?> getMyOffers({
    required String statusOffer,
    required int page,
  }) async {
    MyOffersResponse? responseOrder;
    try {
      final response;
      log("${SittingsApi.GET_MY_OFFER}$statusOffer&page=$page");
      response = await http.get(
        Uri.parse(
          "${SittingsApi.GET_MY_OFFER}$statusOffer&page=$page",
        ),
        headers: AppHelpers.getHeader(_shared),
      );

      if (response.statusCode == 200) {
        responseOrder = MyOffersResponse.fromJson(jsonDecode(response.body));
        responseOrder.status = true;
      } else if (response.statusCode >= 400) {
        responseOrder = MyOffersResponse();
        responseOrder.message = jsonDecode(response.body)['message'];
        responseOrder.status = false;
      }
    } catch (ex) {
      responseOrder = MyOffersResponse();
      responseOrder.message = ex.toString();
      responseOrder.status = false;
    }

    return responseOrder;
  }

  Future<ShowOrderIdsResponse?> getShowOrderIds() async {
    ShowOrderIdsResponse? responseOrderIds;
    try {
      final response = await http.get(
        Uri.parse(SittingsApi.GET_SHOW_ORDER_IDS),
        headers: AppHelpers.getHeader(_shared),
      );
      print(response.statusCode);
      print(response.body);

      if (response.statusCode == 200) {
        responseOrderIds =
            ShowOrderIdsResponse.fromJson(jsonDecode(response.body));
        responseOrderIds.status = true;
      } else if (response.statusCode >= 400) {
        responseOrderIds = ShowOrderIdsResponse();
        responseOrderIds.message = jsonDecode(response.body)['message'];
        responseOrderIds.status = false;
      }
    } catch (ex) {
      responseOrderIds = ShowOrderIdsResponse();
      responseOrderIds.message = ex.toString();
      responseOrderIds.status = false;
    }

    return responseOrderIds;
  }

  // ! Order Details
  Future<OrderResponse?> getDataOrder(
    String orderId,
  ) async {
    OrderResponse? responseDetailsOrder;
    try {
      final response;
      response = await http.get(
        Uri.parse(SittingsApi.GET_DETAILS_ORDER + orderId),
        headers: AppHelpers.getHeader(_shared),
      );
      log(SittingsApi.GET_DETAILS_ORDER + orderId);
      if (response.statusCode == 200) {
        responseDetailsOrder =
            OrderResponse.fromJson(jsonDecode(response.body));
        responseDetailsOrder.status = true;
      } else if (response.statusCode >= 400) {
        responseDetailsOrder = OrderResponse();
        responseDetailsOrder.message = jsonDecode(response.body)['message'];
        responseDetailsOrder.status = false;
      }
    } catch (ex) {
      responseDetailsOrder = OrderResponse();
      responseDetailsOrder.message = ex.toString();
      responseDetailsOrder.status = false;
    }

    return responseDetailsOrder;
  }

  // ! Mack Offer
  Future<GeneralResponse?> mackOffer(
    int orderId,
    double price,
    double tax,
    int isCash,
  ) async {
    GeneralResponse? responseMackOffer;
    try {
      final response;
      response = await http.post(
        Uri.parse(SittingsApi.MACK_OFFER),
        headers: AppHelpers.getHeader(_shared),
        body: {
          'order_id': orderId.toString(),
          'price': price.toString(),
          'tax': tax.toString(),
          'is_cash': isCash.toString(),
        },
      );
      if (response.statusCode == 200) {
        responseMackOffer = GeneralResponse.fromJson(jsonDecode(response.body));
        responseMackOffer.status = true;
      } else if (response.statusCode >= 400) {
        responseMackOffer = GeneralResponse();
        responseMackOffer.message = jsonDecode(response.body)['message'];
        responseMackOffer.status = false;
      }
    } catch (ex) {
      responseMackOffer = GeneralResponse();
      responseMackOffer.message = ex.toString();
      responseMackOffer.status = false;
    }

    return responseMackOffer;
  }

  // ! Cancel Order
  Future<GeneralResponse?> cancelOrder(int orderId) async {
    GeneralResponse? responseCancelOrder;
    try {
      final response = await http.get(
        Uri.parse(SittingsApi.CANCLE_ORDER + orderId.toString()),
        headers: AppHelpers.getHeader(_shared),
      );
      if (response.statusCode == 200) {
        responseCancelOrder =
            GeneralResponse.fromJson(jsonDecode(response.body));
        responseCancelOrder.status = true;
      } else if (response.statusCode >= 400) {
        responseCancelOrder = GeneralResponse();
        responseCancelOrder.message = jsonDecode(response.body)['message'];
        responseCancelOrder.status = false;
      }
    } catch (ex) {
      responseCancelOrder = GeneralResponse();
      responseCancelOrder.message = ex.toString();
      responseCancelOrder.status = false;
    }

    return responseCancelOrder;
  }

  // ! Mack Offer
  Future<CommonQuastionsResponse?> getCommonQus({
    required int page,
  }) async {
    CommonQuastionsResponse? responseCommonQus;
    try {
      final response;
      log("${SittingsApi.COMMON_QUSTION}?&page=$page");
      response = await http.get(
        Uri.parse(
          "${SittingsApi.COMMON_QUSTION}?&page=$page",
        ),
        headers: AppHelpers.getHeader(_shared),
      );

      if (response.statusCode == 200) {
        responseCommonQus =
            CommonQuastionsResponse.fromJson(jsonDecode(response.body));
        responseCommonQus.status = true;
      } else if (response.statusCode >= 400) {
        responseCommonQus = CommonQuastionsResponse();
        responseCommonQus.message = jsonDecode(response.body)['message'];
        responseCommonQus.status = false;
      }
    } catch (ex) {
      responseCommonQus = CommonQuastionsResponse();
      responseCommonQus.message = ex.toString();
      responseCommonQus.status = false;
    }

    return responseCommonQus;
  }

  //! contact us
  Future<ResponseData?> contactUs({
    required String title,
    required String message,
  }) async {
    ResponseData? responseData;
    try {
      final response = await http.post(
        Uri.parse(SittingsApi.CONTACT_US),
        headers: AppHelpers.getHeader(_shared),
        body: {"title": title, "message": message},
      );

      if (response.statusCode == 200) {
        responseData = ResponseData.fromJson(jsonDecode(response.body));
        responseData.status = true;
      } else if (response.statusCode >= 400) {
        responseData = ResponseData();
        responseData.message = jsonDecode(response.body)['message'];
        responseData.status = false;
      }
    } catch (ex) {
      responseData = ResponseData();
      responseData.message = ex.toString();
      responseData.status = false;
    }

    return responseData;
  }

  //! request money
  Future<ResponseData?> pullRequest({
    required String name,
    required String bankName,
    required String ibanNumber,
    required String accountNumber,
    required String amount,
  }) async {
    ResponseData? responseData;
    try {
      final response = await http.post(
        Uri.parse(SittingsApi.PULL_REQUEST),
        headers: AppHelpers.getHeader(_shared),
        body: {
          "name": name,
          "iban_number": ibanNumber,
          "account_number": accountNumber,
          "bank": bankName,
          "amount": amount,
        },
      );

      if (response.statusCode == 200) {
        responseData = ResponseData.fromJson(jsonDecode(response.body));
        responseData.status = true;
      } else if (response.statusCode >= 400) {
        responseData = ResponseData();
        responseData.message = jsonDecode(response.body)['message'];
        responseData.status = false;
      }
    } catch (ex) {
      responseData = ResponseData();
      responseData.message = ex.toString();
      responseData.status = false;
    }

    return responseData;
  }

  Future<ComplaintsResponse?> getComplaints({required int page}) async {
    ComplaintsResponse? responseComplaint;
    try {
      final response;
      response = await http.get(
        Uri.parse("${SittingsApi.COMPLAINTS}?page=$page"),
        headers: AppHelpers.getHeader(_shared),
      );

      if (response.statusCode == 200) {
        responseComplaint =
            ComplaintsResponse.fromJson(jsonDecode(response.body));
        responseComplaint.status = true;
      } else if (response.statusCode >= 400) {
        responseComplaint = ComplaintsResponse();
        responseComplaint.message = jsonDecode(response.body)['message'];
        responseComplaint.status = false;
      }
    } catch (ex) {
      responseComplaint = ComplaintsResponse();
      responseComplaint.message = ex.toString();
      responseComplaint.status = false;
    }

    return responseComplaint;
  }

  Future<ComplaintsResponse?> postComplaints(
    String orderId,
    String desc,
  ) async {
    ComplaintsResponse? responseComplaint;
    try {
      final response = await http.post(Uri.parse(SittingsApi.COMPLAINTS),
          headers: AppHelpers.getHeader(_shared),
          body: {
            'order_id': orderId,
            'desc': desc,
          });

      if (response.statusCode == 200) {
        responseComplaint =
            ComplaintsResponse.fromJsonSend(jsonDecode(response.body));
        responseComplaint.status = true;
      } else if (response.statusCode >= 400) {
        responseComplaint = ComplaintsResponse();
        responseComplaint.message = jsonDecode(response.body)['message'];
        responseComplaint.status = false;
      }
    } catch (ex) {
      responseComplaint = ComplaintsResponse();
      responseComplaint.message = ex.toString();
      responseComplaint.status = false;
    }

    return responseComplaint;
  }

  Future<ResponsePrivacy?> privacyPolicy() async {
    ResponsePrivacy? responsePrivacy;

    try {
      final response;

      response = await http.get(
        Uri.parse(SittingsApi.PRIVACY_POLICY),
        headers: {"Accept": "application/json"},
      );
      if (response.statusCode == 200) {
        responsePrivacy = ResponsePrivacy.fromJson(jsonDecode(response.body));
        responsePrivacy.status = true;
      } else if (response.statusCode >= 400) {
        responsePrivacy = ResponsePrivacy();
        responsePrivacy.message = jsonDecode(response.body)['message'];
        responsePrivacy.status = false;
      }
    } catch (ex) {
      responsePrivacy = ResponsePrivacy();
      responsePrivacy.message = ex.toString();
      responsePrivacy.status = false;
    }

    return responsePrivacy;
  }

  Future<ResponsePrivacy?> termsOfUse() async {
    ResponsePrivacy? responsePrivacy;

    try {
      final response;

      response = await http.get(
        Uri.parse(SittingsApi.TERMS_OF_USE),
        headers: {"Accept": "application/json"},
      );
      if (response.statusCode == 200) {
        responsePrivacy = ResponsePrivacy.fromJson(jsonDecode(response.body));
        responsePrivacy.status = true;
      } else if (response.statusCode >= 400) {
        responsePrivacy = ResponsePrivacy();
        responsePrivacy.message = jsonDecode(response.body)['message'];
        responsePrivacy.status = false;
      }
    } catch (ex) {
      responsePrivacy = ResponsePrivacy();
      responsePrivacy.message = ex.toString();
      responsePrivacy.status = false;
    }

    return responsePrivacy;
  }

  // ! Get Transaction
  Future<WalletResponse?> getTransaction() async {
    WalletResponse? responseWallet;
    try {
      final response;
      response = await http.get(
        Uri.parse(SittingsApi.GET_WALLET),
        headers: AppHelpers.getHeader(_shared),
      );

      if (response.statusCode == 200) {
        responseWallet = WalletResponse.fromJson(jsonDecode(response.body));
        responseWallet.status = true;
      } else if (response.statusCode >= 400) {
        responseWallet = WalletResponse();
        responseWallet.message = jsonDecode(response.body)['message'];
        responseWallet.status = false;
      }
    } catch (ex) {
      responseWallet = WalletResponse();
      responseWallet.message = ex.toString();
      responseWallet.status = false;
    }

    return responseWallet;
  }

  Future<GeneralResponse?> requestBalance(
      int bankId, String image, String name) async {
    GeneralResponse? responseRequentBalance;

    try {
      final response;

      FormData formData = FormData.fromMap({
        'bank_id': bankId,
        'name': name,
        'image': await MultipartFile.fromFile(
          image,
          filename: DateTime.now().toString(),
        ),
      });

      response = await Dio().post(
        SittingsApi.REQUEST_BALANCE,
        data: formData,
        options: Options(
          headers: AppHelpers.getHeader(_shared),
          followRedirects: false,
          validateStatus: (int? status) {
            return status! < 500;
          },
        ),
      );

      if (response.statusCode == 200) {
        responseRequentBalance = GeneralResponse.fromJson(response.data);
        responseRequentBalance.status = true;
      } else if (response.statusCode >= 400) {
        responseRequentBalance = GeneralResponse();
        responseRequentBalance.message = response.data['message'];
        responseRequentBalance.status = false;
      }
    } catch (ex) {
      responseRequentBalance = GeneralResponse();
      responseRequentBalance.message = ex.toString();
      responseRequentBalance.status = false;
    }

    return responseRequentBalance;
  }

  Future<GeneralResponse?> addBalance(double amount) async {
    GeneralResponse? responseAddBalance;
    try {
      final response;
      response = await http.post(
        Uri.parse(SittingsApi.ADD_BALANCE),
        headers: AppHelpers.getHeader(_shared),
        body: {"amount": amount.toString()},
      );

      if (response.statusCode == 200) {
        responseAddBalance =
            GeneralResponse.fromJson(jsonDecode(response.body));
        responseAddBalance.status = true;
      } else if (response.statusCode >= 400) {
        responseAddBalance = GeneralResponse();
        responseAddBalance.message = jsonDecode(response.body)['message'];
        responseAddBalance.status = false;
      }
    } catch (ex) {
      print("error " + ex.toString());
      responseAddBalance = GeneralResponse();
      responseAddBalance.message = ex.toString();
      responseAddBalance.status = false;
    }

    return responseAddBalance;
  }

  Future<GeneralResponse?> updateLocationUser({
    required String address,
    required String lat,
    required String lng,
  }) async {
    GeneralResponse? responseUpdateUser;
    try {
      final response = await http.post(
        Uri.parse(SittingsApi.UPDATE_LOCATION),
        headers: AppHelpers.getHeader(_shared),
        body: {
          "address": address,
          "lat": lat,
          "lng": lng,
        },
      );

      if (response.statusCode == 200) {
        responseUpdateUser =
            GeneralResponse.fromJson(jsonDecode(response.body));
        responseUpdateUser.status = true;
      } else if (response.statusCode >= 400) {
        responseUpdateUser = GeneralResponse();
        responseUpdateUser.message = jsonDecode(response.body)['message'];
        responseUpdateUser.status = false;
      }
    } catch (ex) {
      responseUpdateUser = GeneralResponse();
      responseUpdateUser.message = ex.toString();
      responseUpdateUser.status = false;
    }

    return responseUpdateUser;
  }

  Future<ResponseNotification?> showNotifications() async {
    ResponseNotification? responseNotifications;

    try {
      final response;

      response = await http.get(
        Uri.parse(SittingsApi.NOTIFICATION),
        headers: AppHelpers.getHeader(_shared),
      );
      if (response.statusCode == 200) {
        responseNotifications =
            ResponseNotification.fromJson(jsonDecode(response.body));
        responseNotifications.status = true;
      } else if (response.statusCode >= 400) {
        responseNotifications = ResponseNotification();
        responseNotifications.message = jsonDecode(response.body)['message'];
        responseNotifications.status = false;
      }
    } catch (ex) {
      responseNotifications = ResponseNotification();
      responseNotifications.message = ex.toString();
      responseNotifications.status = false;
    }

    return responseNotifications;
  }
}
