import 'dart:io';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_plus_service_provider/core/utils/app_colors.dart';
import 'package:easy_plus_service_provider/core/widgets/my_contianer_shape.dart';
import 'package:easy_plus_service_provider/core/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ItemPickImage extends StatelessWidget {
  const ItemPickImage({
    super.key,
    required this.title,
    required this.icon,
    required this.picked,
    this.imageFromShared,
    this.filePath,
    this.onTapIconEdit,
    this.onTapIconAdd,
  });

  final String? filePath;
  final String? imageFromShared;
  final String title;
  final String icon;
  final bool picked;
  final Function()? onTapIconEdit;
  final Function()? onTapIconAdd;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            children: [
              Row(
                children: [
                  SvgPicture.asset(
                    icon,
                    width: 22.w,
                  ),
                  SizedBox(width: 5.w),
                  MyText(
                    title: title,
                    fontSize: 12,
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              Expanded(
                child: GestureDetector(
                  onTap: onTapIconAdd,
                  child: MyContainerShape(
                    enableShadow: false,
                    bgContainer: AppColors.TRANSPARENT,
                    borderRadius: 8,
                    enableBorder: true,
                    child: picked
                        ? Image.file(
                            File(filePath!),
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
                          )
                        : imageFromShared != null
                            ? Image.network(
                                imageFromShared!,
                                width: double.infinity,
                                height: double.infinity,
                                fit: BoxFit.cover,
                              )
                            : filePath == null
                                ? const Icon(
                                    Icons.add_a_photo,
                                    color: AppColors.GRAY3,
                                  )
                                : Image.file(
                                    File(filePath!),
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    height: double.infinity,
                                  ),
                  ),
                ),
              ),
            ],
          ),
        ),
        if (filePath != null) ...[
          SizedBox(width: 14.w),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 30.h),
              GestureDetector(
                onTap: onTapIconEdit,
                child: MyContainerShape(
                  height: 36.r,
                  width: 36.r,
                  borderRadius: 8,
                  enableShadow: false,
                  enableBorder: true,
                  bgContainer: AppColors.TRANSPARENT,
                  child: SvgPicture.asset(
                    'assets/images/ic_edit_image.svg',
                  ),
                ),
              )
            ],
          )
        ]
      ],
    );
  }
}
