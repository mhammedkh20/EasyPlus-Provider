import 'dart:async';

import 'package:easy_plus_service_provider/features/main/model/offer2.dart';
import 'package:easy_plus_service_provider/features/main/views/widgets/my_offers/progress.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_plus_service_provider/core/utils/app_colors.dart';
import 'package:easy_plus_service_provider/core/widgets/my_contianer_shape.dart';
import 'package:easy_plus_service_provider/core/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class ItemOrder extends StatefulWidget {
  final Function()? onTap;
  final int status;
  final Offer offer;

  const ItemOrder({
    super.key,
    required this.onTap,
    required this.status,
    required this.offer,
  });

  @override
  State<ItemOrder> createState() => _ItemOrderState();
}

class _ItemOrderState extends State<ItemOrder> {
  double? proggress;
  DateTime? endDate;
  int? secondsDifference;
  @override
  void initState() {
    if (widget.status == 0) {
      int totalSecound = int.parse(widget.offer.showTime!) * 60;

      DateTime startDate =
          DateFormat('yyyy-MM-dd HH:mm:ss').parse(widget.offer.createdAt!);

      endDate = startDate.add(Duration(seconds: totalSecound));

      proggress = 100;

      Timer.periodic(const Duration(seconds: 1), (timer) {
        Duration elapsedTime = DateTime.now().difference(startDate);

        if (endDate!.isAfter(DateTime.now())) {
          secondsDifference = elapsedTime.inSeconds;

          proggress = (secondsDifference! / totalSecound) * 100;
          setState(() {});
        } else {
          proggress = proggress! + 1.0;
          timer.cancel();
        }
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: MyContainerShape(
        paddingHorizontal: 12,
        paddingVertical: 12,
        borderRadius: 11,
        blur: 5,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                MyContainerShape(
                  height: 54.r,
                  width: 54.r,
                  bgContainer: AppColors.BASE_COLOR,
                  borderRadius: 100,
                  child: widget.offer.user!.image != null
                      ? Image.network(
                          widget.offer.user!.image!,
                          fit: BoxFit.cover,
                          height: 54.r,
                          width: 54.r,
                        )
                      : Image.asset('assets/images/ic_avatar.png'),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: MyText(
                              title: widget.offer.user!.name ?? "",
                              fontSize: 14,
                              textOverflow: true,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          widget.status == 1
                              ? MyText(
                                  title: widget.offer.category ?? "",
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.GRAY3,
                                )
                              : widget.status == 0
                                  ? MyContainerShape(
                                      paddingHorizontal: 6,
                                      paddingVertical: 5,
                                      borderRadius: 6,
                                      bgContainer: AppColors.YELLOW_LIGHT,
                                      child: MyText(
                                        fontSize: 12,
                                        title: AppLocalizations.of(context)!
                                            .orderDetails,
                                      ),
                                    )
                                  : Row(
                                      children: [
                                        SvgPicture.asset(
                                          'assets/images/ic_clock.svg',
                                          width: 10.r,
                                        ),
                                        SizedBox(width: 4.w),
                                        MyText(
                                          title:
                                              DateFormat('yyyy-MM-dd').format(
                                            DateFormat('yyyy-MM-dd')
                                                .parse(widget.offer.createdAt!),
                                          ),
                                          fontSize: 10,
                                          fontWeight: FontWeight.w400,
                                          color: AppColors.GRAY3,
                                        ),
                                      ],
                                    ),
                        ],
                      ),
                      SizedBox(height: 8.h),
                      Row(
                        children: [
                          if (widget.status == 0) ...[
                            MyText(
                              title: widget.offer.category ?? "",
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ] else ...[
                            SvgPicture.asset(
                              'assets/images/ic_signal.svg',
                              width: 14.r,
                            ),
                            SizedBox(width: 4.w),
                            MyText(
                              title: widget.offer.orderId.toString(),
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: AppColors.GRAY3,
                            ),
                          ],
                          const Spacer(),
                          widget.status == 2
                              ? MyText(
                                  title: widget.offer.category ?? "",
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.GRAY3,
                                )
                              : widget.status == 0
                                  ? const SizedBox()
                                  : const Icon(Icons.arrow_forward),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
            if (widget.status == 0) ...[
              SizedBox(height: 8.h),
              FAProgressBar(
                maxValue: 100,
                currentValue: proggress!,
                displayText: secondsDifference != null
                    ? '$secondsDifference ${AppLocalizations.of(context)!.second}'
                    : AppLocalizations.of(context)!.finishTime,
                size: 17,
                animatedDuration: Duration.zero,
                backgroundColor: AppColors.WHITE3,
                borderRadius: BorderRadius.circular(10),
                progressColor: AppColors.BASE_COLOR,
              ),
            ]
          ],
        ),
      ),
    );
  }
}
