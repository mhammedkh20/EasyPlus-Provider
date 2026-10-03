import 'package:easy_plus_service_provider/features/main/views/manager/my_account_cubit/my_account_cubit.dart';
import 'package:easy_plus_service_provider/features/main/views/widgets/profile/item_pick_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PickImagesForUser extends StatelessWidget {
  const PickImagesForUser({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12.h,
        crossAxisSpacing: 20.w,
        childAspectRatio: 173 / 88,
      ),
      children: [
        BlocBuilder<MyAccountCubit, MyAccountState>(
          builder: (context, state) {
            String? filePath = MyAccountCubit.get(context).idPhoto;
            return ItemPickImage(
              imageFromShared: MyAccountCubit.get(context).userData!.idImage,
              picked: MyAccountCubit.get(context).pickedIdPhoto,
              icon: 'assets/images/ic_id.svg',
              title: AppLocalizations.of(context)!.iDPhoto,
              onTapIconEdit: filePath != null
                  ? () async {
                      await MyAccountCubit.get(context).pickIdPhoto();
                    }
                  : null,
              onTapIconAdd: filePath == null
                  ? () async {
                      await MyAccountCubit.get(context).pickIdPhoto();
                    }
                  : null,
              filePath: filePath,
            );
          },
        ),
        BlocBuilder<MyAccountCubit, MyAccountState>(
          builder: (context, state) {
            String? filePath = MyAccountCubit.get(context).licenseImage;
            return ItemPickImage(
              picked: MyAccountCubit.get(context).pickedLicense,
              icon: 'assets/images/ic_id.svg',
              title: AppLocalizations.of(context)!.licenseImage,
              imageFromShared:
                  MyAccountCubit.get(context).userData!.licenseImage,
              onTapIconEdit: filePath != null
                  ? () async {
                      await MyAccountCubit.get(context).pickLicenseImage();
                    }
                  : null,
              onTapIconAdd: filePath == null
                  ? () async {
                      await MyAccountCubit.get(context).pickLicenseImage();
                    }
                  : null,
              filePath: filePath,
            );
          },
        ),
        //   BlocBuilder<MyAccountCubit, MyAccountState>(
        //     builder: (context, state) {
        //       String? filePath = MyAccountCubit.get(context).vehicleImage;
        //       return ItemPickImage(
        //         picked: MyAccountCubit.get(context).pickedVehicleImage,
        //         icon: 'assets/images/ic_pick_image.svg',
        //         title: AppLocalizations.of(context)!.vehicleImage,
        //         imageFromShared: MyAccountCubit.get(context).userData!.carImage,
        //         onTapIconEdit: filePath != null
        //             ? () async {
        //                 await MyAccountCubit.get(context).pickVehicleImage();
        //               }
        //             : null,
        //         onTapIconAdd: filePath == null
        //             ? () async {
        //                 await MyAccountCubit.get(context).pickVehicleImage();
        //               }
        //             : null,
        //         filePath: filePath,
        //       );
        //     },
        //   ),
      ],
    );
  }
}
