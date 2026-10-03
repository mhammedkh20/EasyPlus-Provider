import 'package:easy_plus_service_provider/core/utils/app_helpers.dart';
import 'package:easy_plus_service_provider/core/widgets/loading_widget.dart';
import 'package:easy_plus_service_provider/features/main/views/manager/settings_cubit/settings_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../../../core/utils/app_colors.dart';
import '../../../../../../../core/widgets/my_app_bar.dart';
import '../../../../../../../core/widgets/my_elevated_button.dart';
import '../../../../../../../core/widgets/my_text.dart';
import '../../../../../../../core/widgets/my_text_field.dart';

class ChangePasswordScreen extends StatelessWidget {
  final _keyForm = GlobalKey<FormState>();
  final TextEditingController _currentPasswordController =
      TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: AppLocalizations.of(context)!.changePassword,
      ),
      body: Padding(
        padding: EdgeInsetsDirectional.symmetric(horizontal: 16.w),
        child: Form(
          key: _keyForm,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 32.h),
                Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: MyText(
                    title: AppLocalizations.of(context)!.changePassword,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    height: 0,
                  ),
                ),
                SizedBox(height: 16.h),
                Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: MyText(
                    title: AppLocalizations.of(context)!.descChangePass,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: AppColors.GRAY2,
                    height: 1.4,
                  ),
                ),
                SizedBox(height: 30.h),
                MyTextField(
                  controller: _currentPasswordController,
                  textHint: AppLocalizations.of(context)!.currentPassword,
                  filledColor: true,
                  obscureText: true,
                  maxLines: 1,
                  isBorder: true,
                  colorBorder: AppColors.WHITE2,
                  prefixIcon: Padding(
                    padding: EdgeInsetsDirectional.only(start: 9.w, end: 5.w),
                    child: SvgPicture.asset(
                      'assets/images/ic_key.svg',
                      width: 19.w,
                      height: 19.h,
                    ),
                  ),
                  validator: (String? s) {
                    if (s == null || s.trim().isEmpty) {
                      return AppLocalizations.of(context)!
                          .pleaseEnterYourCurrentPassword;
                    }

                    return null;
                  },
                ),
                SizedBox(height: 16.h),
                MyTextField(
                  controller: _passwordController,
                  textHint: AppLocalizations.of(context)!.newPassword,
                  filledColor: true,
                  obscureText: true,
                  maxLines: 1,
                  isBorder: true,
                  colorBorder: AppColors.WHITE2,
                  prefixIcon: Padding(
                    padding: EdgeInsetsDirectional.only(start: 9.w, end: 5.w),
                    child: SvgPicture.asset(
                      'assets/images/ic_lock.svg',
                      width: 19.w,
                      height: 19.h,
                    ),
                  ),
                  validator: (String? s) {
                    if (s == null || s.trim().isEmpty) {
                      return AppLocalizations.of(context)!
                          .pleaseEnterYourNewPassword;
                    }

                    return null;
                  },
                ),
                SizedBox(height: 16.h),
                MyTextField(
                  controller: _confirmPasswordController,
                  textHint: AppLocalizations.of(context)!.confirmPassword,
                  maxLines: 1,
                  filledColor: true,
                  isBorder: true,
                  obscureText: true,
                  colorBorder: AppColors.WHITE2,
                  prefixIcon: Padding(
                    padding: EdgeInsetsDirectional.only(start: 9.w, end: 5.w),
                    child: SvgPicture.asset(
                      'assets/images/ic_lock.svg',
                      width: 19.w,
                      height: 19.h,
                    ),
                  ),
                  validator: (String? s) {
                    if (s == null || s.isEmpty) {
                      return AppLocalizations.of(context)!
                          .pleaseEnterYourConfirmPassword;
                    }

                    if (s != _passwordController.text.trim()) {
                      return 'الرجاء من تشابه كلمتا السر';
                    }

                    return null;
                  },
                ),
                SizedBox(height: 43.h),
                BlocConsumer<SettingsCubit, SettingsState>(
                  listener: (context, state) {
                    if (state is ChangePasswordSuccess) {
                      Navigator.pop(context);
                      AppHelpers.showSnackBar(context, message: state.message);
                    }
                    if (state is ChangePasswordFailed) {
                      AppHelpers.showSnackBar(context,
                          message: state.message, error: true);
                    }
                  },
                  builder: (context, state) {
                    if (state is ChangePasswordLoading) {
                      return LoadingWidget();
                    }
                    return MyElevatedButton(
                      title: AppLocalizations.of(context)!.confirm,
                      onPressed: () {
                        if (_keyForm.currentState!.validate()) {
                          SettingsCubit.get(context).changePassword(
                            context,
                            currentPass: _currentPasswordController.text,
                            newPass: _passwordController.text,
                            confirmPass: _confirmPasswordController.text,
                          );
                        }
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
