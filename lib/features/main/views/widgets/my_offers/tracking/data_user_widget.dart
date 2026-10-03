import 'package:dotted_dashed_line/dotted_dashed_line.dart';
import 'package:easy_plus_service_provider/core/utils/app_colors.dart';
import 'package:easy_plus_service_provider/core/widgets/my_text.dart';
import 'package:easy_plus_service_provider/features/main/views/manager/tracking_cubit/tracking_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../../core/widgets/my_contianer_shape.dart';

class DataUserWidget extends StatelessWidget {
  const DataUserWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PositionedDirectional(
      bottom: 0,
      start: 0,
      end: 0,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 20.h,
        ),
        decoration: BoxDecoration(
          color: AppColors.WHITE,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(34.r),
            topRight: Radius.circular(34.r),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  'assets/images/ic_user4.png',
                  width: 54.r,
                  height: 54.r,
                  fit: BoxFit.cover,
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 3.h),
                      Row(
                        children: [
                          MyText(
                            title: 'عبدالله ابو القمبز',
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                          MyText(
                            title: '5.4',
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                          SizedBox(width: 2.w),
                          const Icon(
                            Icons.star,
                            color: AppColors.ORANGE,
                          ),
                          const Spacer(),
                          MyText(
                            title: AppLocalizations.of(context)!.estimatedTime,
                          )
                        ],
                      ),
                      SizedBox(height: 10.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          MyText(
                            title: '9710565625872+',
                            fontSize: 12,
                            color: AppColors.GRAY3,
                            fontWeight: FontWeight.w400,
                          ),
                          MyText(
                            title: '10دقائق',
                            fontSize: 12,
                            color: AppColors.GRAY3,
                            fontWeight: FontWeight.w400,
                          ),
                        ],
                      ),
                      SizedBox(height: 10.h),
                    ],
                  ),
                ),
              ],
            ),
            BlocBuilder<TrackingCubit, TrackingState>(
              builder: (context, state) {
                int indexSelected =
                    TrackingCubit.get(context).indexSelectedTrip;

                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      BlocBuilder<TrackingCubit, TrackingState>(
                        builder: (context, state) {
                          return GestureDetector(
                            onTap: () {
                              TrackingCubit.get(context).changeSelectedTrip(1);
                            },
                            child: MyContainerShape(
                              width: 45.r,
                              height: 45.r,
                              enableRadius: true,
                              enableShadow: false,
                              enableBorder: true,
                              colorBorder: indexSelected == 1
                                  ? AppColors.BASE_COLOR
                                  : AppColors.GRAY3,
                              borderRadius: 50,
                              widthBorder: 2,
                              bgContainer: AppColors.WHITE4,
                              child: SvgPicture.asset(
                                'assets/images/ic_location.svg',
                                width: 16.r,
                                colorFilter: ColorFilter.mode(
                                    indexSelected == 1
                                        ? AppColors.BASE_COLOR
                                        : AppColors.GRAY3,
                                    BlendMode.srcIn),
                              ),
                            ),
                          );
                        },
                      ),
                      Expanded(
                        child: DottedDashedLine(
                          height: 1.h,
                          width: 10.w,
                          axis: Axis.horizontal,
                          dashColor: AppColors.BASE_COLOR,
                        ),
                      ),
                      BlocBuilder<TrackingCubit, TrackingState>(
                        builder: (context, state) {
                          return GestureDetector(
                            onTap: () {
                              TrackingCubit.get(context).changeSelectedTrip(0);
                            },
                            child: MyContainerShape(
                              width: 45.r,
                              height: 45.r,
                              enableRadius: true,
                              enableShadow: false,
                              enableBorder: true,
                              widthBorder: 2,
                              colorBorder: indexSelected == 0
                                  ? AppColors.BASE_COLOR
                                  : AppColors.GRAY3,
                              borderRadius: 50,
                              bgContainer: AppColors.WHITE4,
                              child: SvgPicture.asset(
                                'assets/images/ic_bottom_nav/ic_profile.svg',
                                width: 16.r,
                                colorFilter: ColorFilter.mode(
                                  indexSelected == 0
                                      ? AppColors.BASE_COLOR
                                      : AppColors.GRAY3,
                                  BlendMode.srcIn,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
            SizedBox(height: 8.h),
            BlocBuilder<TrackingCubit, TrackingState>(
              builder: (context, state) {
                int indexSelected =
                    TrackingCubit.get(context).indexSelectedTrip;
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        TrackingCubit.get(context).changeSelectedTrip(1);
                      },
                      child: MyContainerShape(
                        borderRadius: 30,
                        paddingHorizontal: 16,
                        paddingVertical: 4,
                        enableShadow: false,
                        enableBorder: true,
                        bgContainer: indexSelected == 1
                            ? AppColors.BASE_COLOR
                            : AppColors.TRANSPARENT,
                        colorBorder: indexSelected == 1
                            ? AppColors.BASE_COLOR
                            : AppColors.GRAY3,
                        child: MyText(
                          title: AppLocalizations.of(context)!.endTheTrip,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        TrackingCubit.get(context).changeSelectedTrip(0);
                      },
                      child: MyContainerShape(
                        borderRadius: 30,
                        paddingHorizontal: 16,
                        paddingVertical: 4,
                        enableShadow: false,
                        enableBorder: true,
                        bgContainer: indexSelected == 0
                            ? AppColors.BASE_COLOR
                            : AppColors.TRANSPARENT,
                        colorBorder: indexSelected == 0
                            ? AppColors.BASE_COLOR
                            : AppColors.GRAY3,
                        child: MyText(
                          title: AppLocalizations.of(context)!.startTheTrip,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }
}
