import 'dart:developer';
import 'package:easy_plus_service_provider/features/main/views/manager/settings_cubit/settings_cubit.dart';
import 'package:flutter_clickpay_bridge/BaseBillingShippingInfo.dart';
import 'package:flutter_clickpay_bridge/PaymentSdkConfigurationDetails.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:easy_plus_service_provider/core/storage/pref/shared_pref_controller.dart';
import 'package:easy_plus_service_provider/core/utils/app_colors.dart';
import 'package:easy_plus_service_provider/core/widgets/my_text.dart';
import 'package:easy_plus_service_provider/features/main/views/manager/language_cubit/language_cubit.dart';
import 'package:easy_plus_service_provider/features/on_boarding/views/no_internet_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_clickpay_bridge/IOSThemeConfiguration.dart';
import 'package:flutter_clickpay_bridge/PaymentSdkLocale.dart';
import 'package:flutter_clickpay_bridge/flutter_clickpay_bridge.dart';

class AppHelpers {
  static void navigationReplacementToPage(BuildContext context, Widget screen) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => screen,
      ),
    );
  }

  static void navigationToPageAndExitAll(BuildContext context, Widget screen) {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => screen),
        (Route<dynamic> route) => false);
  }

  static void navigationToPageAndExitAllWithoutFirst(BuildContext context) {
    Navigator.popUntil(context, (route) => route.isFirst);
  }

  static void navigationToPage(BuildContext context, Widget screen) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => screen,
      ),
    );
  }

  static showSnackBar(
    BuildContext context, {
    required String message,
    Color? textColor,
    Color? background,
    bool error = false,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: MyText(
          title: message,
          fontSize: 14,
          color: textColor ?? AppColors.WHITE,
        ),
        behavior: SnackBarBehavior.floating,
        elevation: 0,
        backgroundColor: error
            ? Color.fromARGB(255, 132, 33, 13)
            : Color.fromARGB(255, 16, 98, 16),
      ),
    );
  }

  static MaterialIndicatorDelegate getIndecatorDelegate() {
    return MaterialIndicatorDelegate(
      builder: (context, controller) {
        return Icon(
          Icons.refresh,
          color: Theme.of(context).colorScheme.primary,
          size: 30,
        );
      },
      scrollableBuilder: (context, child, controller) {
        return Opacity(
          opacity: 1.0 - controller.value.clamp(0.0, 1.0),
          child: child,
        );
      },
    );
  }

  static Set<Factory<OneSequenceGestureRecognizer>> getGesture() {
    return Set()
      ..add(Factory<PanGestureRecognizer>(() => PanGestureRecognizer()))
      ..add(Factory<ScaleGestureRecognizer>(() => ScaleGestureRecognizer()))
      ..add(Factory<TapGestureRecognizer>(() => TapGestureRecognizer()))
      ..add(Factory<VerticalDragGestureRecognizer>(
          () => VerticalDragGestureRecognizer()))
      ..add(Factory<HorizontalDragGestureRecognizer>(
          () => HorizontalDragGestureRecognizer()));
  }

  static Map<String, String> getHeader(SharedPrefController shared) {
    if (shared.getToken != null) {
      return {
        "Accept": "application/json",
        'Authorization': 'Bearer ${shared.getToken}',
        // 'Authorization':
        //     'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiYTgyZGM0MWExNjdkYjY0YjIyZTE4Mzk3NWFkMWQwY2RkOTJlYjdjM2Y1ZTg0Nzc5YTkyODc0NmFmOTdiMmQ3MmUwNGI2ZDFmZmU0MjhjZTUiLCJpYXQiOjE2ODExMTgwOTUuMTU3MDM4LCJuYmYiOjE2ODExMTgwOTUuMTU3MDQsImV4cCI6MTcxMjc0MDQ5NS4xNTEwNjIsInN1YiI6IjMiLCJzY29wZXMiOlsidXNlciJdfQ.TwzpcIKObzZEOJ_sEFNVL0l40ogWI1Tc5AxlY2IZVeF4yxoyNfqDjOCFihEMX-blmIzts0wZzOSq_8h3WRxiKd9Zk_W-bIdY7fGZ9QuGOLepz81q4-4E9p4WZUP2LdjX4f_vXh14Jf8FdeLbPNwKQPV2t4Ga_s49--bmbSUnp29UglTIA1n5o10gegPMtP1l4QeVe3R11zWhKj7XoPgAPCP2xXUkvJxCcJGJm3fRawito4VArNeniq8lFgJZWrBeLyXTl-DH09sa4pcLlw0XJgtXt4_ItI5cH-HuAtXotukXj9tEa2tbvawgbkH6_bvxEzEc2SX_s38ziwvQModI7nXVUi6qMDZM6RjEh9z1zA_8QZ5wGG9xGDnAF8rVycAhKohaLT8cF9t7ohyZtv1s-6WreEQsDPAJKcK_k_Yp0ZEzeFZhVWILJ7kj0IlWBAsdnk-pH09pGXWiF5QLe28SZQKLlkFmPwx8BsiGRMZhO5kQAv7Hq7eTIV-U1SSmx7BG0weRQqpZhj_4eR5MCYk43CJHsvahgMrHkLW4w4HXKbbr-TodrOvf84hco80v6ouEwK6C6XVF8vvUCya8sFkM-gQPpMCe-YKoO5v4GkTdFIxn-oNOa_joD0w8kHquAonuYrRPOqcittMOUv4N6d_DdG-Q2AVEvYj8cCAC1oMFmfY',

        'lang': shared.getLang
      };
    } else {
      return {"Accept": "application/json", 'lang': shared.getLang};
    }
  }

  static Future<void> initConnectivity(
      Connectivity connectivity, bool mounted) async {
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      await connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      log('Couldn\'t check connectivity status', error: e);
      return;
    }
    if (!mounted) {
      return Future.value(null);
    }
  }

  static void goToNoInternetScreen(
      ConnectivityResult result, BuildContext context, bool fromSplashScreen) {
    if (result == ConnectivityResult.none) {
      if (fromSplashScreen) {
        navigationReplacementToPage(
            context, NoInternetScreen(fromSplashScreen: fromSplashScreen));
      } else {
        navigationToPage(
            context, NoInternetScreen(fromSplashScreen: fromSplashScreen));
      }
    }
  }

  static String getNumberEnglish(String text) {
    return text
        .replaceAll('٠', '0')
        .replaceAll('١', '1')
        .replaceAll('٢', '2')
        .replaceAll('٣', '3')
        .replaceAll('٤', '4')
        .replaceAll('٥', '5')
        .replaceAll('٦', '6')
        .replaceAll('٧', '7')
        .replaceAll('٨', '8')
        .replaceAll('٩', '9');
  }

  static clickPayment(
    BuildContext context, {
    required double amount,
    required double paymentPrice,
    required bool minus,
    int? offerId,
  }) {
    var billingDetails = BillingDetails(
      "John Smith",
      "email@domain.com",
      "+97311111111",
      "st. 12",
      "eg",
      "dubai",
      "dubai",
      "12345",
    );
    var shippingDetails = ShippingDetails(
      "John Smith",
      "email@domain.com",
      "+97311111111",
      "st. 12",
      "eg",
      "dubai",
      "dubai",
      "12345",
    );

    var configuration = PaymentSdkConfigurationDetails(
      profileId: "42733",
      serverKey: "SJJNLM6NHT-J6GNNRGMJM-2L2NTRMTJN",
      clientKey: "CNKMD2-9BVH6G-TQQRTN-QDRVTD",
      cartId: "cart id",
      cartDescription: "cart desc",
      // merchantName: "merchant name",
      iOSThemeConfigurations: IOSThemeConfigurations(
        logoImage: 'assets/images/app_icon.png',
        secondaryColor: 'FEBB1B',
        primaryFontColor: 'FEBB1B',
        secondaryFontColor: '6D6C70',
        strokeColor: '673AB7',
        buttonColor: 'FEBB1B',
      ),

      screentTitle: AppLocalizations.of(context)!.electronicPayment,
      billingDetails: billingDetails,
      shippingDetails: shippingDetails,
      locale: LanguageCubit.get(context).indexLang == 0
          ? PaymentSdkLocale.AR
          : PaymentSdkLocale
              .EN, //PaymentSdkLocale.AR or PaymentSdkLocale.DEFAULT
      amount: paymentPrice,
      currencyCode: "SAR",
      merchantCountryCode: "SA",
    );

    configuration.showBillingInfo = false;
    configuration.showShippingInfo = false;

    FlutterPaymentSdkBridge.startCardPayment(configuration, (event) async {
      log("status : " + event["status"]);
      if (event["status"] == "success") {
        SettingsCubit.get(context)
            .addBalance(context, amount: amount, id: offerId);

        var transactionDetails = event["data"];
        log(transactionDetails.toString());
      } else if (event["status"] == "error") {
        // Handle error here.
      } else if (event["status"] == "event") {
        // Handle events here.
      }
    });
  }

  static bool isDigit(String s) {
    return int.tryParse(s) != null;
  }

  static String getTextWithoutNum(String text) {
    String result = "";
    int digitCount = 0;

    for (int i = 0; i < text.length; i++) {
      if (isDigit(text[i])) {
        digitCount++;

        if (digitCount <= 3) {
          result += text[i];
        }
      } else {
        digitCount = 0;
        result += text[i];
      }
    }

    if (digitCount > 3) {
      result = result.replaceAll(RegExp(r'[0-9]'), ''); // إزالة جميع الأرقام
    }
    return result;
  }

  static Future<String?> selectDate(BuildContext context) async {
    DateTime selectedDate = DateTime.now();
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      return "${selectedDate.toLocal()}".split(' ')[0];
    }
    return null;
  }
}
