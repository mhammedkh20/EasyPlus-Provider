import 'package:easy_plus_service_provider/core/utils/app_colors.dart';
import 'package:easy_plus_service_provider/core/utils/app_helpers.dart';
import 'package:easy_plus_service_provider/core/widgets/loading_widget.dart';
import 'package:easy_plus_service_provider/core/widgets/my_contianer_shape.dart';
import 'package:easy_plus_service_provider/core/widgets/my_elevated_button.dart';
import 'package:easy_plus_service_provider/core/widgets/my_text.dart';
import 'package:easy_plus_service_provider/features/auth/views/manager/auth_cubit/auth_cubit.dart';
import 'package:easy_plus_service_provider/features/auth/views/pages/reset_password_screen.dart';
import 'package:easy_plus_service_provider/features/auth/views/widgets/my_pin_put.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

import '../../../../core/widgets/my_app_bar.dart';

class VerifyScreen extends StatefulWidget {
  final String emailOrPhone;

  const VerifyScreen({
    super.key,
    required this.emailOrPhone,
  });

  @override
  State<VerifyScreen> createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  late final StopWatchTimer _stopWatchTimer;
  var _keyForm = GlobalKey<FormState>();
  final TextEditingController _codeController = TextEditingController();

  @override
  void initState() {
    _stopWatchTimer = StopWatchTimer(mode: StopWatchMode.countDown);
    _stopWatchTimer.setPresetMinuteTime(1);
    _stopWatchTimer.setPresetSecondTime(12);

    _stopWatchTimer.onStartTimer();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 28.w),
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
                colorFilter: const ColorFilter.mode(
                    AppColors.BASE_COLOR, BlendMode.srcIn),
                height: 64.r,
              ),
            ),
            SizedBox(height: 32.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40.w),
              child: MyText(
                title:
                    '${AppLocalizations.of(context)!.a4digitCodeHasBeenSentTo} ${widget.emailOrPhone}',
                textAlign: TextAlign.center,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: 43.h),
            Form(
              key: _keyForm,
              child: MyPinput(textEditingController: _codeController),
            ),
            SizedBox(height: 43.h),
            BlocConsumer<AuthCubit, AuthState>(
              listener: (context, state) {
                if (state is VerifyPasswordSuccess) {
                  AppHelpers.showSnackBar(context, message: state.message);

                  AppHelpers.navigationToPage(
                      context,
                      ResetPasswordScreen(
                        phoneOrEmail: widget.emailOrPhone,
                      ));
                }

                if (state is VerifyPasswordFailed) {
                  AppHelpers.showSnackBar(
                    context,
                    message: state.message,
                    error: true,
                  );
                }
              },
              builder: (context, state) {
                if (state is VerifyPasswordLoading) {
                  return const LoadingWidget();
                }
                return MyElevatedButton(
                  title: AppLocalizations.of(context)!.codeConfirmation,
                  onPressed: () async {
                    if (_keyForm.currentState!.validate()) {
                      await AuthCubit.get(context).verify(
                        context,
                        code: AppHelpers.getNumberEnglish(_codeController.text),
                        other: AppHelpers.getNumberEnglish(widget.emailOrPhone),
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
                      title: AppLocalizations.of(context)!.theCodeExpiresWithin,
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MyText(
                  title: AppLocalizations.of(context)!
                      .ididNotReceiveTheCodeToThePhoneNumber,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: AppColors.TEXT_LIGHT,
                ),
                GestureDetector(
                  onTap: () {
                    _stopWatchTimer.onResetTimer();
                    _stopWatchTimer.onStartTimer();
                  },
                  child: MyText(
                    title: AppLocalizations.of(context)!.resend,
                    color: AppColors.GRAY2,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
