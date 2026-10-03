import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_picker_dialog.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:easy_plus_service_provider/core/utils/app_colors.dart';
import 'package:easy_plus_service_provider/core/widgets/my_elevated_button.dart';
import 'package:easy_plus_service_provider/core/widgets/my_text.dart';
import 'package:easy_plus_service_provider/features/auth/views/manager/auth_cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:selectable_autolink_text/selectable_autolink_text.dart';

class AppDialogs {
  static showCountryPicker(BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) => Theme(
        data: Theme.of(context).copyWith(primaryColor: Colors.pink),
        child: CountryPickerDialog(
          titlePadding: EdgeInsets.all(8.r),
          searchCursorColor: Colors.pinkAccent,
          searchInputDecoration:
              InputDecoration(hintText: AppLocalizations.of(context)!.search),
          isSearchable: true,
          title: MyText(
            title: AppLocalizations.of(context)!.selectYourPhoneCode,
          ),
          onValuePicked: (Country country) {
            print(country.isoCode);
            print(country.iso3Code);
            print(country.name);
            print(country.phoneCode);

            AuthCubit.get(context).selectCountry(country);
          },
          itemFilter: (c) => [
            'SA',
            'AE',
            'QA',
            'KW',
            'BH',
            'OM',
            'EG',
            'JO',
          ].contains(c.isoCode),
          priorityList: [
            CountryPickerUtils.getCountryByIsoCode('SA'),
          ],
          itemBuilder: (country) => Row(
            children: <Widget>[
              CountryPickerUtils.getDefaultFlagImage(country),
              SizedBox(width: 8.w),
              MyText(
                title: "+${country.phoneCode}",
                fontSize: 16,
              ),
              SizedBox(width: 8.w),
              MyText(
                title: country.name,
                fontSize: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }

  static showDeleteOrderDialog(
    BuildContext context, {
    required double price,
    required Function()? onPressedNo,
    required Function()? onPressedYes,
  }) {
    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(11.r)),
      backgroundColor: AppColors.WHITE,
      contentPadding: EdgeInsets.zero,
      titlePadding: EdgeInsets.zero,
      buttonPadding: EdgeInsets.zero,
      iconPadding: EdgeInsets.zero,
      insetPadding: EdgeInsets.zero,
      actionsPadding: EdgeInsets.zero,
      content: SizedBox(
        width: MediaQuery.of(context).size.width - 40.w,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Lottie.asset(
                'assets/images/ic_json/ic_delete.json',
                width: 150.r,
                height: 150.r,
              ),
              MyText(
                title:
                    AppLocalizations.of(context)!.areYouSureToCancelTheRequest,
                fontWeight: FontWeight.bold,
              ),
              SizedBox(height: 5.h),
              MyText(
                title: AppLocalizations.of(context)!.willBeDeducted +
                    price.toString() +
                    AppLocalizations.of(context)!.dueCancellationOrder,
                fontSize: 13,
                color: AppColors.GRAY3,
              ),
              SizedBox(height: 50.h),
              Row(
                children: [
                  Expanded(
                    child: MyElevatedButton(
                      borderRaduis: 30,
                      height: 50,
                      title: AppLocalizations.of(context)!.yes,
                      onPressed: onPressedYes,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      background: AppColors.RED,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: MyElevatedButton(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      borderRaduis: 30,
                      height: 50,
                      titleColor: AppColors.BLACK,
                      background: AppColors.YELLOW_LIGHT.withOpacity(.5),
                      title: AppLocalizations.of(context)!.no,
                      onPressed: onPressedNo,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  static showLoadingDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      shadowColor: AppColors.TRANSPARENT,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(11.r)),
      backgroundColor: AppColors.TRANSPARENT,
      contentPadding: EdgeInsets.zero,
      titlePadding: EdgeInsets.zero,
      buttonPadding: EdgeInsets.zero,
      iconPadding: EdgeInsets.zero,
      insetPadding: EdgeInsets.zero,
      actionsPadding: EdgeInsets.zero,
      content: Center(
        child: LottieBuilder.asset(
          'assets/images/ic_json/loading2.json',
          width: 200.r,
        ),
      ),
    );

    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  static customDialog(
    BuildContext context, {
    required Function()? onPressedBack,
    required Function()? onPressedDelete,
    Color? iconColor = AppColors.RED,
    Color? baceColor = AppColors.RED,
    Color? desc1Color = AppColors.GRAY,
    double sizeHeader = 100,
    String? titleBace,
    double iconSize = 24,
    String? iconHeader = 'assets/images/ic_delete.svg',
    required String? titleHeader,
    bool png = false,
    bool isHeader = true,
    String? desc1,
    String? desc2,
    TextAlign textAlignDisk1 = TextAlign.start,
  }) {
    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
      backgroundColor: AppColors.WHITE,
      contentPadding: EdgeInsets.zero,
      titlePadding: EdgeInsets.zero,
      buttonPadding: EdgeInsets.zero,
      iconPadding: EdgeInsets.zero,
      insetPadding: EdgeInsets.zero,
      actionsPadding: EdgeInsets.zero,
      content: SizedBox(
        width: MediaQuery.of(context).size.width - 52.w,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isHeader) ...[
              SizedBox(
                height: sizeHeader.h,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    iconHeader == null
                        ? const SizedBox()
                        : png
                            ? Image.asset(
                                iconHeader,
                                width: iconSize.w,
                                color: iconColor,
                              )
                            : SvgPicture.asset(
                                iconHeader,
                                width: 24.w,
                                color: iconColor,
                              ),
                    titleHeader != null && iconHeader != null
                        ? SizedBox(height: 10.h)
                        : const SizedBox(),
                    titleHeader == null
                        ? const SizedBox()
                        : MyText(
                            title: titleHeader,
                            fontSize: 14,
                            color: AppColors.RED,
                          ),
                  ],
                ),
              ),
              Divider(
                color: AppColors.BORDER,
                height: 1.h,
                thickness: 1,
              ),
            ],
            Container(
              padding: EdgeInsets.symmetric(horizontal: 14.w),
              decoration: BoxDecoration(
                color: AppColors.WHITE2,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10.r),
                  bottomRight: Radius.circular(10.r),
                  topLeft:
                      isHeader ? Radius.circular(0) : Radius.circular(10.r),
                  topRight:
                      isHeader ? Radius.circular(0) : Radius.circular(10.r),
                ),
              ),
              child: Column(
                children: [
                  SizedBox(height: 20.h),
                  if (desc1 != null) ...[
                    MyText(
                      title: desc1,
                      textAlign: textAlignDisk1,
                      fontSize: 14,
                      color: desc1Color,
                    ),
                    SizedBox(height: 20.h),
                  ],
                  if (desc2 != null) ...[
                    MyText(
                      title: desc2,
                      fontSize: 14,
                    ),
                    SizedBox(height: 20.h),
                  ],
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MyElevatedButton(
                        title: AppLocalizations.of(context)!.cancel,
                        width: 85,
                        fontSize: 14,
                        height: 35,
                        onPressed: onPressedBack,
                        background: AppColors.NAVY_BLUE,
                      ),
                      SizedBox(width: 20.w),
                      MyElevatedButton(
                        title: titleBace ?? AppLocalizations.of(context)!.yes,
                        width: 85,
                        height: 35,
                        fontSize: 14,
                        onPressed: onPressedDelete,
                        background: baceColor,
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                ],
              ),
            )
          ],
        ),
      ),
    );

    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  static updateApplication(
    BuildContext context, {
    required Function()? onTap,
  }) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          title:
              MyText(title: AppLocalizations.of(context)!.updateTheApplication),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              MyText(
                title: AppLocalizations.of(context)!.descUpdateApp,
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: onTap,
                child: MyText(
                  title: AppLocalizations.of(context)!.updateTheApplication,
                  fontSize: 20,
                  color: AppColors.BASE_COLOR,
                ),
              )
            ],
          ),
        );
      },
    );
  }

  static showBlockFromAdminDialog(BuildContext context,
      {required Function()? onPressedOk}) {
    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(11.r)),
      backgroundColor: AppColors.WHITE,
      contentPadding: EdgeInsets.zero,
      titlePadding: EdgeInsets.zero,
      buttonPadding: EdgeInsets.zero,
      iconPadding: EdgeInsets.zero,
      insetPadding: EdgeInsets.zero,
      actionsPadding: EdgeInsets.zero,
      content: SizedBox(
        width: MediaQuery.of(context).size.width - 40.w,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Lottie.asset(
                'assets/images/ic_json/faild.json',
                width: 110.r,
                height: 110.r,
              ),
              MyText(
                title: AppLocalizations.of(context)!.descBlockAccount,
                fontSize: 13,
                textAlign: TextAlign.center,
                color: AppColors.GRAY3,
              ),
              SelectableAutoLinkText(
                'easyplus.sa@gmail.com',
                linkStyle: TextStyle(
                    color: Colors.blueAccent,
                    fontSize: 18.sp,
                    fontFamily: 'Montserrat'),
                highlightedLinkStyle: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 18.sp,
                  color: Colors.blueAccent,
                  backgroundColor: Colors.blueAccent.withAlpha(0x33),
                ),
              ),
              SizedBox(height: 50.h),
              MyElevatedButton(
                borderRaduis: 30,
                title: AppLocalizations.of(context)!.ok,
                onPressed: onPressedOk,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              )
            ],
          ),
        ),
      ),
    );

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
