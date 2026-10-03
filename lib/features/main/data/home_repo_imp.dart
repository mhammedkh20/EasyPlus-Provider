import 'package:easy_plus_service_provider/core/network/api/api_home.dart';
import 'package:easy_plus_service_provider/features/auth/model/response_privacy.dart';
import 'package:easy_plus_service_provider/features/main/domin/home_repo.dart';
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

class HomeRepoImp extends HomeRepo {
  final ApiHome _api = ApiHome();

  @override
  Future<ResponseAppConfig?> getAppConfig() {
    return _api.getAppConfig();
  }

  @override
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
  }) {
    return _api.getHomeData(
      // lat: lat,
      // lng: lng,
      page: page,
      categoryId: categoryId,
      orderTypeId: orderTypeId,
      revisionTypeId: revisionTypeId,
      shoppingTypeId: shoppingTypeId,
      tourTypeId: tourTypeId,
      tourType: tourType,
      carTypeId: carTypeId,
      navRangeId: navRangeId,
      pickType: pickType,
    );
  }

  @override
  Future<MyOffersResponse?> getOffers(String statusOffer, int page) {
    return _api.getMyOffers(statusOffer: statusOffer, page: page);
  }

  @override
  Future<OrderResponse?> getOrderDetails(String orderId) {
    return _api.getDataOrder(orderId.toString());
  }

  @override
  Future<GeneralResponse?> mackOffer(
      int orderId, double price, double tax, int isCash) {
    return _api.mackOffer(orderId, price, tax, isCash);
  }

  @override
  Future<GeneralResponse?> cancelOrder(int orderId) {
    return _api.cancelOrder(orderId);
  }

  @override
  Future<CommonQuastionsResponse?> getCommonQus(int page) {
    return _api.getCommonQus(page: page);
  }

  @override
  Future<ResponseData?> sendContactUs({
    required String title,
    required String message,
  }) {
    return _api.contactUs(title: title, message: message);
  }

  @override
  Future<ResponseData?> requestMoney(
      {required String name,
      required String ibanNumber,
      required String bankName,
      required String amount,
      required String accountNumber}) {
    return _api.pullRequest(
      name: name,
      ibanNumber: ibanNumber,
      bankName: bankName,
      accountNumber: accountNumber,
      amount: amount,
    );
  }

  @override
  Future<ComplaintsResponse?> getComplaintsResponse({required int page}) {
    return _api.getComplaints(page: page);
  }

  @override
  Future<ComplaintsResponse?> sendComplaints({
    required String orderId,
    required String desc,
  }) {
    return _api.postComplaints(orderId, desc);
  }

  @override
  Future<ResponsePrivacy?> privacyPolicy() {
    return _api.privacyPolicy();
  }

  @override
  Future<WalletResponse?> getTransactions() {
    return _api.getTransaction();
  }

  @override
  Future<ResponsePrivacy?> termsOfUse() {
    return _api.termsOfUse();
  }

  @override
  Future<GeneralResponse?> requestBalance(
      {required int bankId, required String image, required String name}) {
    return _api.requestBalance(bankId, image, name);
  }

  Future<GeneralResponse?> addBalance({required double amount}) {
    return _api.addBalance(amount);
  }

  @override
  Future<GeneralResponse?> updateLocation({
    required String address,
    required String lat,
    required String lng,
  }) {
    return _api.updateLocationUser(
      address: address,
      lat: lat,
      lng: lng,
    );
  }

  @override
  Future<ResponseNotification?> showNotifications() {
    return _api.showNotifications();
  }

  @override
  Future<ShowOrderIdsResponse?> showOrderIds() async {
    return _api.getShowOrderIds();
  }
}
