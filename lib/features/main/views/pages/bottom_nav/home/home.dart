import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:easy_plus_service_provider/features/main/model/order_object2.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:easy_plus_service_provider/core/utils/app_helpers.dart';
import 'package:easy_plus_service_provider/core/widgets/loading_widget.dart';
import 'package:easy_plus_service_provider/core/widgets/my_text.dart';
import 'package:easy_plus_service_provider/features/main/model/home_response.dart';
import 'package:easy_plus_service_provider/features/main/views/manager/home_cubit/home_cubit.dart';
import 'package:easy_plus_service_provider/features/main/views/widgets/home/item_client_order.dart';
import 'package:easy_plus_service_provider/features/main/views/widgets/home/main_header_widget.dart';
import 'package:easy_plus_service_provider/features/main/views/widgets/home/my_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart' as lottie;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var _scrollController = ScrollController();

  @override
  void initState() {
    _scrollController.addListener(pagination);
    super.initState();
  }

  void pagination() async {
    if ((_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) &&
        (HomeCubit.get(context).listOrder.length <
            HomeCubit.get(context).total)) {
      await HomeCubit.get(context).getHomeData(context, loadPagination: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const MainHeaderWidget(),
        BlocConsumer<HomeCubit, HomeState>(
          listener: (context, state) {
            if (state is FailedHomeData) {
              AppHelpers.showSnackBar(
                context,
                message: state.message,
                error: true,
              );
            }
          },
          builder: (context, state) {
            if (state is LoadingHomeData) {
              return const LoadingWidget();
            }
            if (state is FailedHomeData) {
              return Center(
                child: lottie.LottieBuilder.asset(
                  'assets/images/ic_json/faild.json',
                ),
              );
            }
            if (HomeCubit.get(context).homeResponse == null) {
              return const LoadingWidget();
            }

            HomeResponse data = HomeCubit.get(context).homeResponse!;
            List<OrderObject2> listOrder = HomeCubit.get(context).listOrder;
            List<String> images = [];
            if (data.ads!.length > 0) {
              for (int i = 0; i < data.ads!.length; i++) {
                images.add(data.ads![i].image!);
              }
            }
            return Expanded(
              child: Column(
                children: [
                  if (data.ads != null)
                    if (data.ads!.length > 0)
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: MyPageView(
                          images: images,
                          withAnimation: images.length > 1,
                        ),
                      ),
                  SizedBox(height: 16.h),
                  if (data.data != null) ...[
                    if (data.data!.length > 0) ...[
                      Expanded(
                        child: CustomRefreshIndicator(
                          leadingScrollIndicatorVisible: true,
                          trailingScrollIndicatorVisible: true,
                          builder: AppHelpers.getIndecatorDelegate(),
                          onRefresh: () async {
                            HomeCubit.get(context).getHomeData(context);
                          },
                          child: ListView.builder(
                            controller: _scrollController,
                            physics: const AlwaysScrollableScrollPhysics(),
                            itemCount: listOrder.length,
                            padding: EdgeInsets.symmetric(horizontal: 16.w),
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  ItemClientOrder(order: listOrder[index]),
                                  SizedBox(height: 12.h),
                                ],
                              );
                            },
                          ),
                        ),
                      ),
                    ] else ...[
                      Expanded(
                        child: CustomRefreshIndicator(
                          leadingScrollIndicatorVisible: true,
                          trailingScrollIndicatorVisible: true,
                          builder: AppHelpers.getIndecatorDelegate(),
                          onRefresh: () async {
                            HomeCubit.get(context).getHomeData(context);
                          },
                          child: ListView(
                            padding: EdgeInsets.symmetric(vertical: 20.h),
                            physics: const AlwaysScrollableScrollPhysics(),
                            children: [
                              MyText(
                                textAlign: TextAlign.center,
                                title:
                                    AppLocalizations.of(context)!.noDataOrders,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                    (state is HomeLoadingPagination)
                        ? const LoadingWidget()
                        : const SizedBox(),
                  ] else ...[
                    Expanded(
                      child: CustomRefreshIndicator(
                        leadingScrollIndicatorVisible: true,
                        trailingScrollIndicatorVisible: true,
                        builder: AppHelpers.getIndecatorDelegate(),
                        onRefresh: () async {
                          HomeCubit.get(context).getHomeData(context);
                        },
                        child: ListView(
                          padding: EdgeInsets.symmetric(vertical: 20.h),
                          physics: const AlwaysScrollableScrollPhysics(),
                          children: [
                            MyText(
                              textAlign: TextAlign.center,
                              title: AppLocalizations.of(context)!.noDataOrders,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
