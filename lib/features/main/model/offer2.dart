import 'package:easy_plus_service_provider/features/auth/model/user.dart';

class Offer {
  int? id;
  User? user;
  String? category;
  String? showTime;
  String? orderNum;
  int? orderId;
  String? createdAt;

  Offer({
    this.id,
    this.user,
    this.showTime,
    this.category,
    this.orderNum,
    this.orderId,
    this.createdAt,
  });

  Offer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    category = json['category'];
    orderNum = json['order_num'];
    orderId = json['order_id'];
    showTime = json['show_time'];
    createdAt = json['created_at'];
  }
}
