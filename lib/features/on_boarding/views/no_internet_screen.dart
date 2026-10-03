import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:easy_plus_service_provider/core/utils/app_helpers.dart';
import 'package:easy_plus_service_provider/core/widgets/my_elevated_button.dart';
import 'package:easy_plus_service_provider/core/widgets/my_text.dart';
import 'package:easy_plus_service_provider/features/main/views/pages/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NoInternetScreen extends StatefulWidget {
  final bool fromSplashScreen;
  NoInternetScreen({required this.fromSplashScreen});

  @override
  State<NoInternetScreen> createState() => _NoInternetScreenState();
}

class _NoInternetScreenState extends State<NoInternetScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: AppBar(leading: const SizedBox()),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 40.r),
                Lottie.asset('assets/images/ic_json/no_internet.json',
                    fit: BoxFit.contain, width: 300.r, height: 400.r),
                SizedBox(width: double.infinity, height: 30.r),
                MyText(title: 'لا يوجد اتصال بالانترنت، حاول مرة اخرى'),
                SizedBox(width: double.infinity, height: 20.r),
                MyElevatedButton(
                  title: 'اتصل مرة اخرى',
                  onPressed: () async {
                    var connectivityResult =
                        await (Connectivity().checkConnectivity());

                    if (connectivityResult == ConnectivityResult.wifi) {
                      if (widget.fromSplashScreen) {
                        AppHelpers.navigationReplacementToPage(
                            context, const MainScreen());
                      } else {
                        Navigator.pop(context);
                      }
                    } else {
                      AppHelpers.showSnackBar(context,
                          message: 'تحقق من اتصالك بالانترنت', error: true);
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
