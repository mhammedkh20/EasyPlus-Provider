import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:easy_plus_service_provider/core/utils/app_colors.dart';
import 'package:easy_plus_service_provider/core/utils/app_helpers.dart';
import 'package:easy_plus_service_provider/core/widgets/loading_widget.dart';
import 'package:easy_plus_service_provider/core/widgets/my_app_bar.dart';
import 'package:easy_plus_service_provider/core/widgets/my_text.dart';
import 'package:easy_plus_service_provider/features/main/model/offer2.dart';
import 'package:easy_plus_service_provider/features/main/views/manager/my_request_cubit/my_request_cubit.dart';
import 'package:easy_plus_service_provider/features/main/views/pages/bottom_nav/home/order_details/order_details_screen.dart';
import 'package:easy_plus_service_provider/features/main/views/pages/bottom_nav/my_offer/tapbar_my_requests.dart';
import 'package:easy_plus_service_provider/features/main/views/widgets/my_offers/item_order.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:lottie/lottie.dart';

import 'order_details/details_ended_order_screen.dart';
import 'order_details/details_progress_order_screen.dart';

class MyOffers extends StatefulWidget {
  const MyOffers({super.key});

  @override
  State<MyOffers> createState() => _MyOffersState();
}

class _MyOffersState extends State<MyOffers> {
  var _scrollController = ScrollController();

  @override
  void initState() {
    _scrollController.addListener(pagination);
    super.initState();
  }

  void pagination() async {
    if ((_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) &&
        (MyRequestCubit.get(context).listOffers.length <
            MyRequestCubit.get(context).total)) {
      await MyRequestCubit.get(context)
          .getOffers(context, loadPagination: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MyAppBar(
          backgroundColor: AppColors.BG_SCAFOLLD,
          title: AppLocalizations.of(context)!.myOffers,
        ),
        SizedBox(height: 16.h),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              children: [
                const TapBarMyRequests(),
                SizedBox(height: 16.h),
                Expanded(
                  child: BlocConsumer<MyRequestCubit, MyRequestState>(
                    listener: (context, state) {
                      if (state is MyOfferFailed) {
                        AppHelpers.showSnackBar(context,
                            message: state.message, error: true);
                      }
                    },
                    builder: (context, state) {
                      if (state is MyOfferLoading) {
                        return const LoadingWidget();
                      }
                      if (state is MyOfferFailed) {
                        return Center(
                          child: LottieBuilder.asset(
                            'assets/images/ic_json/faild.json',
                            width: 300.w,
                          ),
                        );
                      }
                      if (MyRequestCubit.get(context).listOffers.length == 0) {
                        return CustomRefreshIndicator(
                          leadingScrollIndicatorVisible: true,
                          trailingScrollIndicatorVisible: true,
                          builder: AppHelpers.getIndecatorDelegate(),
                          onRefresh: () async {
                            await MyRequestCubit.get(context)
                                .getOffers(context);
                          },
                          child: ListView(
                            padding: EdgeInsets.symmetric(vertical: 20.h),
                            physics: AlwaysScrollableScrollPhysics(),
                            children: [
                              MyText(
                                textAlign: TextAlign.center,
                                title:
                                    AppLocalizations.of(context)!.noDataOffers,
                              ),
                            ],
                          ),
                        );
                      }
                      List<Offer> listData =
                          MyRequestCubit.get(context).listOffers;

                      return Column(
                        children: [
                          Expanded(
                            child: CustomRefreshIndicator(
                              leadingScrollIndicatorVisible: true,
                              trailingScrollIndicatorVisible: true,
                              builder: AppHelpers.getIndecatorDelegate(),
                              onRefresh: () async {
                                await MyRequestCubit.get(context)
                                    .getOffers(context);
                              },
                              child: ListView.builder(
                                controller: _scrollController,
                                padding: EdgeInsets.zero,
                                physics: AlwaysScrollableScrollPhysics(),
                                itemCount: listData.length,
                                itemBuilder: (context, index) {
                                  int indexSelected =
                                      MyRequestCubit.get(context)
                                          .indexStatusMyRequest;
                                  return Column(
                                    children: [
                                      ItemOrder(
                                        offer: listData[index],
                                        status: indexSelected,
                                        onTap: () {
                                          if (indexSelected == 0) {
                                            AppHelpers.navigationToPage(
                                                context,
                                                OrderDetailsScreen(
                                                  orderId: listData[index]
                                                      .orderId
                                                      .toString(),
                                                  isOfferPrice: false,
                                                ));
                                          }
                                          if (indexSelected == 1) {
                                            AppHelpers.navigationToPage(
                                                context,
                                                DetailsProgressOrderScreen(
                                                  orderId: listData[index]
                                                      .orderId
                                                      .toString(),
                                                ));
                                          }
                                          if (indexSelected == 2) {
                                            AppHelpers.navigationToPage(
                                                context,
                                                DetailsEndedOrderScreen(
                                                  orderId: listData[index]
                                                      .orderId
                                                      .toString(),
                                                ));
                                          }
                                        },
                                      ),
                                      SizedBox(height: 12.h),
                                    ],
                                  );
                                },
                              ),
                            ),
                          ),
                          (state is MyOfferLoadingPagination)
                              ? const LoadingWidget()
                              : const SizedBox(),
                        ],
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
