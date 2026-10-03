class ResponseAppConfig {
  App? app;
  bool? status;
  String? message;

  List<Categories>? categories;
  List<CustomClass>? ordersTypes;
  List<CustomClass>? revisionTypes;
  List<CustomClass>? shoppingTypes;
  List<CustomClass>? paymentTypes;
  List<CustomClass>? navRangeTypes;
  List<CustomClass>? carTypes;
  List<CustomClass>? tourTypes;
  List<CustomClass>? mishwarTypes;
  List<CustomClass>? banks;

  ResponseAppConfig({
    this.app,
    this.categories,
    this.ordersTypes,
    this.revisionTypes,
    this.shoppingTypes,
    this.paymentTypes,
    this.navRangeTypes,
    this.carTypes,
    this.tourTypes,
    this.mishwarTypes,
    this.banks,
    this.status,
    this.message,
  });

  ResponseAppConfig.fromJson(Map<String, dynamic> json) {
    app = json['app'] != null ? new App.fromJson(json['app']) : null;
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories!.add(Categories.fromJson(v));
      });
    }
    if (json['orders_types'] != null) {
      ordersTypes = <CustomClass>[];
      json['orders_types'].forEach((v) {
        ordersTypes!.add(CustomClass.fromJson(v));
      });
    }

    if (json['revision_types'] != null) {
      revisionTypes = <CustomClass>[];
      json['revision_types'].forEach((v) {
        revisionTypes!.add(CustomClass.fromJson(v));
      });
    }
    if (json['shopping_types'] != null) {
      shoppingTypes = <CustomClass>[];
      json['shopping_types'].forEach((v) {
        shoppingTypes!.add(CustomClass.fromJson(v));
      });
    }
    if (json['payment_types'] != null) {
      paymentTypes = <CustomClass>[];
      json['payment_types'].forEach((v) {
        paymentTypes!.add(CustomClass.fromJson(v));
      });
    }
    if (json['nav_range_types'] != null) {
      navRangeTypes = <CustomClass>[];
      json['nav_range_types'].forEach((v) {
        navRangeTypes!.add(CustomClass.fromJson(v));
      });
    }
    if (json['car_types'] != null) {
      carTypes = <CustomClass>[];
      json['car_types'].forEach((v) {
        carTypes!.add(CustomClass.fromJson(v));
      });
    }
    if (json['tour_types'] != null) {
      tourTypes = <CustomClass>[];
      json['tour_types'].forEach((v) {
        tourTypes!.add(CustomClass.fromJson(v));
      });
    }
    if (json['mishwar_types'] != null) {
      mishwarTypes = <CustomClass>[];
      json['mishwar_types'].forEach((v) {
        mishwarTypes!.add(CustomClass.fromJson(v));
      });
    }
    if (json['banks'] != null) {
      banks = <CustomClass>[];
      json['banks'].forEach((v) {
        banks!.add(CustomClass.fromJson(v));
      });
    }
  }
}

class App {
  String? title;
  String? subTitle;
  String? logo;
  String? tax;
  String? splash;
  String? orderDuration;
  // String? cancelOrderTax;
  String? minAmountCash;
  String? maxDeposit;
  String? minDeposit;
  String? minWithdrawal;
  String? maxWithdrawal;
  String? paymentGatewayCommission;
  String? androidVersionCode;
  String? iosVersionCode;
  bool? isUploadAppAndroid;
  bool? isUploadAppIos;
  App({
    this.title,
    this.subTitle,
    this.logo,
    this.splash,
    this.orderDuration,
    // this.cancelOrderTax,
    this.tax,
    this.minAmountCash,
    this.maxDeposit,
    this.minDeposit,
    this.minWithdrawal,
    this.maxWithdrawal,
    this.paymentGatewayCommission,
  });

  App.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    subTitle = json['sub_title'];
    logo = json['logo'];
    tax = json['tax'];
    splash = json['driver_splash'];
    orderDuration = json['order_duration'];
    // cancelOrderTax = json['cancel_order_tax'];
    minAmountCash = json['min_amount_cash'];
    paymentGatewayCommission = json['payment_gateway_commission'];

    maxDeposit = json['max_deposit'];
    minDeposit = json['min_deposit'];

    minWithdrawal = json['min_withdrawal'];
    maxWithdrawal = json['max_withdrawal'];

    androidVersionCode = json['android_version_code'];
    iosVersionCode = json['ios_version_code'];

    isUploadAppAndroid = json['is_upload_app_android'];
    isUploadAppIos = json['is_upload_app_ios'];
  }
}

class Categories {
  int? id;
  String? name;
  String? icon;
  bool? isSelected;
  int? tax;
  String? minOrderPrice;
  String? maxOrderPrice;
  String? cancellationDriver;
  String? cancellationUser;

  Categories({
    this.id,
    this.name,
    this.icon,
    this.isSelected,
    this.tax,
    this.minOrderPrice,
    this.maxOrderPrice,
    this.cancellationDriver,
    this.cancellationUser,
  });

  Categories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    icon = json['icon'];
    tax = json['tax'];
    minOrderPrice = json['min_order_price'];
    maxOrderPrice = json['max_order_price'];

    cancellationDriver = json['cancellation_driver'];
    cancellationUser = json['cancellation_user'];
    isSelected = false;
  }
}

class CustomClass {
  int? id;
  String? name;
  String? title;
  String? iban;
  String? navRange;
  String? accountNumber;
  String? type;
  bool? isSelected;

  CustomClass({
    this.id,
    this.name,
    this.title,
    this.accountNumber,
    this.iban,
    this.type,
    this.navRange,
    this.isSelected = false,
  });

  CustomClass.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    title = json['title'];
    iban = json['iban'];
    navRange = json['nav_range'];
    type = json['type'];
    accountNumber = json['account_number'];
    isSelected = false;
  }
}
