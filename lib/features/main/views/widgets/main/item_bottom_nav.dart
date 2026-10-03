
import 'package:easy_plus_service_provider/core/utils/app_colors.dart';
import 'package:easy_plus_service_provider/core/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ItemBottomNav extends StatelessWidget {
  const ItemBottomNav({
    super.key,
    required this.isSelected,
    required this.title,
    required this.icPath,
    required this.onTap,
  });

  final String icPath;
  final String title;
  final bool isSelected;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          color: AppColors.TRANSPARENT,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SvgPicture.asset(
                icPath,
                width: 20.r,
                height: 20.r,
                colorFilter: ColorFilter.mode(
                  isSelected ? AppColors.BASE_COLOR : AppColors.ICON_COLOR,
                  BlendMode.srcIn,
                ),
              ),
              SizedBox(height: 4.h),
              MyText(
                title: title,
                fontSize: 10,
                color: isSelected ? AppColors.BASE_COLOR : AppColors.ICON_COLOR,
              ),
              SizedBox(height: 8.h),
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                height: isSelected ? 4.h : 0,
                width: 25.w,
                decoration: BoxDecoration(
                  color: AppColors.BASE_COLOR,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
