import 'dart:developer';
import 'package:easy_plus_service_provider/core/storage/pref/shared_pref_controller.dart';
import 'package:easy_plus_service_provider/core/utils/app_colors.dart';
import 'package:easy_plus_service_provider/core/utils/app_dialogs.dart';
import 'package:easy_plus_service_provider/core/utils/app_helpers.dart';
import 'package:easy_plus_service_provider/core/widgets/my_app_bar.dart';
import 'package:easy_plus_service_provider/core/widgets/my_contianer_shape.dart';
import 'package:easy_plus_service_provider/core/widgets/my_text.dart';
import 'package:easy_plus_service_provider/features/auth/views/manager/auth_cubit/auth_cubit.dart';
import 'package:easy_plus_service_provider/features/auth/views/pages/login_screen.dart';
import 'package:easy_plus_service_provider/features/main/model/item_settings_model.dart';
import 'package:easy_plus_service_provider/features/main/views/manager/settings_cubit/settings_cubit.dart';
import 'package:easy_plus_service_provider/features/main/views/pages/bottom_nav/settings/common_questions_screen.dart';
import 'package:easy_plus_service_provider/features/main/views/pages/bottom_nav/settings/complaint_request/complaint_requests_screen.dart';
import 'package:easy_plus_service_provider/features/main/views/pages/bottom_nav/settings/contact_us_screen.dart';
import 'package:easy_plus_service_provider/features/main/views/pages/bottom_nav/settings/my_services_screen.dart';
import 'package:easy_plus_service_provider/features/main/views/pages/bottom_nav/settings/privacy_policy_screen.dart';
import 'package:easy_plus_service_provider/features/main/views/pages/bottom_nav/settings/settings_screens/settings_screen.dart';
import 'package:easy_plus_service_provider/features/main/views/pages/bottom_nav/settings/terms_and_conditions.dart';
import 'package:easy_plus_service_provider/features/main/views/pages/bottom_nav/settings/wallet_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MyAppBar(
          backgroundColor: AppColors.BG_SCAFOLLD,
          title: AppLocalizations.of(context)!.settings,
        ),
        Expanded(
          child: GridView.builder(
            itemCount: SettingsCubit.get(context).itemSettings(context).length,
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 170 / 112,
              mainAxisSpacing: 12.h,
              crossAxisSpacing: 12.w,
            ),
            itemBuilder: (context, index) {
              ItemSettingsModel model =
                  SettingsCubit.get(context).itemSettings(context)[index];
              return BlocConsumer<AuthCubit, AuthState>(
                listener: (context, state) async {
                  if (state is LogoutSuccess) {
                    log('logout success');
                    await logout(context);
                  }
                  if (state is LogoutFailed) {
                    log('logout Failed');

                    await logout(context);
                  }
                },
                builder: (context, state) {
                  if (state is LogoutLoading) {
                    if (index == 9 || index == 8) {
                      return const Center(
                          child: CircularProgressIndicator.adaptive());
                    }
                  }
                  return MyContainerShape(
                    borderRadius: 11,
                    child: Material(
                      color: AppColors.WHITE,
                      child: InkWell(
                        onTap: () async {
                          switch (index) {
                            case 0:
                              AppHelpers.navigationToPage(
                                  context, const WalletScreen());
                              break;
                            case 1:
                              AppHelpers.navigationToPage(
                                  context, const ComplaintRequestsScreen());
                              break;
                            case 2:
                              AppHelpers.navigationToPage(
                                  context, ContactUsScreen());
                              break;
                            case 3:
                              AppHelpers.navigationToPage(
                                  context, const CommonQuestionsScreen());
                              break;

                            case 4:
                              AppHelpers.navigationToPage(
                                  context, const PrivacyPolicyScreen());
                              break;
                            case 5:
                              AppHelpers.navigationToPage(
                                  context, const TermsAndConditionsScreen());
                              break;

                            case 6:
                              AppHelpers.navigationToPage(
                                  context, const SettingsScreen());
                              break;
                            case 7:
                              AppHelpers.navigationToPage(
                                  context, MyServiceScreen());
                              break;
                            case 8:
                              AppDialogs.customDialog(
                                context,
                                onPressedBack: () {
                                  Navigator.of(context).pop();
                                },
                                onPressedDelete: () {
                                  AuthCubit.get(context).logout(context);
                                  Navigator.of(context).pop();
                                },
                                titleHeader: null,
                                iconHeader: 'assets/images/danger.png',
                                desc1: AppLocalizations.of(context)!
                                    .areYouSureYouWantToLogOut,
                                desc1Color: AppColors.BLACK,
                                png: true,
                                sizeHeader: 50,
                              );
                              break;
                            case 9:
                              AppDialogs.customDialog(
                                context,
                                onPressedBack: () {
                                  Navigator.of(context).pop();
                                },
                                onPressedDelete: () {
                                  AuthCubit.get(context).logout(context);
                                  Navigator.of(context).pop();
                                },
                                titleHeader:
                                    AppLocalizations.of(context)!.deleteAccount,
                                iconColor: null,
                                iconHeader: 'assets/images/ic_emoji.png',
                                desc1: AppLocalizations.of(context)!
                                    .areYouSureToDeleteYourAccount,
                                desc1Color: AppColors.BLACK,
                                sizeHeader: 100,
                                png: true,
                                iconSize: 36,
                              );

                              break;
                          }
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (index == 9 || 8 == index) ...[
                              SvgPicture.asset(
                                model.icPath,
                                color: AppColors.BASE_COLOR,
                                width: 30.r,
                                height: 30.r,
                              ),
                            ] else ...[
                              SvgPicture.asset(
                                model.icPath,
                                width: 30.r,
                                height: 30.r,
                              ),
                            ],
                            SizedBox(height: 12.h),
                            MyText(
                              title: model.title,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        )
      ],
    );
  }

  Future logout(BuildContext context) async {
    await SharedPrefController().clearAllData();
    AppHelpers.navigationToPageAndExitAll(context, LoginScreen());
  }
}
