// ignore_for_file: use_build_context_synchronously

import 'package:easy_plus_service_provider/core/storage/pref/shared_pref_controller.dart';
import 'package:easy_plus_service_provider/core/utils/app_colors.dart';
import 'package:easy_plus_service_provider/core/utils/app_helpers.dart';
import 'package:easy_plus_service_provider/core/widgets/loading_widget.dart';
import 'package:easy_plus_service_provider/core/widgets/my_app_bar.dart';
import 'package:easy_plus_service_provider/core/widgets/my_contianer_shape.dart';
import 'package:easy_plus_service_provider/core/widgets/my_elevated_button.dart';
import 'package:easy_plus_service_provider/core/widgets/my_text.dart';
import 'package:easy_plus_service_provider/features/auth/views/manager/auth_cubit/auth_cubit.dart';
import 'package:easy_plus_service_provider/features/auth/views/widgets/my_pin_put.dart';
import 'package:easy_plus_service_provider/features/main/views/pages/bottom_nav/settings/my_services_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class AccountConfirmationScreen extends StatefulWidget {
  final String phone;

  const AccountConfirmationScreen({
    super.key,
    required this.phone,
  });

  @override
  State<AccountConfirmationScreen> createState() =>
      _AccountConfirmationScreenState();
}

class _AccountConfirmationScreenState extends State<AccountConfirmationScreen> {
  late final TextEditingController _codeController;

  late final StopWatchTimer _stopWatchTimer;

  var _keyForm = GlobalKey<FormState>();

  @override
  void initState() {
    _codeController = TextEditingController();
    _stopWatchTimer = StopWatchTimer(mode: StopWatchMode.countDown);
    _stopWatchTimer.setPresetMinuteTime(1);
    _stopWatchTimer.setPresetSecondTime(12);

    _stopWatchTimer.onStartTimer();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: AppLocalizations.of(context)!.accountConfirmation,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 28.w),
        child: Form(
          key: _keyForm,
          child: Column(
            children: [
              SizedBox(height: 34.h),
              MyContainerShape(
                height: 128.r,
                width: 128.r,
                borderRadius: 100,
                enableShadow: false,
                bgContainer: AppColors.WHITE2,
                child: SvgPicture.asset(
                  'assets/images/ic_settings_app.svg',
                  width: 64.r,
                  height: 64.r,
                  colorFilter: const ColorFilter.mode(
                      AppColors.BASE_COLOR, BlendMode.srcIn),
                ),
              ),
              SizedBox(height: 32.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40.w),
                child: MyText(
                  title:
                      '${AppLocalizations.of(context)!.a4digitCodeHasBeenSentTo}\n${widget.phone}',
                  textAlign: TextAlign.center,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 43.h),
              MyPinput(textEditingController: _codeController),
              SizedBox(height: 43.h),
              BlocConsumer<AuthCubit, AuthState>(
                listener: (context, state) async {
                  if (state is VerifyCodeSuccess) {
                    AppHelpers.showSnackBar(context, message: state.message);
                    await SharedPrefController()
                        .setNavigationFromService(false);
                    AppHelpers.navigationToPageAndExitAll(
                        context, MyServiceScreen());
                  }
                  if (state is VerifyCodeFailed) {
                    AppHelpers.showSnackBar(
                      context,
                      message: state.message,
                      error: true,
                    );
                  }
                },
                builder: (context, state) {
                  if (state is VerifyCodeLoading) {
                    return const LoadingWidget();
                  }
                  return MyElevatedButton(
                    title: AppLocalizations.of(context)!.codeConfirmation,
                    onPressed: () async {
                      if (_keyForm.currentState!.validate()) {
                        await AuthCubit.get(context).userVerifyCode(
                          context,
                          other: AppHelpers.getNumberEnglish(widget.phone),
                          code: AppHelpers.getNumberEnglish(
                              _codeController.text.trim()),
                        );
                      }
                    },
                  );
                },
              ),
              SizedBox(height: 16.h),
              StreamBuilder<int>(
                stream: _stopWatchTimer.rawTime,
                initialData: 0,
                builder: (context, snap) {
                  final value = snap.data;
                  final displayTime = value == null
                      ? ''
                      : StopWatchTimer.getDisplayTime(
                          value,
                          milliSecond: false,
                          hours: false,
                        );
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MyText(
                        title:
                            AppLocalizations.of(context)!.theCodeExpiresWithin,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColors.TEXT_LIGHT,
                      ),
                      MyText(
                        title: displayTime,
                        color: AppColors.RED,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      )
                    ],
                  );
                },
              ),
              SizedBox(height: 15.h),
              RichText(
                text: TextSpan(
                  text: AppLocalizations.of(context)!
                      .ididNotReceiveTheCodeToThePhoneNumber,
                  style: TextStyle(
                    color: AppColors.TEXT_LIGHT,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'ubuntu',
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: AppLocalizations.of(context)!.resend,
                      style: TextStyle(
                        fontSize: 14.sp,
                        height: 1.4,
                        fontFamily: 'ubuntu',
                        color: AppColors.GRAY2,
                        fontWeight: FontWeight.w700,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          _stopWatchTimer.onResetTimer();
                          _stopWatchTimer.onStartTimer();
                        },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
