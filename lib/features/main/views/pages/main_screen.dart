import 'dart:developer';

import 'package:easy_plus_service_provider/core/network/api/notification_api.dart';
import 'package:easy_plus_service_provider/core/utils/app_helpers.dart';
import 'package:easy_plus_service_provider/features/auth/views/manager/auth_cubit/auth_cubit.dart';
import 'package:easy_plus_service_provider/features/main/views/manager/common_quastions_cubit/common_quastions_cubit.dart';
import 'package:easy_plus_service_provider/features/main/views/manager/home_cubit/home_cubit.dart';
import 'package:easy_plus_service_provider/features/main/views/manager/main_cubit/main_cubit.dart';
import 'package:easy_plus_service_provider/features/main/views/manager/my_account_cubit/my_account_cubit.dart';
import 'package:easy_plus_service_provider/features/main/views/manager/my_request_cubit/my_request_cubit.dart';
import 'package:easy_plus_service_provider/features/main/views/pages/bottom_nav/home/show_orders_on_googlemap_screen.dart';
import 'package:easy_plus_service_provider/features/main/views/widgets/main/my_body.dart';
import 'package:easy_plus_service_provider/features/main/views/widgets/main/my_bottom_nav.dart';
import 'package:easy_plus_service_provider/core/utils/app_colors.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    MyAccountCubit.get(context).getUserDataFromShared();
    HomeCubit.get(context).setDataTourType(context);
    HomeCubit.get(context).getHomeData(context);
    CommonQuastionsCubit.get(context).getQustion(context);
    MyRequestCubit.get(context).getOffers(context);
    MainCubit.get(context).getCurrentPosition(context);
    AuthCubit.get(context).getProfile(context);

    NotificationApi.init();
    NotificationApi.requestIOSPermissions();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('here notification');
      log('this is notification');

      RemoteNotification? notification = message.notification;

      if (notification != null) {
        print('here notification1');

        if (notification.title != null) {
          print('here notification2');

          NotificationApi.showNotification(
            id: notification.hashCode,
            title: notification.title ?? "",
            body: notification.body ?? "",
            urlImage: notification.android == null
                ? null
                : notification.android!.imageUrl,
            // payload: 'mohammed',
          );
        }
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.WHITE2,
      body: const MyBody(),
      bottomNavigationBar: const MyBottomNav(),
      floatingActionButton: BlocBuilder<MainCubit, MainState>(
        builder: (context, state) {
          if (MainCubit.get(context).indexPageNav != 0) {
            return const SizedBox();
          }
          return BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              bool isLoading = (state is LoadingHomeData);
              return FloatingActionButton(
                child: isLoading
                    ? const Center(
                        child: CircularProgressIndicator.adaptive(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(AppColors.GRAY),
                        ),
                      )
                    : const Icon(Icons.map_outlined),
                backgroundColor: AppColors.BASE_COLOR,
                onPressed: isLoading
                    ? null
                    : () {
                        AppHelpers.navigationToPage(
                            context, const ShowOrderOnGoogleMapScreen());
                      },
              );
            },
          );
        },
      ),
    );
  }
}
