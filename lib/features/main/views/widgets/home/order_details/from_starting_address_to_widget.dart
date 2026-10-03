import 'package:dotted_dashed_line/dotted_dashed_line.dart';
import 'package:easy_plus_service_provider/core/utils/app_colors.dart';
import 'package:easy_plus_service_provider/core/widgets/my_contianer_shape.dart';
import 'package:easy_plus_service_provider/core/widgets/my_text.dart';
import 'package:easy_plus_service_provider/features/main/model/order_response.dart';
import 'package:easy_plus_service_provider/features/main/views/manager/my_request_cubit/my_request_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';

class FromStartingAddressTo extends StatelessWidget {
  const FromStartingAddressTo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    OrderResponse data = MyRequestCubit.get(context).dataOrderDetails!;
    if (data.data!.user != null) {
      return MyContainerShape(
        paddingHorizontal: 12,
        paddingVertical: 12,
        width: double.infinity,
        borderRadius: 11,
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                data.data!.user!.image != null
                    ? Image.network(
                        data.data!.user!.image!,
                        width: 40.r,
                        height: 40.r,
                        fit: BoxFit.cover,
                      )
                    : Image.asset(
                        'assets/images/ic_user4.png',
                        width: 40.r,
                        height: 40.r,
                        fit: BoxFit.cover,
                      ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 3.h),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: MyText(
                              title: data.data!.user!.name ?? "",
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          MyText(
                            title: data.data!.createdAt ?? "",
                            fontSize: 12,
                            color: AppColors.GRAY3,
                          )
                        ],
                      ),
                      MyText(
                        title: data.data!.user!.gender ?? '',
                        fontSize: 12,
                        color: AppColors.GRAY3,
                        fontWeight: FontWeight.w400,
                      ),
                    ],
                  ),
                )
              ],
            ),
            Divider(thickness: 1),
            Row(
              children: [
                Column(
                  children: [
                    SvgPicture.asset(
                      'assets/images/ic_gps.svg',
                      color: AppColors.GRAY3,
                      width: 16.r,
                      height: 16.r,
                    ),
                    const SizedBox(height: 3),
                    DottedDashedLine(
                      height: 35.h,
                      width: 0,
                      axis: Axis.vertical,
                    ),
                    const SizedBox(height: 3),
                    SvgPicture.asset(
                      'assets/images/ic_location.svg',
                      color: AppColors.GRAY3,
                      width: 16.r,
                      height: 16.r,
                    ),
                  ],
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      MyText(
                        title: AppLocalizations.of(context)!.startingAddress,
                        color: AppColors.GRAY3,
                      ),
                      SizedBox(height: 4.h),
                      data.data!.startAddress != null
                          ? MyText(
                              title: data.data!.startAddress ?? "",
                              color: AppColors.BLACK,
                              fontSize: 14,
                            )
                          : SizedBox(),
                      SizedBox(height: 20.h),
                      MyText(
                        title: AppLocalizations.of(context)!.destinationAddress,
                        color: AppColors.GRAY3,
                      ),
                      SizedBox(height: 4.h),
                      data.data!.endAddress != null
                          ? MyText(
                              title: data.data!.endAddress ?? "",
                              color: AppColors.BLACK,
                              fontSize: 14,
                            )
                          : const SizedBox(),
                    ],
                  ),
                )
              ],
            ),
            if (data.data!.endAddress != null) ...[
              SizedBox(height: 20.h),
              Row(
                children: [
                  MyText(
                    title: AppLocalizations.of(context)!.expectedDistance,
                    fontSize: 14,
                    color: AppColors.BLACK.withOpacity(.6),
                  ),
                  SizedBox(width: 20.w),
                  MyText(
                    title: '${getDistanceInMeters(context).toString()} KM',
                    fontSize: 14,
                  ),
                ],
              ),
            ],
          ],
        ),
      );
    } else {
      return SizedBox();
    }
  }

  int getDistanceInMeters(BuildContext context) {
    OrderResponse data = MyRequestCubit.get(context).dataOrderDetails!;

    return Geolocator.distanceBetween(
          double.parse(data.data!.startLat!),
          double.parse(data.data!.startLng!),
          double.parse(data.data!.endLat!),
          double.parse(data.data!.endLng!),
        ) ~/
        1000;
  }
}
