import 'dart:io';

import 'package:easy_plus_service_provider/core/utils/app_colors.dart';
import 'package:easy_plus_service_provider/core/utils/app_dialogs.dart';
import 'package:easy_plus_service_provider/core/utils/app_helpers.dart';
import 'package:easy_plus_service_provider/core/widgets/loading_widget.dart';
import 'package:easy_plus_service_provider/core/widgets/my_app_bar.dart';
import 'package:easy_plus_service_provider/features/main/model/order_response.dart';
import 'package:easy_plus_service_provider/features/main/views/manager/home_cubit/home_cubit.dart';
import 'package:easy_plus_service_provider/features/main/views/manager/my_request_cubit/my_request_cubit.dart';
import 'package:easy_plus_service_provider/features/main/views/widgets/home/order_details/order_data_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:lottie/lottie.dart';
import 'package:map_launcher/map_launcher.dart';
import '../../../../../../../core/widgets/my_contianer_shape.dart';
import '../../../../../../../core/widgets/my_elevated_button.dart';
import '../../../../widgets/home/order_details/from_starting_address_to_widget.dart';

class DetailsProgressOrderScreen extends StatefulWidget {
  final String orderId;
  const DetailsProgressOrderScreen({
    super.key,
    required this.orderId,
  });

  @override
  State<DetailsProgressOrderScreen> createState() =>
      _DetailsProgressOrderScreenState();
}

class _DetailsProgressOrderScreenState
    extends State<DetailsProgressOrderScreen> {
  @override
  void initState() {
    MyRequestCubit.get(context).getOrderDetails(context, widget.orderId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.BG_SCAFOLLD,
      appBar: MyAppBar(
        backgroundColor: AppColors.BG_SCAFOLLD,
        title: AppLocalizations.of(context)!.orderDetails,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: BlocConsumer<MyRequestCubit, MyRequestState>(
            listener: (context, state) {
              if (state is OrderDetailsFailed) {
                AppHelpers.showSnackBar(context,
                    message: state.message, error: true);
              }
            },
            builder: (context, state) {
              if (state is OrderDetailsLoading) {
                return LoadingWidget();
              }
              if (state is OrderDetailsFailed) {
                return Center(
                  child: LottieBuilder.asset(
                    'assets/images/ic_json/faild.json',
                    width: 300.w,
                  ),
                );
              }
              OrderResponse orderResponse =
                  MyRequestCubit.get(context).dataOrderDetails!;

              return SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 16.h),
                    const FromStartingAddressTo(),
                    SizedBox(height: 16.h),
                    OrderDataWidget(data: orderResponse),
                    SizedBox(height: 16.h),
                    if (orderResponse.data!.startLat != null)
                      GestureDetector(
                        onTap: () async {
                          await openMap(orderResponse);
                        },
                        child: MyContainerShape(
                          height: 181.h,
                          width: double.infinity,
                          borderRadius: 11,
                          enableShadow: false,
                          child: Stack(
                            children: [
                              Image.asset(
                                'assets/images/bg_google_maps.png',
                                fit: BoxFit.cover,
                                width: double.infinity,
                              ),
                              Center(
                                child: Image.asset(
                                  'assets/images/pin.png',
                                  width: 30.r,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    SizedBox(height: 27.h),
                    Row(
                      children: [
                        Expanded(
                          child: MyElevatedButton(
                            titleColor: AppColors.BLACK,
                            title: AppLocalizations.of(context)!.orderStatus,
                            onPressed: () async {
                              await openMap(orderResponse);
                            },
                          ),
                        ),
                        SizedBox(width: 16.w),
                        Expanded(
                          child: BlocConsumer<MyRequestCubit, MyRequestState>(
                            listener: (context, state) {
                              if (state is CancelSuccess) {
                                Navigator.pop(context);

                                AppHelpers.showSnackBar(context,
                                    message: state.message);
                              }
                              if (state is CancelFailed) {
                                AppHelpers.showSnackBar(context,
                                    message: state.message, error: true);
                              }
                            },
                            builder: (context, state) {
                              if (state is CancelLoading) {
                                return const CircularProgressIndicator
                                    .adaptive();
                              }
                              return MyElevatedButton(
                                title: AppLocalizations.of(context)!
                                    .cancellingOrder,
                                onPressed: () {
                                  int index = HomeCubit.get(context)
                                      .appConfig!
                                      .categories!
                                      .indexWhere((element) =>
                                          element.id ==
                                          orderResponse.data!.categoryId);
                                  String? cancellationDriver =
                                      HomeCubit.get(context)
                                          .appConfig!
                                          .categories![index]
                                          .cancellationDriver;

                                  double tax =
                                      double.parse(cancellationDriver!);
                                  OrderResponse data =
                                      MyRequestCubit.get(context)
                                          .dataOrderDetails!;

                                  double price =
                                      double.parse(data.data!.initialPrice!);

                                  AppDialogs.showDeleteOrderDialog(
                                    context,
                                    price: price * tax / 100,
                                    onPressedNo: () {
                                      Navigator.of(context).pop();
                                    },
                                    onPressedYes: () {
                                      Navigator.of(context).pop();
                                      MyRequestCubit.get(context).cancelOrder(
                                          context, int.parse(widget.orderId));
                                    },
                                  );
                                },
                                titleColor: AppColors.BLACK,
                                background: AppColors.TRANSPARENT,
                                borderColor: AppColors.BLACK,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 27.h),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Future openMap(orderResponse) async {
    if (orderResponse.data!.endLat != null) {
      MapLauncher.showDirections(
        mapType: Platform.isAndroid ? MapType.google : MapType.apple,
        destination: Coords(
          double.parse(orderResponse.data!.startLat!),
          double.parse(orderResponse.data!.startLng!),
        ),
        origin: Coords(
          double.parse(orderResponse.data!.endLat!),
          double.parse(orderResponse.data!.endLng!),
        ),
      );
    } else {
      MapLauncher.showMarker(
          mapType: Platform.isAndroid ? MapType.google : MapType.apple,
          coords: Coords(
            double.parse(orderResponse.data!.startLat!),
            double.parse(orderResponse.data!.startLng!),
          ),
          title: '');
    }
  }
}
