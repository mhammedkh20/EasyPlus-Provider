import 'package:easy_plus_service_provider/core/utils/app_colors.dart';
import 'package:easy_plus_service_provider/core/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyElevatedButton extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;
  final double fontSize;
  final Color? titleColor;
  final FontWeight fontWeight;
  final Color borderColor;
  final Color? background;
  final double borderWidth;
  final double height;
  final double width;
  final double borderRaduis;
  final bool enabledBorder;
  final double? elevation;
  final IconData? iconPath;
  final bool iconStart;

  MyElevatedButton({
    Key? key,
    required this.title,
    this.onPressed,
    this.fontSize = 17,
    this.titleColor = AppColors.WHITE,
    this.fontWeight = FontWeight.w500,
    this.borderColor = AppColors.TRANSPARENT,
    this.background,
    this.borderWidth = 1,
    this.height = 51,
    this.borderRaduis = 50,
    this.width = 176,
    this.enabledBorder = true,
    this.elevation,
    this.iconPath,
    this.iconStart = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          minimumSize: MaterialStateProperty.all(Size(width.w, height.h)),
          shadowColor: MaterialStateProperty.resolveWith<Color?>(
              (states) => AppColors.TRANSPARENT),
          backgroundColor:
              MaterialStateProperty.resolveWith<Color?>((states) => background),
          elevation:
              MaterialStateProperty.resolveWith<double?>((states) => elevation),
          shape: MaterialStateProperty.resolveWith(
            (states) {
              if (states.contains(MaterialState.pressed)) {
                return RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(borderRaduis.r),
                  side: BorderSide(
                    color: AppColors.BASE_COLOR,
                    width: borderWidth,
                  ),
                );
              }
              if (states.contains(MaterialState.hovered)) {
                return RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(borderRaduis.r),
                  side: BorderSide(
                    color: AppColors.BASE_COLOR,
                    width: borderWidth,
                  ),
                );
              }
              return RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRaduis.r),
                side: BorderSide(
                  color: borderColor,
                  width: borderWidth,
                ),
              );
            },
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (iconStart)
              if (iconPath != null) ...[
                Icon(
                  iconPath,
                  size: 26.r,
                ),
                SizedBox(width: 8.w),
              ],
            MyText(
              title: title,
              fontSize: fontSize,
              color: titleColor,
              fontWeight: fontWeight,
              textAlign: TextAlign.center,
            ),
            if (!iconStart)
              if (iconPath != null) ...[
                SizedBox(width: 8.w),
                Icon(
                  iconPath,
                  size: 26.r,
                ),
              ],
          ],
        ));
  }
}
