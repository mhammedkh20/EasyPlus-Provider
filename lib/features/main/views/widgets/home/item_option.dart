import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_plus_service_provider/core/utils/app_colors.dart';
import 'package:easy_plus_service_provider/core/widgets/my_contianer_shape.dart';
import 'package:easy_plus_service_provider/core/widgets/my_text.dart';
import 'package:flutter/material.dart';

class ItemOption extends StatelessWidget {
  const ItemOption({
    super.key,
    required this.isSelected,
    required this.title,
    required this.onTapOption,
  });

  final bool isSelected;
  final String title;
  final Function()? onTapOption;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapOption,
      child: MyContainerShape(
        height: 30.h,
        paddingHorizontal: 10,
        borderRadius: 20,
        bgContainer:
            isSelected ? AppColors.YELLOW_LIGHT : AppColors.TRANSPARENT,
        enableShadow: false,
        colorBorder: isSelected ? AppColors.YELLOW_LIGHT : AppColors.BORDER,
        enableBorder: true,
        child: MyText(title: title),
      ),
    );
  }
}
