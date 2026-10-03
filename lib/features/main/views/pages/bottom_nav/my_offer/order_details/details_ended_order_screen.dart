import 'package:easy_plus_service_provider/core/utils/app_colors.dart';
import 'package:easy_plus_service_provider/core/utils/app_helpers.dart';
import 'package:easy_plus_service_provider/core/widgets/loading_widget.dart';
import 'package:easy_plus_service_provider/core/widgets/my_app_bar.dart';
import 'package:easy_plus_service_provider/features/main/model/order_response.dart';
import 'package:easy_plus_service_provider/features/main/views/manager/my_request_cubit/my_request_cubit.dart';
import 'package:easy_plus_service_provider/features/main/views/pages/bottom_nav/settings/complaint_request/mack_complaint_screen.dart';
import 'package:easy_plus_service_provider/features/main/views/widgets/home/order_details/from_starting_address_to_widget.dart';
import 'package:easy_plus_service_provider/features/main/views/widgets/home/order_details/order_data_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:lottie/lottie.dart';

class DetailsEndedOrderScreen extends StatefulWidget {
  final String orderId;
  const DetailsEndedOrderScreen({
    super.key,
    required this.orderId,
  });

  @override
  State<DetailsEndedOrderScreen> createState() =>
      _DetailsEndedOrderScreenState();
}

class _DetailsEndedOrderScreenState extends State<DetailsEndedOrderScreen> {
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
        actions: [
          GestureDetector(
            onTap: () {
              AppHelpers.navigationToPage(
                  context,
                  MackComplaintScreen(
                    orderId: int.parse(widget.orderId),
                  ));
            },
            child: Icon(
              Icons.report_gmailerrorred,
              size: 24.r,
            ),
          ),
          SizedBox(width: 10.w),
        ],
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
                return const LoadingWidget();
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
                    SizedBox(height: 12.h),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
