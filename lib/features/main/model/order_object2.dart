import 'package:easy_plus_service_provider/features/auth/model/user.dart';

class OrderObject2 {
  int? id;
  User? user;
  String? startAddress;
  String? endAddress;
  String? category;
  double? lat;
  double? lng;
  String? categoryIcon;

  OrderObject2({
    this.id,
    this.user,
    this.lat,
    this.lng,
    this.startAddress,
    this.endAddress,
    this.category,
    this.categoryIcon,
  });

  OrderObject2.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    startAddress = json['start_address'];
    endAddress = json['end_address'];
    category = json['category'];
    categoryIcon = json['category_icon'];
    lat = json['lat'] != null ? double.parse(json['lat']) : null;
    lng = json['lng'] != null ? double.parse(json['lng']) : null;
  }
}
