import 'package:easy_plus_service_provider/features/main/model/ads.dart';
import 'package:easy_plus_service_provider/features/main/model/meta.dart';
import 'package:easy_plus_service_provider/features/main/model/order_object2.dart';

class HomeResponse {
  bool? status;
  int? code;
  String? message;
  List<OrderObject2>? data;
  List<Ads>? ads;
  Meta? meta;

  HomeResponse({
    this.status,
    this.code,
    this.message,
    this.data,
    this.ads,
    this.meta,
  });

  HomeResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    message = json['message'];
    if (json['data'] != null) {
      data = <OrderObject2>[];
      json['data'].forEach((v) {
        data!.add(OrderObject2.fromJson(v));
      });
    }
    if (json['ads'] != null) {
      ads = <Ads>[];
      json['ads'].forEach((v) {
        if (v['type'] == 'driver') {
          ads!.add(Ads.fromJson(v));
        }
      });
    }
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
  }
}
