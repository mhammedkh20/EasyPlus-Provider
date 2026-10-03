import 'package:easy_plus_service_provider/core/utils/app_colors.dart';
import 'package:easy_plus_service_provider/core/widgets/my_contianer_shape.dart';
import 'package:easy_plus_service_provider/features/main/views/manager/main_cubit/main_cubit.dart';
import 'package:easy_plus_service_provider/features/main/views/widgets/main/item_bottom_nav.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyBottomNav extends StatelessWidget {
  const MyBottomNav({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        MyContainerShape(
          height: 60.h,
          topEndRaduis: 32,
          topStartRaduis: 32,
          yOffset: -4,
          enableShadow: true,
          child: BlocBuilder<MainCubit, MainState>(
            builder: (context, state) {
              int indexSelected = MainCubit.get(context).indexPageNav;
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ItemBottomNav(
                    isSelected: indexSelected == 0,
                    title: MainCubit.get(context).getPage(context)[0].title,
                    icPath: 'assets/images/ic_bottom_nav/ic_home.svg',
                    onTap: () {
                      MainCubit.get(context).changeIndex(0);
                    },
                  ),
                  ItemBottomNav(
                    isSelected: indexSelected == 1,
                    title: MainCubit.get(context).getPage(context)[1].title,
                    icPath: 'assets/images/ic_bottom_nav/ic_offers.svg',
                    onTap: () {
                      MainCubit.get(context).changeIndex(1);
                    },
                  ),
                  ItemBottomNav(
                    isSelected: indexSelected == 2,
                    title: MainCubit.get(context).getPage(context)[2].title,
                    icPath: 'assets/images/ic_bottom_nav/ic_profile.svg',
                    onTap: () {
                      MainCubit.get(context).changeIndex(2);
                    },
                  ),
                  ItemBottomNav(
                    isSelected: indexSelected == 3,
                    title: MainCubit.get(context).getPage(context)[3].title,
                    icPath: 'assets/images/ic_bottom_nav/ic_settings.svg',
                    onTap: () {
                      MainCubit.get(context).changeIndex(3);
                    },
                  ),
                ],
              );
            },
          ),
        ),
        Container(
          color: AppColors.WHITE,
          height: MediaQuery.of(context).viewPadding.bottom < 5
              ? 10.h
              : MediaQuery.of(context).viewPadding.bottom,
        ),
      ],
    );
  }
}
