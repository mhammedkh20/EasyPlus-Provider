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

abstract class HomeRepo {
  Future<ResponseAppConfig?> getAppConfig();

  Future<HomeResponse?> getHomeData({
    required int page,
    // required double lat,
    // required double lng,
    String? categoryId,
    String? orderTypeId,
    String? revisionTypeId,
    String? shoppingTypeId,
    String? carTypeId,
    String? navRangeId,
    String? pickType,
  });

  Future<MyOffersResponse?> getOffers(String status, int page);

  Future<OrderResponse?> getOrderDetails(String orderId);

  Future<GeneralResponse?> mackOffer(
    int orderId,
    double price,
    double tax,
    int isCash,
  );
  Future<GeneralResponse?> cancelOrder(int orderId);

  Future<CommonQuastionsResponse?> getCommonQus(int page);

  Future<ResponseData?> sendContactUs({
    required String title,
    required String message,
  });

  Future<ResponseData?> requestMoney({
    required String name,
    required String ibanNumber,
    required String amount,
    required String accountNumber,
    required String bankName,
  });

  Future<ComplaintsResponse?> getComplaintsResponse({required int page});
  Future<ComplaintsResponse?> sendComplaints({
    required String orderId,
    required String desc,
  });

  Future<ResponsePrivacy?> privacyPolicy();
  Future<ResponsePrivacy?> termsOfUse();

  Future<WalletResponse?> getTransactions();

  Future<GeneralResponse?> requestBalance({
    required int bankId,
    required String image,
    required String name,
  });
  Future<GeneralResponse?> updateLocation({
    required String address,
    required String lat,
    required String lng,
  });

  Future<ResponseNotification?> showNotifications();

  Future<ShowOrderIdsResponse?> showOrderIds();
}
