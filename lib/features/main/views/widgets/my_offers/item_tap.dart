import 'package:easy_plus_service_provider/core/utils/app_colors.dart';
import 'package:easy_plus_service_provider/core/widgets/my_contianer_shape.dart';
import 'package:easy_plus_service_provider/core/widgets/my_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';

class ItemTap extends StatelessWidget {
  const ItemTap({
    super.key,
    required this.onTap,
    required this.selected,
    required this.title,
  });

  final String title;
  final bool selected;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Material(
        color: selected ? AppColors.BASE_COLOR : AppColors.TRANSPARENT,
        borderRadius: BorderRadius.circular(30.r),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(30.r),
          child: MyContainerShape(
            borderRadius: 30,
            height: double.infinity,
            bgContainer: AppColors.TRANSPARENT,
            enableShadow: false,
            child: MyText(
              title: title,
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: selected ? AppColors.WHITE : AppColors.BLACK,
            ),
          ),
        ),
      ),
    );
  }
}
