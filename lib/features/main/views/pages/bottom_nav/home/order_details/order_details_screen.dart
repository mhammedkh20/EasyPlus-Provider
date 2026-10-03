import 'dart:async';
import 'package:easy_plus_service_provider/core/utils/app_colors.dart';
import 'package:easy_plus_service_provider/core/utils/app_helpers.dart';
import 'package:easy_plus_service_provider/core/widgets/loading_widget.dart';
import 'package:easy_plus_service_provider/core/widgets/my_app_bar.dart';
import 'package:easy_plus_service_provider/core/widgets/my_check_box.dart';
import 'package:easy_plus_service_provider/core/widgets/my_contianer_shape.dart';
import 'package:easy_plus_service_provider/core/widgets/my_elevated_button.dart';
import 'package:easy_plus_service_provider/core/widgets/my_text.dart';
import 'package:easy_plus_service_provider/core/widgets/my_text_field.dart';
import 'package:easy_plus_service_provider/features/main/model/order_response.dart';
import 'package:easy_plus_service_provider/features/main/views/manager/home_cubit/home_cubit.dart';
import 'package:easy_plus_service_provider/features/main/views/manager/my_request_cubit/my_request_cubit.dart';
import 'package:easy_plus_service_provider/features/main/views/manager/total_price_cubit/total_price_cubit.dart';
import 'package:easy_plus_service_provider/features/main/views/manager/wallet_cubit/wallet_cubit.dart';
import 'package:easy_plus_service_provider/features/main/views/widgets/home/order_details/from_starting_address_to_widget.dart';
import 'package:easy_plus_service_provider/features/main/views/widgets/home/order_details/order_data_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:lottie/lottie.dart';

class OrderDetailsScreen extends StatefulWidget {
  final String orderId;
  final bool isOfferPrice;
  const OrderDetailsScreen({
    super.key,
    required this.orderId,
    this.isOfferPrice = true,
  });
  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  final TextEditingController _priceController = TextEditingController();
  int lengthPrice = 0;
  bool check = true;
  double tax = 0;
  double commission = 0;
  double total = 0;
  Timer? searchOnStoppedTyping;

  @override
  void initState() {
    MyRequestCubit.get(context).getOrderDetails(context, widget.orderId);
    super.initState();
  }

  @override
  void deactivate() {
    TotalPriceCubit.get(context).addTotalPrice(null, withEmit: false);
    super.deactivate();
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
              if (orderResponse.data!.initialPrice != null && check) {
                _priceController.text = orderResponse.data!.initialPrice ?? "";
                check = false;
                TotalPriceCubit.get(context).addTotalPrice(
                    double.parse(orderResponse.data!.initialPrice!));
              }

              int index = HomeCubit.get(context)
                  .appConfig!
                  .categories!
                  .indexWhere((element) =>
                      element.id == orderResponse.data!.categoryId);
              String? min = HomeCubit.get(context)
                  .appConfig!
                  .categories![index]
                  .minOrderPrice;

              String? max = HomeCubit.get(context)
                  .appConfig!
                  .categories![index]
                  .maxOrderPrice;

              double? minBalance = min == null ? null : double.parse(min);
              double? maxBalance = max == null ? null : double.parse(max);

              return SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 16.h),
                    const FromStartingAddressTo(),
                    SizedBox(height: 16.h),
                    OrderDataWidget(data: orderResponse),
                    SizedBox(height: 32.h),
                    if (widget.isOfferPrice) ...[
                      Row(
                        children: [
                          MyText(
                            title: AppLocalizations.of(context)!.offerPrice,
                            color: AppColors.GRAY3,
                          ),
                        ],
                      ),
                      SizedBox(height: 25.h),
                      MyContainerShape(
                        paddingHorizontal: 12,
                        paddingVertical: 20,
                        borderRadius: 11,
                        child: Column(
                          children: [
                            if (orderResponse.data!.initialPrice != null)
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  MyText(
                                    title: AppLocalizations.of(context)!
                                        .initialPrice,
                                    fontSize: 14,
                                    color: AppColors.GRAY3,
                                  ),
                                  Row(
                                    children: [
                                      MyText(
                                        title:
                                            orderResponse.data!.initialPrice!,
                                      ),
                                      SizedBox(width: 10.w),
                                      MyText(
                                        title: 'ر.س',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            SizedBox(height: 8.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                MyText(
                                  title:
                                      AppLocalizations.of(context)!.amountValue,
                                  fontSize: 14,
                                  color: AppColors.GRAY3,
                                ),
                                SizedBox(
                                  width: 140.w,
                                  child: MyTextField(
                                    controller: _priceController,
                                    keyboardType: TextInputType.number,
                                    isBorder: true,
                                    borderSide: AppColors.TRANSPARENT,
                                    filledColor: true,
                                    fillColor2: AppColors.WHITE2,
                                    textHint: '',
                                    colorBorder: AppColors.TRANSPARENT,
                                    onTap: () {
                                      _priceController.clear();
                                    },
                                    onChange: (String s) {
                                      const duration =
                                          Duration(milliseconds: 500);
                                      if (searchOnStoppedTyping != null) {
                                        searchOnStoppedTyping!.cancel();
                                      }
                                      searchOnStoppedTyping = Timer(
                                        duration,
                                        () {
                                          if (s.length > 0) {
                                            TotalPriceCubit.get(context)
                                                .addTotalPrice(null);
                                            if (s.length > lengthPrice) {
                                              lengthPrice = s.length;
                                            } else {
                                              TotalPriceCubit.get(context)
                                                  .addTotalPrice(null);
                                            }
                                            TotalPriceCubit.get(context)
                                                .addTotalPrice(double.parse(s));
                                          } else {
                                            TotalPriceCubit.get(context)
                                                .addTotalPrice(null);
                                          }
                                        },
                                      );
                                    },
                                    suffixWidget: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        MyText(
                                          title: 'ر.س',
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            if (minBalance != null && maxBalance != null)
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  MyText(
                                    title:
                                        "${AppLocalizations.of(context)!.note} / ",
                                    fontSize: 14,
                                  ),
                                  Expanded(
                                    child: MyText(
                                        color: AppColors.RED,
                                        fontSize: 14,
                                        title:
                                            "${AppLocalizations.of(context)!.amountEnteredMustBeBetween} $minBalance ${AppLocalizations.of(context)!.and} $maxBalance"),
                                  ), //
                                ],
                              ),
                            SizedBox(height: 8.h),
                            const Divider(height: 1, thickness: 1),
                            BlocBuilder<TotalPriceCubit, TotalPriceState>(
                              builder: (context, state) {
                                commission =
                                    (TotalPriceCubit.get(context).totalPrice *
                                        double.parse(orderResponse.data!.tax!) /
                                        100);
                                if (commission > 0) {
                                  return Column(
                                    children: [
                                      SizedBox(height: 10.h),
                                      _customText(
                                        keyy: AppLocalizations.of(context)!
                                            .commission,
                                        value: '$commission ر.س',
                                      ),
                                      SizedBox(height: 8.h),
                                      const Divider(height: 1, thickness: 1),
                                    ],
                                  );
                                } else {
                                  return const SizedBox();
                                }
                              },
                            ),
                            SizedBox(height: 10.h),
                            BlocBuilder<TotalPriceCubit, TotalPriceState>(
                              builder: (context, state) {
                                tax = (TotalPriceCubit.get(context).totalPrice *
                                    double.parse(HomeCubit.get(context)
                                            .appConfig!
                                            .app!
                                            .tax ??
                                        '0') /
                                    100);
                                if (tax > 0) {
                                  return Column(
                                    children: [
                                      _customText(
                                        keyy: AppLocalizations.of(context)!.tax,
                                        value: '$tax ر.س',
                                      ),
                                      SizedBox(height: 8.h),
                                      const Divider(height: 1, thickness: 1),
                                    ],
                                  );
                                } else {
                                  return const SizedBox();
                                }
                              },
                            ),
                            SizedBox(height: 10.h),
                            BlocBuilder<TotalPriceCubit, TotalPriceState>(
                              builder: (context, state) {
                                total =
                                    TotalPriceCubit.get(context).totalPrice -
                                        // tax +
                                        commission;
                                return _customText(
                                  keyy:
                                      '${AppLocalizations.of(context)!.youWillReceive} (${AppLocalizations.of(context)!.total})',
                                  value: '$total ر.س',
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 12.h),
                      MyCheckBox(
                        onChanged: (bool enabled) {
                          TotalPriceCubit.get(context).changeCash(enabled);
                        },
                        title: AppLocalizations.of(context)!
                            .activateCashPaymentForThisOffer,
                        fontSize: 12,
                      ),
                      SizedBox(height: 10.h),
                      BlocBuilder<TotalPriceCubit, TotalPriceState>(
                        builder: (context, state) {
                          if (TotalPriceCubit.get(context).isCash &&
                              _priceController.text.trim().isNotEmpty) {
                            return Row(
                              children: [
                                SizedBox(width: 10.w),
                                MyText(
                                  title:
                                      '${AppLocalizations.of(context)!.youWillReceiveFromTheCustomer} ${double.parse(_priceController.text.trim()) + tax} ',
                                  color: AppColors.RED,
                                  fontSize: 12,
                                ),
                              ],
                            );
                          } else {
                            return const SizedBox();
                          }
                        },
                      ),
                      SizedBox(height: 32.h),
                      BlocConsumer<WalletCubit, WalletState>(
                        listener: (context, stateWallet) {
                          if (stateWallet is WalletFailed) {
                            AppHelpers.showSnackBar(context,
                                message: stateWallet.message, error: true);
                          }
                          if (stateWallet is WalletSuccess) {
                            double balnce =
                                double.parse(WalletCubit.get(context).balnce);
                            double balnceApi = double.parse(
                                    HomeCubit.get(context)
                                            .appConfig!
                                            .app!
                                            .minAmountCash ??
                                        '0') *
                                -1;

                            if (balnce >= balnceApi) {
                              print('$balnce >= $balnceApi');
                              MyRequestCubit.get(context).mackOffer(
                                context,
                                orderId: int.parse(widget.orderId),
                                price: total,
                                tax: 0,
                                isCash:
                                    TotalPriceCubit.get(context).isCash ? 1 : 0,
                              );
                            } else {
                              AppHelpers.showSnackBar(
                                context,
                                error: true,
                                message:
                                    '${AppLocalizations.of(context)!.youCannotReceiveCashOrdersUntilYourBalanceExceeds} $balnceApi ${AppLocalizations.of(context)!.sr}',
                              );
                            }
                          }
                        },
                        builder: (context, stateWallet) {
                          if (stateWallet is WalletLoading) {
                            return const LoadingWidget();
                          }
                          return BlocConsumer<MyRequestCubit, MyRequestState>(
                            listener: (context, state) {
                              if (state is MackOfferSuccess) {
                                HomeCubit.get(context)
                                    .deleteOrder(orderResponse.data!.id!);
                                AppHelpers.showSnackBar(context,
                                    message: state.message);
                                Navigator.pop(context);
                              }
                              if (state is MackOfferFailed) {
                                AppHelpers.showSnackBar(
                                  context,
                                  message: state.message,
                                  error: true,
                                );
                              }
                            },
                            builder: (context, state) {
                              if (state is MackOfferLoading) {
                                return const LoadingWidget();
                              }

                              return MyElevatedButton(
                                title: AppLocalizations.of(context)!.send,
                                titleColor: AppColors.BLACK,
                                onPressed: () {
                                  double? currentBalance;

                                  try {
                                    if (_priceController.text.isNotEmpty) {
                                      currentBalance = double.parse(
                                          AppHelpers.getNumberEnglish(
                                              _priceController.text.trim()));
                                    }
                                  } catch (ex) {
                                    currentBalance = null;
                                  }
                                  if (_priceController.text.trim().isEmpty) {
                                    AppHelpers.showSnackBar(context,
                                        message: AppLocalizations.of(context)!
                                            .pleaseEnterThePrice,
                                        error: true);
                                    return;
                                  }
                                  if (TotalPriceCubit.get(context).isCash) {
                                    WalletCubit.get(context)
                                        .getTransactions(context);
                                  } else {
                                    if (minBalance == null &&
                                        maxBalance == null) {
                                      makeOffer();
                                    } else if (_priceController.text
                                            .trim()
                                            .isNotEmpty &&
                                        (currentBalance! >= minBalance! &&
                                            currentBalance <= maxBalance!)) {
                                      makeOffer();
                                    }
                                  }
                                },
                              );
                            },
                          );
                        },
                      ),
                      SizedBox(height: 50.h),
                    ],
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void makeOffer() {
    MyRequestCubit.get(context).mackOffer(
      context,
      orderId: int.parse(widget.orderId),
      price: double.parse(_priceController.text.trim()) + tax,
      tax: 0,
      isCash: TotalPriceCubit.get(context).isCash ? 1 : 0,
    );
  }

  Widget _customText({
    required String keyy,
    required String value,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        MyText(
          title: keyy,
          fontSize: 14,
          color: AppColors.GRAY3,
        ),
        MyText(
          title: value,
          fontSize: 14,
          fontWeight: FontWeight.w700,
        ),
      ],
    );
  }
}
