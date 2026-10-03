import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:easy_plus_service_provider/core/widgets/my_text.dart';
import 'package:easy_plus_service_provider/features/main/views/widgets/profile/pick_image_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class HeaderProfile extends StatelessWidget {
  const HeaderProfile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 215.h,
      width: double.infinity,
      child: Stack(
        children: [
          PositionedDirectional(
            top: 0,
            start: 0,
            end: 0,
            child: SvgPicture.asset(
              'assets/images/bg_profile.svg',
              width: double.infinity,
              height: 170.h,
              fit: BoxFit.fill,
            ),
          ),
          PositionedDirectional(
            end: 0,
            start: 0,
            bottom: 0,
            child: Column(
              children: [
                MyText(
                  title: AppLocalizations.of(context)!.profile,
                  fontSize: 20,
                ),
                SizedBox(height: 12.h),
                const PickImageUser(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
