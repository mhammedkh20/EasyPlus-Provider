import 'package:easy_plus_service_provider/core/utils/app_colors.dart';
import 'package:easy_plus_service_provider/core/widgets/my_contianer_shape.dart';
import 'package:easy_plus_service_provider/features/main/views/manager/my_request_cubit/my_request_cubit.dart';
import 'package:easy_plus_service_provider/features/main/views/widgets/my_offers/item_tap.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';

class TapBarMyRequests extends StatelessWidget {
  const TapBarMyRequests({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MyContainerShape(
      bgContainer: AppColors.WHITE,
      height: 65.h,
      borderRadius: 70,
      enableShadow: false,
      paddingHorizontal: 12,
      paddingVertical: 10,
      child: BlocBuilder<MyRequestCubit, MyRequestState>(
        builder: (context, state) {
          int selected = MyRequestCubit.get(context).indexStatusMyRequest;
          return Row(
            children: [
              ItemTap(
                selected: selected == 0,
                title: AppLocalizations.of(context)!.current,
                onTap: () {
                  MyRequestCubit.get(context).changeStatusMyRequest(0);
                  if (selected != 0) {
                    MyRequestCubit.get(context).clearData(withEmit: false);
                    MyRequestCubit.get(context).changeStatusMyRequest(0);
                    MyRequestCubit.get(context).getOffers(context);
                  }
                },
              ),
              ItemTap(
                selected: selected == 1,
                title: AppLocalizations.of(context)!.processing,
                onTap: () {
                  if (selected != 1) {
                    MyRequestCubit.get(context).clearData(withEmit: false);
                    MyRequestCubit.get(context).changeStatusMyRequest(1);
                    MyRequestCubit.get(context).getOffers(context);
                  }
                },
              ),
              ItemTap(
                selected: selected == 2,
                title: AppLocalizations.of(context)!.ended,
                onTap: () {
                  if (selected != 2) {
                    MyRequestCubit.get(context).clearData(withEmit: false);
                    MyRequestCubit.get(context).changeStatusMyRequest(2);
                    MyRequestCubit.get(context).getOffers(context);
                  }
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
