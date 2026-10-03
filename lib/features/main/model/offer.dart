import 'package:easy_plus_service_provider/features/main/model/driver.dart';

class Offers {
  int? id;
  Driver? driver;
  String? price;
  int? limitTime;
  String? isCash;

  Offers({this.id, this.driver, this.price, this.limitTime, this.isCash});

  Offers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    driver = json['driver'] != null ? Driver.fromJson(json['driver']) : null;
    price = json['price'];
    limitTime = json['limit_time'];
    isCash = json['is_cash'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    if (driver != null) {
      data['driver'] = driver!.toJson();
    }
    data['price'] = price;
    data['limit_time'] = limitTime;
    data['is_cash'] = isCash;
    return data;
  }
}
