import 'package:easy_plus_service_provider/core/utils/app_helpers.dart';
import 'package:easy_plus_service_provider/core/widgets/loading_widget.dart';
import 'package:easy_plus_service_provider/features/main/views/manager/settings_cubit/settings_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/widgets/my_app_bar.dart';
import '../../../../../../core/widgets/my_contianer_shape.dart';
import '../../../../../../core/widgets/my_elevated_button.dart';
import '../../../../../../core/widgets/my_text.dart';
import '../../../../../../core/widgets/my_text_field.dart';

class ContactUsScreen extends StatelessWidget {
  ContactUsScreen({super.key});

  final _keyForm = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.BG_SCAFOLLD,
      appBar: MyAppBar(
        backgroundColor: AppColors.BG_SCAFOLLD,
        title: AppLocalizations.of(context)!.connectUs,
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          children: [
            SizedBox(height: 16.h),
            MyContainerShape(
              paddingHorizontal: 12,
              paddingVertical: 12,
              borderRadius: 11,
              child: MyText(
                title: AppLocalizations.of(context)!.descContactUs,
                fontSize: 16,
                color: AppColors.GRAY3,
              ),
            ),
            SizedBox(height: 16.h),
            MyContainerShape(
              paddingHorizontal: 12,
              paddingVertical: 12,
              borderRadius: 11,
              child: Form(
                key: _keyForm,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyText(
                      title: AppLocalizations.of(context)!.contactNumber,
                      fontSize: 12,
                      color: AppColors.BLACK,
                      fontWeight: FontWeight.bold,
                    ),
                    SizedBox(height: 12.h),
                    MyTextField(
                      controller: _usernameController,
                      textHint: AppLocalizations.of(context)!.contactNumber,
                      filledColor: true,
                      keyboardType: TextInputType.number,
                      isBorder: true,
                      colorBorder: AppColors.WHITE2,
                      validator: (String? s) {
                        if (s == null || s.isEmpty) {
                          return AppLocalizations.of(context)!
                              .pleaseEnterYourUsername;
                        }

                        return null;
                      },
                    ),
                    SizedBox(height: 12.h),
                    MyText(
                      title: AppLocalizations.of(context)!.message,
                      fontSize: 12,
                      color: AppColors.BLACK,
                      fontWeight: FontWeight.bold,
                    ),
                    SizedBox(height: 12.h),
                    MyTextField(
                      controller: _messageController,
                      textHint: AppLocalizations.of(context)!.message,
                      filledColor: true,
                      isBorder: true,
                      colorBorder: AppColors.WHITE2,
                      maxLines: 12,
                      paddingHorizontal: 12,
                      paddingVertical: 12,
                      validator: (String? s) {
                        if (s == null || s.isEmpty) {
                          return AppLocalizations.of(context)!
                              .pleaseAddTheContentOfTheMessage;
                        }

                        return null;
                      },
                    ),
                    SizedBox(height: 12.h),
                  ],
                ),
              ),
            ),
            SizedBox(height: 32.h),
          ],
        ),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          BlocConsumer<SettingsCubit, SettingsState>(
            listener: (context, state) {
              if (state is ContactUsSuccess) {
                AppHelpers.showSnackBar(context, message: state.message);
                _messageController.clear();
                _usernameController.clear();
                Navigator.pop(context);
              }
              if (state is ContactUsFailed) {
                AppHelpers.showSnackBar(
                  context,
                  message: state.message,
                  error: true,
                );
              }
            },
            builder: (context, state) {
              if (state is ContactUsLoading) {
                return const LoadingWidget();
              }
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: MyElevatedButton(
                  title: AppLocalizations.of(context)!.send,
                  titleColor: AppColors.BLACK,
                  onPressed: () async {
                    if (_keyForm.currentState!.validate()) {
                      await SettingsCubit.get(context).sendContactUs(
                        context,
                        title: AppHelpers.getNumberEnglish(
                            _usernameController.text.trim()),
                        message: _messageController.text.trim(),
                      );
                    }
                  },
                ),
              );
            },
          ),
          SizedBox(height: MediaQuery.of(context).padding.bottom),
        ],
      ),
    );
  }
}
