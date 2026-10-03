import 'package:easy_plus_service_provider/core/utils/app_helpers.dart';
import 'package:easy_plus_service_provider/features/main/model/order_object2.dart';
import 'package:easy_plus_service_provider/features/main/views/pages/bottom_nav/home/order_details/order_details_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:easy_plus_service_provider/core/utils/app_colors.dart';
import 'package:easy_plus_service_provider/core/widgets/my_contianer_shape.dart';
import 'package:easy_plus_service_provider/core/widgets/my_text.dart';
import 'package:flutter/material.dart';

class ItemClientOrder extends StatelessWidget {
  final OrderObject2 order;

  const ItemClientOrder({
    super.key,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        AppHelpers.navigationToPage(
            context,
            OrderDetailsScreen(
              orderId: order.id.toString(),
            ));
      },
      child: MyContainerShape(
        borderRadius: 8,
        paddingHorizontal: 12,
        paddingVertical: 12,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MyContainerShape(
              height: 54.r,
              width: 54.r,
              bgContainer: AppColors.BASE_COLOR,
              borderRadius: 100,
              child: order.user!.image != null
                  ? Image.network(
                      'https://easyplus.app/storage/' + order.user!.image!,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                    )
                  : Image.asset('assets/images/ic_avatar.png'),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyText(
                    title: order.user!.name ?? "",
                    fontSize: 15,
                  ),
                  SizedBox(height: 4.h),
                  MyText(
                    title: order.category ?? "",
                    color: AppColors.GRAY3,
                    fontSize: 14,
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                AppHelpers.navigationToPage(
                    context,
                    OrderDetailsScreen(
                      orderId: order.id.toString(),
                    ));
              },
              child: MyContainerShape(
                paddingHorizontal: 6,
                paddingVertical: 5,
                borderRadius: 6,
                bgContainer: AppColors.YELLOW_LIGHT,
                child: MyText(
                  fontSize: 12,
                  title: AppLocalizations.of(context)!.orderDetails,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
