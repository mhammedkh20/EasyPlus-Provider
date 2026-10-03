import 'package:easy_plus_service_provider/core/utils/app_bottom_sheet.dart';
import 'package:easy_plus_service_provider/core/utils/app_colors.dart';
import 'package:easy_plus_service_provider/core/utils/app_helpers.dart';
import 'package:easy_plus_service_provider/core/widgets/my_contianer_shape.dart';
import 'package:easy_plus_service_provider/core/widgets/my_text.dart';
import 'package:easy_plus_service_provider/features/main/views/manager/my_account_cubit/my_account_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../pages/bottom_nav/home/notification/notification_screen.dart';

class MainHeaderWidget extends StatelessWidget {
  const MainHeaderWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 16.w,
      ),
      width: double.infinity,
      color: AppColors.BASE_COLOR,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: MediaQuery.of(context).viewPadding.top + 10.h),
          Row(
            children: [
              BlocBuilder<MyAccountCubit, MyAccountState>(
                builder: (context, state) {
                  if (MyAccountCubit.get(context).userData!.image != null) {
                    return MyContainerShape(
                      height: 60.r,
                      width: 60.r,
                      borderRadius: 100,
                      bgContainer: AppColors.TRANSPARENT,
                      child: Image.network(
                        MyAccountCubit.get(context).userData!.image!,
                        width: 60.r,
                        height: 60.r,
                        fit: BoxFit.cover,
                      ),
                    );
                  }
                  return Image.asset('assets/images/ic_user2.png');
                },
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyText(
                      title: AppLocalizations.of(context)!.welcome,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    SizedBox(height: 4.h),
                    BlocBuilder<MyAccountCubit, MyAccountState>(
                      builder: (context, state) {
                        return MyText(
                          title:
                              MyAccountCubit.get(context).userData!.name ?? "",
                        );
                      },
                    ),
                  ],
                ),
              ),
              IconButton(
                constraints: const BoxConstraints(),
                padding: EdgeInsets.symmetric(
                  horizontal: 6.r,
                  vertical: 6.r,
                ),
                onPressed: () {
                  AppBottomSheet.showFillter(context);
                },
                icon: Icon(
                  Icons.tune,
                  size: 24.r,
                ),
              ),
              IconButton(
                constraints: const BoxConstraints(),
                padding: EdgeInsets.symmetric(
                  horizontal: 6.r,
                  vertical: 6.r,
                ),
                onPressed: () {
                  AppHelpers.navigationToPage(context, NotificationScreen());
                },
                icon: Icon(
                  Icons.notifications_none_outlined,
                  size: 24.r,
                ),
              ),
            ],
          ),
          SizedBox(height: 17.h),
        ],
      ),
    );
  }
}
