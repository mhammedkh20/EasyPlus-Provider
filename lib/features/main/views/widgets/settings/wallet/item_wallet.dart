import 'package:easy_plus_service_provider/core/utils/app_bottom_sheet.dart';
import 'package:easy_plus_service_provider/core/utils/app_colors.dart';
import 'package:easy_plus_service_provider/core/utils/app_dialogs.dart';
import 'package:easy_plus_service_provider/core/utils/app_helpers.dart';
import 'package:easy_plus_service_provider/features/main/views/manager/home_cubit/home_cubit.dart';
import 'package:easy_plus_service_provider/features/main/views/manager/settings_cubit/settings_cubit.dart';
import 'package:easy_plus_service_provider/features/main/views/manager/wallet_cubit/wallet_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/widgets/my_contianer_shape.dart';
import '../../../../../../core/widgets/my_text.dart';

class ItemWallet extends StatelessWidget {
  const ItemWallet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 212.h,
      width: double.infinity,
      child: Stack(
        children: [
          PositionedDirectional(
            top: 0,
            end: 0,
            bottom: 0,
            start: 0,
            child: SvgPicture.asset(
              'assets/images/bg_wallet.svg',
              fit: BoxFit.fill,
            ),
          ),
          PositionedDirectional(
            top: 40.h,
            end: 16.w,
            start: 16.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyText(
                      title: AppLocalizations.of(context)!.walletBalance,
                      fontSize: 15,
                      color: AppColors.WHITE,
                    ),
                    SizedBox(height: 10.h),
                    MyText(
                      title: '${WalletCubit.get(context).balnce} ر.س',
                      fontSize: 25,
                      fontWeight: FontWeight.w400,
                      color: AppColors.WHITE,
                    )
                  ],
                ),
                BlocConsumer<SettingsCubit, SettingsState>(
                  listener: (context, state) {
                    if (state is BalanceLoading) {
                      print('BalanceLoading');
                      AppDialogs.showLoadingDialog(context);
                    }
                    if (state is BalanceFailed) {
                      print('BalanceFailed');
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                      AppHelpers.showSnackBar(
                        context,
                        message: state.message,
                        error: true,
                      );
                    }

                    if (state is BalanceSuccess) {
                      print('BalanceSuccess');

                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                      SettingsCubit.get(context).pathImage = null;
                      WalletCubit.get(context).getTransactions(context);
                      AppHelpers.showSnackBar(
                        context,
                        message: state.message,
                      );
                    }
                  },
                  builder: (context, state) {
                    return MyContainerShape(
                      paddingVertical: 4,
                      paddingHorizontal: 12,
                      borderRadius: 30,
                      enableShadow: false,
                      bgContainer: AppColors.GREEN_LIGHT,
                      child: InkWell(
                        onTap: () {
                          AppBottomSheet.showChooseToAddBalance(
                            context,
                            icon: 'assets/images/ic_banck.svg',
                            title: AppLocalizations.of(context)!.bankTransfer,
                            onBankClick: () async {
                              AppBottomSheet.showAddBalanceWithBank(
                                context,
                                confirm: (id, username, imagePath) {
                                  SettingsCubit.get(context).requestBalance(
                                      context,
                                      image: imagePath,
                                      bankId: id);
                                },
                              );
                            },
                            onPaymentMethodClick: () {
                              double tax = double.parse(HomeCubit.get(context)
                                  .appConfig!
                                  .app!
                                  .paymentGatewayCommission!);
                              AppBottomSheet.showAddBalanceWithPaymentMethod(
                                context,
                                tax: tax,
                                returnPrice:
                                    (double price, double paymentPrice) {
                                  AppHelpers.clickPayment(
                                    context,
                                    amount: price,
                                    paymentPrice: paymentPrice,
                                    minus: false,
                                  );
                                },
                              );
                            },
                          );
                        },
                        child: MyText(
                          title: AppLocalizations.of(context)!.addCredit,
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
