import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_plus_service_provider/core/utils/app_colors.dart';
import 'package:easy_plus_service_provider/core/widgets/my_contianer_shape.dart';
import 'package:easy_plus_service_provider/core/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:octo_image/octo_image.dart';

class ItemService extends StatelessWidget {
  const ItemService({
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
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Material(
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
                borderRadius: 8,
                height: 100.h,
                enableShadow: false,
                bgContainer: AppColors.TRANSPARENT,
                child: Column(
                  children: [
                    PreviewCardImage(
                      errorImage:
                          AssetImage('assets/images/bg_google_maps.png'),
                      url: icPath,
                      width: double.infinity,
                      hieght: 60.r,
                      fit: BoxFit.cover,
                    ),
                    Spacer(),
                    MyText(
                      title: title,
                      fontSize: 12,
                      textOverflow: true,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                    ),
                    Spacer(),
                  ],
                ),
              ),
            ),
          ),
          if (showCheck) ...[
            SizedBox(height: 4.h),
            SvgPicture.asset(
              isSelected
                  ? 'assets/images/ic_checked.svg'
                  : 'assets/images/ic_un_check.svg',
              width: 18.w,
            ),
          ]
        ],
      ),
    );
  }
}

class PreviewCardImage extends StatelessWidget {
  final String url;
  final AssetImage errorImage;
  final double? hieght;
  final double? width;
  final BoxFit fit;

  const PreviewCardImage({
    Key? key,
    required this.url,
    required this.errorImage,
    this.hieght,
    this.width,
    this.fit = BoxFit.contain,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OctoImage(
      image: CachedNetworkImageProvider(url),
      placeholderBuilder: OctoPlaceholder.blurHash(
        'LEHV6nWB2yk8pyo0adR*.7kCMdnj',
      ),
      errorBuilder: OctoError.icon(),
      fit: fit,
      height: hieght,
      width: width,
    );
  }
}
