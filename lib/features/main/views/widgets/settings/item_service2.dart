import 'package:easy_plus_service_provider/core/utils/app_colors.dart';
import 'package:easy_plus_service_provider/core/widgets/my_contianer_shape.dart';
import 'package:easy_plus_service_provider/core/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ItemService2 extends StatelessWidget {
  const ItemService2({
    super.key,
    required this.isSelected,
    required this.title,
    required this.icPath,
    required this.isSvg,
    required this.onTap,
  });

  final bool isSelected;
  final String title;
  final String icPath;
  final bool isSvg;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          GestureDetector(
            onTap: onTap,
            child: MyContainerShape(
              paddingVertical: 7,
              borderRadius: 8,
              enableShadow: false,
              bgContainer: AppColors.TRANSPARENT,
              child: Column(
                children: [
                  isSvg
                      ? SvgPicture.asset(
                          icPath,
                          width: 25.r,
                          height: 25.r,
                        )
                      : Image.asset(
                          icPath,
                          width: 25.r,
                          height: 25.r,
                        ),
                  MyText(
                    title: title,
                    fontSize: 12,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
