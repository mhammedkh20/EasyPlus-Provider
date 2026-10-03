import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_plus_service_provider/core/utils/app_colors.dart';
import 'package:easy_plus_service_provider/core/widgets/my_contianer_shape.dart';
import 'package:easy_plus_service_provider/core/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:octo_image/octo_image.dart';

class ItemService2 extends StatelessWidget {
  const ItemService2({
    super.key,
    required this.isSelected,
    required this.title,
    required this.icPath,
    required this.isSvg,
    required this.onTap,
    this.background,
    this.showCheck = false,
  });

  final bool isSelected;
  final String title;
  final String icPath;
  final bool isSvg;
  final Color? background;
  final bool showCheck;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(8.r),
      color: background == null
          ? isSelected
              ? AppColors.YELLOW_LIGHT
              : AppColors.WHITE2
          : background!,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8.r),
        child: MyContainerShape(
          paddingVertical: 7,
          borderRadius: 8,
          enableBorder: true,
          paddingHorizontal: 16,
          enableShadow: false,
          bgContainer: AppColors.TRANSPARENT,
          child: Row(
            children: [
              if (showCheck) ...[
                SvgPicture.asset(
                  isSelected
                      ? 'assets/images/ic_checked.svg'
                      : 'assets/images/ic_un_check.svg',
                  width: 18.w,
                ),
                SizedBox(width: 10.w),
              ],
              PreviewCardImage(
                errorImage: AssetImage('assets/images/bg_google_maps.png'),
                url: icPath,
                width: 40.r,
                hieght: 40.r,
              ),
              SizedBox(width: 16.w),
              MyText(
                title: title,
                fontSize: 14,
                textAlign: TextAlign.center,
              ),
              Spacer(),
              Icon(isSelected ? Icons.expand_less : Icons.expand_more)
            ],
          ),
        ),
      ),
    );
  }
}

class PreviewCardImage extends StatelessWidget {
  final String url;
  final AssetImage errorImage;
  final double? hieght;
  final double? width;

  const PreviewCardImage({
    Key? key,
    required this.url,
    required this.errorImage,
    this.hieght,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OctoImage(
      image: CachedNetworkImageProvider(url),
      placeholderBuilder: OctoPlaceholder.blurHash(
        'LEHV6nWB2yk8pyo0adR*.7kCMdnj',
      ),
      errorBuilder: OctoError.icon(),
      fit: BoxFit.cover,
      height: hieght,
      width: width,
    );
  }
}
