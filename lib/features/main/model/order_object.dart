import 'package:easy_plus_service_provider/features/auth/model/user.dart';
import 'package:easy_plus_service_provider/features/main/model/driver.dart';
import 'package:easy_plus_service_provider/features/main/model/offer.dart';

class OrderObject {
  int? id;
  String? startLng;
  String? startLat;
  String? startAddress;
  String? endLng;
  String? endLat;
  String? endAddress;
  String? number;
  String? category;
  String? tax;
  String? status;
  String? carType;
  String? pickType;
  String? paymentTypes;
  String? isCash;
  String? navRange;
  String? driverGender;
  String? tourTypeStatus;
  String? tourType;
  String? shoppingTypeId;
  String? revisionType;
  String? tourTime;
  String? seatsNumber;
  String? desc;
  String? initialPrice;
  Driver? driver;
  User? user;
  List<Offers>? offers;
  String? review;
  String? createdAt;
  String? duration;
  int? categoryId;
  String? daysCount;
  String? startDate;
  String? driverGenderId;
  String? reviewer;
  String? shoppingDestination;
  String? reservationType;
  String? orderType;

  OrderObject({
    this.id,
    this.startLng,
    this.startLat,
    this.startAddress,
    this.endLng,
    this.endLat,
    this.endAddress,
    this.number,
    this.category,
    this.status,
    this.carType,
    this.pickType,
    this.tax,
    this.paymentTypes,
    this.isCash,
    this.navRange,
    this.driverGender,
    this.tourTypeStatus,
    this.tourType,
    this.shoppingTypeId,
    this.revisionType,
    this.tourTime,
    this.seatsNumber,
    this.desc,
    this.initialPrice,
    this.driver,
    this.user,
    this.offers,
    this.review,
    this.createdAt,
    this.duration,
    this.categoryId,
    this.daysCount,
    this.startDate,
    this.driverGenderId,
    this.reviewer,
    this.shoppingDestination,
    this.reservationType,
    this.orderType,
  });

  OrderObject.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    startLng = json['start_lng'];
    startLat = json['start_lat'];
    startAddress = json['start_address'];
    endLng = json['end_lng'];
    endLat = json['end_lat'];
    endAddress = json['end_address'];
    number = json['number'];
    category = json['category'];
    tax = json['tax'];
    status = json['status'];
    carType = json['car_type'];
    pickType = json['pick_type'];
    paymentTypes = json['payment_types'];
    isCash = json['is_cash'];
    navRange = json['nav_range'];
    driverGender = json['driver_gender'];
    tourTypeStatus = json['tour_type_status'];
    tourType = json['tour_type'];
    shoppingTypeId = json['shopping_type_id'];
    revisionType = json['revision_type'];
    tourTime = json['tour_time'];
    seatsNumber = json['seats_number'];
    desc = json['desc'];
    initialPrice = json['initial_price'];
    duration = json['duration'];
    categoryId = int.parse(json['category_id'].toString());
    daysCount = json['days_count'].toString();
    startDate = json['start_date'].toString();
    driverGenderId = json['driver_gender_id'].toString();

    driver = json['driver'] != null ? Driver.fromJson(json['driver']) : null;
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    if (json['offers'] != null) {
      offers = <Offers>[];
      json['offers'].forEach((v) {
        offers!.add(Offers.fromJson(v));
      });
    }
    review = json['review'];
    createdAt = json['created_at'];
    reviewer = json['reviewer'].toString();
    reservationType = json['reservation_type'].toString();
    shoppingDestination = json['shopping_destination'].toString();
    orderType = json['order_type'].toString();
  }
}
