import 'package:easy_plus_service_provider/core/storage/pref/shared_pref_controller.dart';
import 'package:easy_plus_service_provider/core/utils/app_colors.dart';
import 'package:easy_plus_service_provider/core/utils/app_helpers.dart';
import 'package:easy_plus_service_provider/features/main/views/pages/bottom_nav/settings/comming_soon_screen.dart';
import 'package:easy_plus_service_provider/features/main/views/pages/bottom_nav/settings/my_services_screen.dart';
import 'package:easy_plus_service_provider/features/main/views/pages/main_screen.dart';
import 'package:easy_plus_service_provider/features/on_boarding/views/manager/onboarding_cubit/on_boarding_cubit.dart';
import 'package:easy_plus_service_provider/features/on_boarding/views/pages/on_boarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    OnBoardingCubit.get(context).getMethods(context);
    return BlocConsumer<OnBoardingCubit, OnBoardingState>(
      listener: (context, state) {
        if (state is GetDataFailed500) {
          AppHelpers.navigationReplacementToPage(
              context, const CommingSoonScreen());
        }
        if (state is GetDataFailed) {
          if (SharedPrefController().getToken != null) {
            AppHelpers.navigationReplacementToPage(context, const MainScreen());
          } else {
            AppHelpers.navigationReplacementToPage(
              context,
              const OnBoardingScreen(),
            );
          }
          AppHelpers.showSnackBar(
            context,
            message: state.message,
            error: true,
          );
        }
        if (state is GetDataSuccess) {
          if (SharedPrefController().getToken != null) {
            if (SharedPrefController().getNavigationFromService!) {
              AppHelpers.navigationReplacementToPage(
                  context, const MainScreen());
            } else {
              AppHelpers.navigationReplacementToPage(
                  context, MyServiceScreen());
            }
          } else {
            AppHelpers.navigationReplacementToPage(
              context,
              const OnBoardingScreen(),
            );
          }
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.BASE_COLOR,
          body: Center(
            child: SvgPicture.asset(
              'assets/images/ic_app.svg',
              width: 250.r,
              height: 250.r,
            ),
          ),
        );
      },
    );
  }
}
