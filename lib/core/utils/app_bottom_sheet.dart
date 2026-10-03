import 'dart:io';
import 'package:easy_plus_service_provider/core/utils/app_dialogs.dart';
import 'package:easy_plus_service_provider/core/utils/app_helpers.dart';
import 'package:easy_plus_service_provider/core/widgets/custom_dropdown_menu2.dart';
import 'package:easy_plus_service_provider/core/widgets/loading_widget.dart';
import 'package:easy_plus_service_provider/core/widgets/my_elevated_button.dart';
import 'package:easy_plus_service_provider/features/main/model/response_app_config.dart';
import 'package:easy_plus_service_provider/features/main/views/manager/home_cubit/home_cubit.dart';
import 'package:easy_plus_service_provider/features/main/views/manager/settings_cubit/settings_cubit.dart';
import 'package:easy_plus_service_provider/features/main/views/manager/wallet_cubit/wallet_cubit.dart';
import 'package:easy_plus_service_provider/features/main/views/widgets/home/item_filter.dart';
import 'package:easy_plus_service_provider/features/main/views/widgets/home/item_service.dart';
import 'package:easy_plus_service_provider/features/main/views/widgets/settings/wallet/item_pay.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:easy_plus_service_provider/core/utils/app_colors.dart';
import 'package:easy_plus_service_provider/core/widgets/my_contianer_shape.dart';
import 'package:easy_plus_service_provider/core/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/my_text_field.dart';

class AppBottomSheet {
  static showFillter(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.WHITE,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(34.r),
        ),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              MyContainerShape(
                marginTop: 10.h,
                marginBottom: 5.h,
                width: 60.w,
                height: 3,
                borderRadius: 10,
                bgContainer: AppColors.GRAY.withOpacity(.5),
              ),
              MyText(
                title: AppLocalizations.of(context)!.filter,
                fontWeight: FontWeight.w700,
              ),
              SizedBox(height: 10.h),
              Align(
                alignment: AlignmentDirectional.centerStart,
                child: MyText(
                  title: AppLocalizations.of(context)!.typeOfRequest,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10.h),
              BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) {
                  if (state is LoadingGetAppConfig) {
                    return LoadingWidget();
                  }

                  int indexSelected =
                      HomeCubit.get(context).indexSelectedService;

                  List<Categories> listCat = [];

                  if (HomeCubit.get(context).appConfig != null) {
                    listCat =
                        HomeCubit.get(context).appConfig!.categories ?? [];
                  }
                  if (listCat.length == 0) {
                    return LoadingWidget();
                  }
                  return Column(
                    children: [
                      Row(
                        children: [
                          ItemService(
                            title: listCat[0].name ?? "",
                            icPath: listCat[0].icon ?? "",
                            // title: AppLocalizations.of(context)!.delivery,
                            // icPath: 'assets/images/ic_service_main/ic_delivery.svg',
                            isSvg: true,
                            isSelected: indexSelected == 0,
                            onTap: () {
                              HomeCubit.get(context).changeSelectedService(0);
                            },
                          ),
                          SizedBox(width: 8.w),
                          ItemService(
                            title: listCat[1].name ?? "",
                            icPath: listCat[1].icon ?? "",
                            // title: AppLocalizations.of(context)!.tour,
                            // icPath:
                            //     'assets/images/ic_service_main/ic_motorcycle.png',
                            isSvg: false,
                            isSelected: indexSelected == 1,
                            onTap: () {
                              HomeCubit.get(context).changeSelectedService(1);
                            },
                          ),
                          SizedBox(width: 8.w),
                          ItemService(
                            title: listCat[2].name ?? "",
                            icPath: listCat[2].icon ?? "",
                            // title: AppLocalizations.of(context)!.shopper,
                            // icPath: 'assets/images/ic_service_main/ic_shopper.png',

                            isSvg: false,
                            isSelected: indexSelected == 2,
                            onTap: () {
                              HomeCubit.get(context).changeSelectedService(2);
                            },
                          ),
                          SizedBox(width: 8.w),
                          ItemService(
                            title: listCat[3].name ?? "",
                            icPath: listCat[3].icon ?? "",
                            // title: AppLocalizations.of(context)!.references,
                            // icPath:
                            //     'assets/images/ic_service_main/ic_references.png',
                            isSvg: false,
                            isSelected: indexSelected == 3,
                            onTap: () {
                              HomeCubit.get(context).changeSelectedService(3);
                            },
                          ),
                          SizedBox(width: 8.w),
                          ItemService(
                            title: listCat[4].name ?? "",
                            icPath: listCat[4].icon ?? "",
                            // title: AppLocalizations.of(context)!.ride,
                            // icPath: 'assets/images/ic_service_main/ic_car.svg',
                            isSvg: true,
                            isSelected: indexSelected == 4,
                            onTap: () {
                              HomeCubit.get(context).changeSelectedService(4);
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 12.h),
                      if (indexSelected == 0)
                        ItemFilter(
                          listOption:
                              HomeCubit.get(context).appConfig!.ordersTypes ??
                                  [],
                          title: AppLocalizations.of(context)!.theTypeRequests,
                          onClickOption: (int index) {
                            HomeCubit.get(context)
                                .changeSelectedDelivery(index);
                          },
                        ),
                      if (indexSelected == 1)
                        ItemFilter(
                          listOption:
                              HomeCubit.get(context).appConfig!.revisionTypes ??
                                  [],
                          title: AppLocalizations.of(context)!.revisionTypes,
                          onClickOption: (int index) {
                            HomeCubit.get(context)
                                .changeSelectedRevision(index);
                          },
                        ),
                      if (indexSelected == 2)
                        ItemFilter(
                          listOption:
                              HomeCubit.get(context).appConfig!.shoppingTypes ??
                                  [],
                          title: AppLocalizations.of(context)!.shoppingType,
                          onClickOption: (int index) {
                            HomeCubit.get(context)
                                .changeSelectedShoppingType(index);
                          },
                        ),
                      if (indexSelected == 3)
                        Column(
                          children: [
                            ItemFilter(
                              listOption:
                                  HomeCubit.get(context).appConfig!.tourTypes ??
                                      [],
                              title:
                                  AppLocalizations.of(context)!.roundCategory,
                              onClickOption: (int index) {
                                HomeCubit.get(context)
                                    .changeSelectedTourCategory(index);
                              },
                            ),
                            SizedBox(height: 12.h),
                            ItemFilter(
                              listOption: HomeCubit.get(context).tourTypes,
                              title: AppLocalizations.of(context)!.tourType,
                              onClickOption: (int index) {
                                HomeCubit.get(context)
                                    .changeSelectedTourType(context, index);
                              },
                            ),
                          ],
                        ),
                      if (indexSelected == 4)
                        Column(
                          children: [
                            ItemFilter(
                              listOption:
                                  HomeCubit.get(context).appConfig!.carTypes ??
                                      [],
                              title: AppLocalizations.of(context)!.vehicleClass,
                              onClickOption: (int index) {
                                HomeCubit.get(context)
                                    .changeSelectedCarTypes(index);
                              },
                            ),
                            SizedBox(height: 12.h),
                            ItemFilter(
                              listOption: HomeCubit.get(context)
                                      .appConfig!
                                      .navRangeTypes ??
                                  [],
                              title:
                                  AppLocalizations.of(context)!.navigationRange,
                              onClickOption: (int index) {
                                HomeCubit.get(context)
                                    .changeSelectedNavigationRange(index);
                              },
                            ),
                            SizedBox(height: 12.h),
                            ItemFilter(
                              listOption:
                                  HomeCubit.get(context).reservationType,
                              title: AppLocalizations.of(context)!.tourType,
                              onClickOption: (int index) {
                                HomeCubit.get(context)
                                    .changeSelectedReservationType(
                                        context, index);
                              },
                            ),
                          ],
                        ),
                      SizedBox(height: 12.h),
                    ],
                  );
                },
              ),
              MyElevatedButton(
                title: AppLocalizations.of(context)!.filtering,
                onPressed: () {
                  HomeCubit.get(context).getHomeData(context);
                  Navigator.pop(context);
                },
                iconPath: Icons.search,
                titleColor: AppColors.BLACK,
              ),
              SizedBox(
                height: MediaQuery.of(context).padding.bottom,
              )
            ],
          ),
        );
      },
    );
  }

  static showbalanceWithdrawal(BuildContext context) {
    final _key = GlobalKey<FormState>();
    TextEditingController _accountName = TextEditingController();
    TextEditingController _accountNumber = TextEditingController();
    TextEditingController _amount = TextEditingController();
    TextEditingController _ibanNumber = TextEditingController();
    double minBalance = double.parse(
        HomeCubit.get(context).appConfig!.app!.minWithdrawal ?? "0");
    double maxBalance = double.parse(
        HomeCubit.get(context).appConfig!.app!.maxWithdrawal ?? "0");
    CustomClass? bank;
    if (HomeCubit.get(context).appConfig!.banks != null) {
      if (HomeCubit.get(context).appConfig!.banks!.isNotEmpty) {
        bank = HomeCubit.get(context).appConfig!.banks![0];
      }
    } else {
      bank = null;
    }
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.WHITE,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(34.r),
        ),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Form(
            key: _key,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                MyContainerShape(
                  marginTop: 10.h,
                  marginBottom: 5.h,
                  width: 60.w,
                  height: 3,
                  borderRadius: 10,
                  bgContainer: AppColors.GRAY.withOpacity(.5),
                ),
                SizedBox(height: 5.h),
                MyText(
                  title: AppLocalizations.of(context)!.balanceWithdrawal,
                  fontWeight: FontWeight.w700,
                ),
                SizedBox(height: 10.h),
                Divider(
                  thickness: 1,
                  height: 1,
                ),
                SizedBox(height: 10.h),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyText(
                      title: "${AppLocalizations.of(context)!.note} / ",
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
                SizedBox(height: 10.h),
                CustomDropdownMenu2(
                  listItems: HomeCubit.get(context).appConfig!.banks!,
                  onChanged: (CustomClass selected) {
                    bank = selected;
                  },
                  height: 48.h,
                  isExpanded: true,
                  alignment: AlignmentDirectional.centerStart,
                ),
                SizedBox(height: 10.h),
                MyTextField(
                  controller: _accountName,
                  textHint: AppLocalizations.of(context)!.accountHoldersName,
                  filledColor: true,
                  isBorder: true,
                  colorBorder: AppColors.WHITE2,
                  validator: (String? s) {
                    if (s == null || s.isEmpty) {
                      return AppLocalizations.of(context)!.pleaseFillFiald;
                    }

                    return null;
                  },
                ),
                SizedBox(height: 14.h),
                MyTextField(
                  controller: _ibanNumber,
                  textHint: AppLocalizations.of(context)!.iBANNumber,
                  keyboardType: TextInputType.number,
                  filledColor: true,
                  isBorder: true,
                  colorBorder: AppColors.WHITE2,
                  validator: (String? s) {
                    if (s == null || s.isEmpty) {
                      return AppLocalizations.of(context)!.pleaseFillFiald;
                    }

                    return null;
                  },
                ),
                SizedBox(height: 14.h),
                MyTextField(
                  controller: _accountNumber,
                  textHint: AppLocalizations.of(context)!.accountNumber,
                  keyboardType: TextInputType.number,
                  filledColor: true,
                  isBorder: true,
                  colorBorder: AppColors.WHITE2,
                  validator: (String? s) {
                    if (s == null || s.isEmpty) {
                      return AppLocalizations.of(context)!.pleaseFillFiald;
                    }

                    return null;
                  },
                ),
                SizedBox(height: 14.h),
                MyTextField(
                  controller: _amount,
                  textHint: AppLocalizations.of(context)!.price,
                  filledColor: true,
                  isBorder: true,
                  keyboardType: TextInputType.number,
                  colorBorder: AppColors.WHITE2,
                  validator: (String? s) {
                    if (s == null || s.isEmpty) {
                      return AppLocalizations.of(context)!.pleaseFillFiald;
                    }

                    return null;
                  },
                ),
                SizedBox(height: 14.h),
                BlocConsumer<SettingsCubit, SettingsState>(
                  listener: (context, state) {
                    if (state is PullRequestLoading) {
                      AppDialogs.showLoadingDialog(context);
                    }
                    if (state is PullRequestSuccess) {
                      _accountName.clear();
                      _accountNumber.clear();
                      _ibanNumber.clear();
                      _amount.clear();
                      AppHelpers.showSnackBar(context, message: state.message);
                      Navigator.pop(context);
                      Navigator.pop(context);
                    }
                    if (state is PullRequestFailed) {
                      AppHelpers.showSnackBar(
                        context,
                        message: state.message,
                        error: true,
                      );
                      Navigator.pop(context);
                      Navigator.pop(context);
                    }
                  },
                  builder: (context, state) {
                    return MyElevatedButton(
                      title: AppLocalizations.of(context)!.confirm,
                      titleColor: AppColors.BLACK,
                      onPressed: () async {
                        double? currentBalance;
                        try {
                          if (_amount.text.isNotEmpty) {
                            currentBalance = double.parse(
                                AppHelpers.getNumberEnglish(
                                    _amount.text.trim()));
                          }
                        } catch (ex) {
                          currentBalance = null;
                        }

                        if (_key.currentState!.validate() &&
                            _amount.text.trim().isNotEmpty &&
                            (currentBalance! >= minBalance &&
                                currentBalance <= maxBalance)) {
                          SettingsCubit.get(context).requestMoney(
                            context,
                            name: _accountName.text,
                            ibanNumber: AppHelpers.getNumberEnglish(
                                _ibanNumber.text.trim()),
                            accountNumber: AppHelpers.getNumberEnglish(
                                _accountNumber.text.trim()),
                            amount: AppHelpers.getNumberEnglish(
                              _amount.text.trim(),
                            ),
                            bankName: bank != null ? bank!.name ?? "" : "",
                          );
                        }
                      },
                    );
                  },
                ),
                SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
                SizedBox(
                  height: MediaQuery.of(context).padding.bottom,
                )
              ],
            ),
          ),
        );
      },
    );
  }

  static showChooseToAddBalance(
    BuildContext context, {
    Function()? onBankClick,
    Function()? onPaymentMethodClick,
    String? title,
    String? icon,
  }) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.WHITE,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(34.r),
        ),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 26.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 10.h),
              MyContainerShape(
                width: 60.w,
                height: 3.h,
                bgContainer: AppColors.GRAY,
              ),
              SizedBox(height: 30.h),
              Row(
                children: [
                  ItemPay(
                    icon: icon ?? 'assets/images/ic_wallet2.svg',
                    title: title ?? AppLocalizations.of(context)!.wallet,
                    fun: onBankClick,
                  ),
                  SizedBox(width: 20.w),
                  ItemPay(
                    icon: 'assets/images/payment-gateway.svg',
                    title: AppLocalizations.of(context)!.paymentGateway,
                    fun: onPaymentMethodClick,
                  ),
                ],
              ),
              SizedBox(height: 50.h),
            ],
          ),
        );
      },
    );
  }

  static showAddBalanceWithBank(
    BuildContext context, {
    required Function(int id, String username, String imagePath) confirm,
  }) {
    TextEditingController usernameController = TextEditingController();
    TextEditingController ibanController = TextEditingController();
    TextEditingController numberController = TextEditingController();
    CustomClass? bank;
    if (HomeCubit.get(context).appConfig!.banks != null) {
      if (HomeCubit.get(context).appConfig!.banks!.isNotEmpty) {
        bank = HomeCubit.get(context).appConfig!.banks![0];
      }
    } else {
      bank = null;
    }

    ibanController.text = bank != null ? bank.iban! : '';
    numberController.text = bank != null ? bank.accountNumber! : '';
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.WHITE,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(34.r),
        ),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 26.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 10.h),
              MyContainerShape(
                width: 60.w,
                height: 3.h,
                bgContainer: AppColors.GRAY,
              ),
              SizedBox(height: 12.h),
              CustomDropdownMenu2(
                listItems: HomeCubit.get(context).appConfig!.banks!,
                onChanged: (CustomClass selected) {
                  bank = selected;
                  ibanController.text = selected.iban ?? "";
                  numberController.text = selected.accountNumber ?? "";
                },
                height: 48.h,
                isExpanded: true,
                alignment: AlignmentDirectional.centerStart,
              ),
              SizedBox(height: 12.h),
              MyTextField(
                controller: numberController,
                labelText: AppLocalizations.of(context)!.accountNumber,
                textHint: '',
                fillColor2: AppColors.GRAY2.withOpacity(.05),
                filledColor: true,
                isBorder: true,
                readOnly: true,
                keyboardType: TextInputType.text,
              ),
              SizedBox(height: 12.h),
              MyTextField(
                controller: ibanController,
                labelText: AppLocalizations.of(context)!.iban,
                textHint: '',
                fillColor2: AppColors.GRAY2.withOpacity(.05),
                filledColor: true,
                isBorder: true,
                readOnly: true,
                keyboardType: TextInputType.text,
              ),
              SizedBox(height: 12.h),
              BlocBuilder<SettingsCubit, SettingsState>(
                builder: (context, state) {
                  return MyContainerShape(
                    height: 48.h,
                    alignment: AlignmentDirectional.centerStart,
                    enableRadius: true,
                    enableBorder: true,
                    paddingVertical: 0,
                    enableShadow: false,
                    bgContainer: AppColors.TRANSPARENT,
                    borderRadius: 10.r,
                    child: SettingsCubit.get(context).pathImage != null
                        ? Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            child: Row(
                              children: [
                                MyText(
                                  title: 'تم ارفاق صورة',
                                ),
                                SizedBox(width: 30.w),
                                Expanded(
                                  child: Image.file(
                                    File(SettingsCubit.get(context).pathImage!),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    SettingsCubit.get(context)
                                        .setBankImage(null);
                                  },
                                  icon: Icon(
                                    Icons.delete,
                                    color: AppColors.RED,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : InkWell(
                            onTap: () {
                              SettingsCubit.get(context).pickImageBank();
                            },
                            child:
                                Center(child: MyText(title: 'قم بإرفاق صورة')),
                          ),
                  );
                },
              ),
              SizedBox(height: 50.h),
              MyElevatedButton(
                title: AppLocalizations.of(context)!.confirm,
                onPressed: () {
                  if (bank != null &&
                      SettingsCubit.get(context).pathImage != null) {
                    confirm(bank!.id!, usernameController.text.trim(),
                        SettingsCubit.get(context).pathImage!);
                  }
                },
              ),
              SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
              SizedBox(height: MediaQuery.of(context).padding.bottom + 20),
            ],
          ),
        );
      },
    );
  }

  static showAddBalanceWithPaymentMethod(
    BuildContext context, {
    required double tax,
    required Function(double price, double paymentPrice) returnPrice,
  }) {
    TextEditingController balanceController = TextEditingController();
    double minBalance =
        double.parse(HomeCubit.get(context).appConfig!.app!.minDeposit ?? "0");
    double maxBalance =
        double.parse(HomeCubit.get(context).appConfig!.app!.maxDeposit ?? "0");

    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.WHITE,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(34.r),
        ),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 26.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 10.h),
              MyContainerShape(
                width: 60.w,
                height: 3.h,
                bgContainer: AppColors.GRAY,
              ),
              SizedBox(height: 30.h),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyText(
                    title: "${AppLocalizations.of(context)!.note} / ",
                    fontSize: 14,
                  ),
                  Expanded(
                    child: MyText(
                        fontSize: 14,
                        color: AppColors.RED,
                        title:
                            "${AppLocalizations.of(context)!.amountEnteredMustBeBetween} $minBalance ${AppLocalizations.of(context)!.and} $maxBalance"),
                  ), //
                ],
              ),
              SizedBox(height: 16.h),
              BlocBuilder<WalletCubit, WalletState>(
                builder: (context, state) {
                  double tax = double.parse(HomeCubit.get(context)
                      .appConfig!
                      .app!
                      .paymentGatewayCommission!);
                  return MyTextField(
                    controller: balanceController,
                    labelText:
                        '${AppLocalizations.of(context)!.youWillGet}${WalletCubit.get(context).total}${AppLocalizations.of(context)!.shippingCommission}${tax.toInt()}%',
                    textHint: '',
                    fillColor2: AppColors.GRAY2.withOpacity(.05),
                    filledColor: true,
                    isBorder: true,
                    keyboardType: TextInputType.number,
                    onChange: (String s) {
                      WalletCubit.get(context).changeTax(
                          tax,
                          s.length == 0
                              ? 0
                              : double.parse(balanceController.text));
                    },
                  );
                },
              ),
              SizedBox(height: 50.h),
              MyElevatedButton(
                title: AppLocalizations.of(context)!.confirm,
                onPressed: () {
                  double? currentBalance;
                  try {
                    if (balanceController.text.isNotEmpty) {
                      currentBalance = double.parse(AppHelpers.getNumberEnglish(
                          balanceController.text.trim()));
                    }
                  } catch (ex) {
                    currentBalance = null;
                  }
                  if (balanceController.text.trim().isNotEmpty &&
                      (currentBalance! >= minBalance &&
                          currentBalance <= maxBalance)) {
                    returnPrice(
                      double.parse(
                        AppHelpers.getNumberEnglish(balanceController.text),
                      ),
                      WalletCubit.get(context).totalPayment,
                    );
                  }
                },
              ),
              SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
              SizedBox(height: MediaQuery.of(context).padding.bottom + 20),
            ],
          ),
        );
      },
    );
  }
}
