import 'package:easy_plus_service_provider/features/main/model/meta.dart';
import 'package:easy_plus_service_provider/features/main/model/offer2.dart';

class MyOffersResponse {
  bool? status;
  int? code;
  String? message;
  List<Offer>? data;
  Meta? meta;

  MyOffersResponse({
    this.status,
    this.code,
    this.message,
    this.data,
    this.meta,
  });

  MyOffersResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Offer>[];
      json['data'].forEach((v) {
        data!.add(Offer.fromJson(v));
      });
    }
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
  }
}
