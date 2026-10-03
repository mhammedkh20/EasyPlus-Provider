// ignore_for_file: must_be_immutable

import 'dart:math';
import 'package:easy_plus_service_provider/core/storage/pref/shared_pref_controller.dart';
import 'package:easy_plus_service_provider/core/utils/app_helpers.dart';
import 'package:easy_plus_service_provider/core/widgets/loading_widget.dart';
import 'package:easy_plus_service_provider/core/widgets/my_check_box.dart';
import 'package:easy_plus_service_provider/core/widgets/my_contianer_shape.dart';
import 'package:easy_plus_service_provider/core/widgets/my_elevated_button.dart';
import 'package:easy_plus_service_provider/core/widgets/my_text.dart';
import 'package:easy_plus_service_provider/features/main/model/response_app_config.dart';
import 'package:easy_plus_service_provider/features/main/views/manager/settings_cubit/settings_cubit.dart';
import 'package:easy_plus_service_provider/features/main/views/pages/main_screen.dart';
import 'package:easy_plus_service_provider/features/main/views/widgets/home/item_service2.dart';
import 'package:easy_plus_service_provider/features/main/views/widgets/settings/icon_navigation_range.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:easy_plus_service_provider/core/utils/app_colors.dart';
import 'package:easy_plus_service_provider/core/widgets/my_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';

import '../../../manager/home_cubit/home_cubit.dart';

class MyServiceScreen extends StatelessWidget {
  int idNavigationRangeType = 0;
  int idDeliveryType = 0;
  int idReviewType = 0;
  int idShopperType = 0;
  int idCarType = 0;
  int indexSelectedGender = 0;
  int idRideType = 0;
  int idTourType = 0;
  int indexSelectedTourType = 0;

  MyServiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.BG_SCAFOLLD,
      appBar: MyAppBar(
        backgroundColor: AppColors.BG_SCAFOLLD,
        title: AppLocalizations.of(context)!.myServices,
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        children: [
          SizedBox(height: 16.h),
          MyText(
            title: AppLocalizations.of(context)!.descMyService,
          ),
          SizedBox(height: 20.h),
          BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              if (HomeCubit.get(context).isloadingConfig) {
                return LoadingWidget();
              }
              if (state is FailedGetAppConfig) {
                return Center(
                  child: LottieBuilder.asset(
                    'assets/images/ic_json/faild.json',
                  ),
                );
              }
              ResponseAppConfig? config = HomeCubit.get(context).appConfig;
              return BlocBuilder<SettingsCubit, SettingsState>(
                builder: (context, state) {
                  int indexSelectedNavRange =
                      SettingsCubit.get(context).indexTypeNavigationRange2;
                  idNavigationRangeType = HomeCubit.get(context)
                      .appConfig!
                      .navRangeTypes![indexSelectedNavRange]
                      .id!;

                  int indexSelectedOrderType =
                      SettingsCubit.get(context).indexRequestCategory;
                  bool statusExpanded =
                      SettingsCubit.get(context).isExpandedRequestCategory;

                  idDeliveryType = HomeCubit.get(context)
                      .appConfig!
                      .ordersTypes![indexSelectedOrderType]
                      .id!;

                  int indexSelectedReview =
                      SettingsCubit.get(context).indexReviewType;

                  idReviewType = HomeCubit.get(context)
                      .appConfig!
                      .revisionTypes![indexSelectedReview]
                      .id!;
                  bool statusExpandedReview =
                      SettingsCubit.get(context).isExpandedReviewType;
                  int indexSelectedShoppingType =
                      SettingsCubit.get(context).indexShoppingType;

                  idShopperType = HomeCubit.get(context)
                      .appConfig!
                      .shoppingTypes![indexSelectedShoppingType]
                      .id!;

                  bool statusExpandedShopper =
                      SettingsCubit.get(context).isExpandedShoppingType;
                  int indexSelectedCarType =
                      SettingsCubit.get(context).indexVehicleClass2;
                  bool statusExpandedCarType =
                      SettingsCubit.get(context).isExpandedVehicleClass;

                  idCarType = HomeCubit.get(context)
                      .appConfig!
                      .carTypes![indexSelectedCarType]
                      .id!;
                  indexSelectedGender =
                      SettingsCubit.get(context).indexDriversGender;

                  int indexSelectedMishwarType =
                      SettingsCubit.get(context).indexTypeOfRide;
                  idRideType = HomeCubit.get(context)
                      .appConfig!
                      .mishwarTypes![indexSelectedMishwarType]
                      .id!;
                  indexSelectedTourType =
                      SettingsCubit.get(context).indexTourType;

                  int indexSelectedRoundCategory =
                      SettingsCubit.get(context).indexRoundCategory;
                  bool statusExpandedTourType =
                      SettingsCubit.get(context).isExpandedTourType;
                  idTourType = HomeCubit.get(context)
                      .appConfig!
                      .tourTypes![indexSelectedRoundCategory]
                      .id!;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ItemService2(
                        title: config!.categories![0].name ?? "",
                        icPath: config.categories![0].icon!,
                        isSvg: true,
                        isSelected: config.categories![0].isSelected!,
                        showCheck: true,
                        background: AppColors.WHITE,
                        onTap: () {
                          if (config.categories![0].isSelected!) {
                            SettingsCubit.get(context)
                                .listIdCat
                                .remove(config.categories![0].id);
                          } else {
                            SettingsCubit.get(context)
                                .listIdCat
                                .add(config.categories![0].id!);
                          }
                          SettingsCubit.get(context).changeSelectedCat(
                              context, config.categories![0].id!);
                        },
                      ),
                      if (config.categories![0].isSelected!)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 8.h),
                            MyText(
                              title:
                                  AppLocalizations.of(context)!.navigationRange,
                              color: AppColors.GRAY3,
                            ),
                            SizedBox(height: 10.h),
                            SizedBox(
                              height: 40.h,
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: HomeCubit.get(context)
                                      .appConfig!
                                      .navRangeTypes!
                                      .length,
                                  itemBuilder: (context, index) {
                                    return Row(
                                      children: [
                                        IconNavigationRange(
                                          width: 100,
                                          isSelected:
                                              indexSelectedNavRange == index,
                                          title: HomeCubit.get(context)
                                                  .appConfig!
                                                  .navRangeTypes![index]
                                                  .name ??
                                              "",
                                          onTap: () {
                                            SettingsCubit.get(context)
                                                .changeTypeNavigationRange2(
                                                    index);
                                          },
                                        ),
                                        SizedBox(width: 16.w),
                                      ],
                                    );
                                  }),
                            ),
                            SizedBox(height: 10.h),
                            MyContainerShape(
                              bgContainer: AppColors.WHITE,
                              paddingHorizontal: 0,
                              paddingVertical: 0,
                              enableShadow: false,
                              borderRadius: 11,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 0.w, vertical: 10.h),
                                    child: Row(
                                      children: [
                                        SvgPicture.asset(
                                          'assets/images/ic_product.svg',
                                          width: 16.r,
                                        ),
                                        SizedBox(width: 8.w),
                                        MyText(
                                          title: AppLocalizations.of(context)!
                                              .requestCategory,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.ICON_COLOR,
                                        ),
                                        const Spacer(),
                                        IconButton(
                                          constraints: const BoxConstraints(),
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 4.r, vertical: 4.r),
                                          splashColor: AppColors.TRANSPARENT,
                                          onPressed: () {
                                            SettingsCubit.get(context)
                                                .changeIsExpandedRequestCategory(
                                                    !statusExpanded);
                                          },
                                          icon: Transform.rotate(
                                            angle: statusExpanded
                                                ? pi * (0 / 4)
                                                : pi * (4 / 4),
                                            child: SvgPicture.asset(
                                              'assets/images/arrows/ic_arrow_up.svg',
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Divider(
                                    height: 1,
                                    thickness: 1,
                                    color: AppColors.ICON_COLOR.withOpacity(.3),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsetsDirectional.only(start: 20.w),
                                    child: AnimatedSize(
                                      duration:
                                          const Duration(milliseconds: 300),
                                      child: SizedBox(
                                        height: statusExpanded ? null : 0,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            SizedBox(height: 12.h),
                                            if (SettingsCubit.get(context)
                                                    .indexTypeNavigationRange2 ==
                                                0)
                                              ListView.builder(
                                                padding: EdgeInsets.zero,
                                                physics:
                                                    const NeverScrollableScrollPhysics(),
                                                shrinkWrap: true,
                                                itemCount:
                                                    HomeCubit.get(context)
                                                        .appConfig!
                                                        .ordersTypes!
                                                        .length,
                                                itemBuilder: (context, index) {
                                                  String? navRang =
                                                      HomeCubit.get(context)
                                                          .appConfig!
                                                          .ordersTypes![index]
                                                          .navRange;
                                                  if (navRang != null) {
                                                    if (navRang.contains(
                                                            'داخلي') ||
                                                        navRang.contains(
                                                            'domestic')) {
                                                      return Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                bottom: 8.h),
                                                        child: MyCheckBox(
                                                          notify: true,
                                                          initValue:
                                                              HomeCubit.get(
                                                                      context)
                                                                  .appConfig!
                                                                  .ordersTypes![
                                                                      index]
                                                                  .isSelected,
                                                          title: HomeCubit.get(
                                                                      context)
                                                                  .appConfig!
                                                                  .ordersTypes![
                                                                      index]
                                                                  .name ??
                                                              "",
                                                          onChanged:
                                                              (bool? enabled) {
                                                            if (enabled !=
                                                                null) {
                                                              SettingsCubit.get(
                                                                      context)
                                                                  .changeSubCategory(
                                                                      context,
                                                                      0,
                                                                      HomeCubit.get(
                                                                              context)
                                                                          .appConfig!
                                                                          .ordersTypes![
                                                                              index]
                                                                          .id!);
                                                              //!here
                                                            }
                                                          },
                                                        ),
                                                      );
                                                    } else {
                                                      return SizedBox();
                                                    }
                                                  } else {
                                                    return SizedBox();
                                                  }
                                                },
                                              ),
                                            if (SettingsCubit.get(context)
                                                    .indexTypeNavigationRange2 ==
                                                1)
                                              ListView.builder(
                                                padding: EdgeInsets.zero,
                                                physics:
                                                    const NeverScrollableScrollPhysics(),
                                                shrinkWrap: true,
                                                itemCount:
                                                    HomeCubit.get(context)
                                                        .appConfig!
                                                        .ordersTypes!
                                                        .length,
                                                itemBuilder: (context, index) {
                                                  String? navRang =
                                                      HomeCubit.get(context)
                                                          .appConfig!
                                                          .ordersTypes![index]
                                                          .navRange;
                                                  if (navRang != null) {
                                                    if (navRang.contains(
                                                            'بين المدن') ||
                                                        navRang.contains(
                                                            'intercity')) {
                                                      return Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                bottom: 8.h),
                                                        child: MyCheckBox(
                                                          notify: true,
                                                          initValue:
                                                              HomeCubit.get(
                                                                      context)
                                                                  .appConfig!
                                                                  .ordersTypes![
                                                                      index]
                                                                  .isSelected,
                                                          title: HomeCubit.get(
                                                                      context)
                                                                  .appConfig!
                                                                  .ordersTypes![
                                                                      index]
                                                                  .name ??
                                                              "",
                                                          onChanged:
                                                              (bool? enabled) {
                                                            if (enabled !=
                                                                null) {
                                                              SettingsCubit.get(
                                                                      context)
                                                                  .changeSubCategory(
                                                                      context,
                                                                      0,
                                                                      HomeCubit.get(
                                                                              context)
                                                                          .appConfig!
                                                                          .ordersTypes![
                                                                              index]
                                                                          .id!);
                                                              //!here
                                                            }
                                                          },
                                                        ),
                                                      );
                                                    } else {
                                                      return SizedBox();
                                                    }
                                                  } else {
                                                    return SizedBox();
                                                  }
                                                },
                                              ),
                                            if (SettingsCubit.get(context)
                                                    .indexTypeNavigationRange2 ==
                                                2)
                                              ListView.builder(
                                                padding: EdgeInsets.zero,
                                                physics:
                                                    const NeverScrollableScrollPhysics(),
                                                shrinkWrap: true,
                                                itemCount:
                                                    HomeCubit.get(context)
                                                        .appConfig!
                                                        .ordersTypes!
                                                        .length,
                                                itemBuilder: (context, index) {
                                                  String? navRang =
                                                      HomeCubit.get(context)
                                                          .appConfig!
                                                          .ordersTypes![index]
                                                          .navRange;
                                                  if (navRang != null) {
                                                    if (navRang
                                                            .contains('دولي') ||
                                                        navRang.contains(
                                                            'international')) {
                                                      return Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                bottom: 8.h),
                                                        child: MyCheckBox(
                                                          notify: true,
                                                          initValue:
                                                              HomeCubit.get(
                                                                      context)
                                                                  .appConfig!
                                                                  .ordersTypes![
                                                                      index]
                                                                  .isSelected,
                                                          title: HomeCubit.get(
                                                                      context)
                                                                  .appConfig!
                                                                  .ordersTypes![
                                                                      index]
                                                                  .name ??
                                                              "",
                                                          onChanged:
                                                              (bool? enabled) {
                                                            if (enabled !=
                                                                null) {
                                                              SettingsCubit.get(
                                                                      context)
                                                                  .changeSubCategory(
                                                                      context,
                                                                      0,
                                                                      HomeCubit.get(
                                                                              context)
                                                                          .appConfig!
                                                                          .ordersTypes![
                                                                              index]
                                                                          .id!);
                                                              //!here
                                                            }
                                                          },
                                                        ),
                                                      );
                                                    } else {
                                                      return SizedBox();
                                                    }
                                                  } else {
                                                    return SizedBox();
                                                  }
                                                },
                                              ),
                                            SizedBox(height: 14.h),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      SizedBox(height: 16.h),
                      ItemService2(
                        title: config.categories![1].name ?? "",
                        icPath: config.categories![1].icon!,
                        background: AppColors.WHITE,
                        showCheck: true,
                        isSvg: false,
                        isSelected: config.categories![1].isSelected!,
                        onTap: () {
                          if (config.categories![1].isSelected!) {
                            SettingsCubit.get(context)
                                .listIdCat
                                .remove(config.categories![1].id);
                          } else {
                            SettingsCubit.get(context)
                                .listIdCat
                                .add(config.categories![1].id!);
                          }
                          SettingsCubit.get(context).changeSelectedCat(
                              context, config.categories![1].id!);
                        },
                      ),
                      if (config.categories![1].isSelected!) ...[
                        SizedBox(height: 8.h),
                        MyContainerShape(
                          bgContainer: AppColors.WHITE,
                          paddingHorizontal: 0,
                          paddingVertical: 0,
                          enableShadow: false,
                          borderRadius: 11,
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 12.w, vertical: 10.h),
                                child: Row(
                                  children: [
                                    SvgPicture.asset(
                                      'assets/images/ic_luggage.svg',
                                      width: 16.r,
                                    ),
                                    SizedBox(width: 8.w),
                                    MyText(
                                      title: AppLocalizations.of(context)!
                                          .reviewType,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.ICON_COLOR,
                                    ),
                                    const Spacer(),
                                    IconButton(
                                      constraints: const BoxConstraints(),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 4.r, vertical: 4.r),
                                      splashColor: AppColors.TRANSPARENT,
                                      onPressed: () {
                                        SettingsCubit.get(context)
                                            .changeIsExpandedReviewType(
                                                !statusExpandedReview);
                                      },
                                      icon: Transform.rotate(
                                        angle: statusExpandedReview
                                            ? pi * (0 / 4)
                                            : pi * (4 / 4),
                                        child: SvgPicture.asset(
                                          'assets/images/arrows/ic_arrow_up.svg',
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Divider(
                                height: 1,
                                thickness: 1,
                                color: AppColors.ICON_COLOR.withOpacity(.3),
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.only(start: 35.w),
                                child: AnimatedSize(
                                  duration: const Duration(milliseconds: 300),
                                  child: SizedBox(
                                    height: statusExpandedReview ? null : 0,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        SizedBox(height: 12.h),
                                        ListView.builder(
                                          padding: EdgeInsets.zero,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: HomeCubit.get(context)
                                              .appConfig!
                                              .revisionTypes!
                                              .length,
                                          itemBuilder: (context, index) {
                                            return Padding(
                                              padding:
                                                  EdgeInsets.only(bottom: 8.h),
                                              child: MyCheckBox(
                                                notify: true,
                                                initValue:
                                                    HomeCubit.get(context)
                                                        .appConfig!
                                                        .revisionTypes![index]
                                                        .isSelected,
                                                title: HomeCubit.get(context)
                                                        .appConfig!
                                                        .revisionTypes![index]
                                                        .name ??
                                                    "",
                                                onChanged: (bool? enabled) {
                                                  if (enabled != null) {
                                                    SettingsCubit.get(context)
                                                        .changeSubCategory(
                                                            context,
                                                            1,
                                                            HomeCubit.get(
                                                                    context)
                                                                .appConfig!
                                                                .revisionTypes![
                                                                    index]
                                                                .id!);
                                                    //!here
                                                  }
                                                },
                                              ),
                                            );
                                          },
                                        ),
                                        SizedBox(height: 14.h),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                      SizedBox(height: 16.h),
                      ItemService2(
                        title: config.categories![2].name ?? "",
                        icPath: config.categories![2].icon!,
                        background: AppColors.WHITE,
                        showCheck: true,
                        isSvg: false,
                        isSelected: config.categories![2].isSelected!,
                        onTap: () {
                          if (config.categories![2].isSelected!) {
                            SettingsCubit.get(context)
                                .listIdCat
                                .remove(config.categories![2].id);
                          } else {
                            SettingsCubit.get(context)
                                .listIdCat
                                .add(config.categories![2].id!);
                          }
                          SettingsCubit.get(context).changeSelectedCat(
                              context, config.categories![2].id!);
                        },
                      ),
                      if (config.categories![2].isSelected!) ...[
                        SizedBox(height: 8.h),
                        MyContainerShape(
                          bgContainer: AppColors.WHITE,
                          paddingHorizontal: 0,
                          paddingVertical: 0,
                          enableShadow: false,
                          borderRadius: 11,
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 12.w, vertical: 10.h),
                                child: Row(
                                  children: [
                                    SvgPicture.asset(
                                      'assets/images/ic_basket.svg',
                                      width: 16.r,
                                    ),
                                    SizedBox(width: 8.w),
                                    MyText(
                                      title: AppLocalizations.of(context)!
                                          .shoppingType,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.ICON_COLOR,
                                    ),
                                    const Spacer(),
                                    IconButton(
                                      constraints: const BoxConstraints(),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 4.r, vertical: 4.r),
                                      splashColor: AppColors.TRANSPARENT,
                                      onPressed: () {
                                        print('$statusExpandedShopper');
                                        SettingsCubit.get(context)
                                            .changeIsExpandedShoppingType(
                                                !statusExpandedShopper);
                                      },
                                      icon: Transform.rotate(
                                        angle: statusExpandedShopper
                                            ? pi * (0 / 4)
                                            : pi * (4 / 4),
                                        child: SvgPicture.asset(
                                          'assets/images/arrows/ic_arrow_up.svg',
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Divider(
                                height: 1,
                                thickness: 1,
                                color: AppColors.ICON_COLOR.withOpacity(.3),
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.only(start: 35.w),
                                child: AnimatedSize(
                                  duration: const Duration(milliseconds: 300),
                                  child: SizedBox(
                                    height: statusExpandedShopper ? null : 0,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        SizedBox(height: 12.h),
                                        ListView.builder(
                                          padding: EdgeInsets.zero,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: HomeCubit.get(context)
                                              .appConfig!
                                              .shoppingTypes!
                                              .length,
                                          itemBuilder: (context, index) {
                                            return Padding(
                                              padding:
                                                  EdgeInsets.only(bottom: 8.h),
                                              child: MyCheckBox(
                                                notify: true,
                                                initValue:
                                                    HomeCubit.get(context)
                                                        .appConfig!
                                                        .shoppingTypes![index]
                                                        .isSelected,
                                                title: HomeCubit.get(context)
                                                        .appConfig!
                                                        .shoppingTypes![index]
                                                        .name ??
                                                    "",
                                                onChanged: (bool? enabled) {
                                                  if (enabled != null) {
                                                    SettingsCubit.get(context)
                                                        .changeSubCategory(
                                                            context,
                                                            2,
                                                            HomeCubit.get(
                                                                    context)
                                                                .appConfig!
                                                                .shoppingTypes![
                                                                    index]
                                                                .id!);
                                                    //!here
                                                  }
                                                },
                                              ),
                                            );
                                          },
                                        ),
                                        SizedBox(height: 14.h),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                      SizedBox(height: 16.h),
                      ItemService2(
                        title: config.categories![3].name ?? "",
                        icPath: config.categories![3].icon!,
                        showCheck: true,
                        isSvg: false,
                        isSelected: config.categories![3].isSelected!,
                        onTap: () {
                          if (config.categories![3].isSelected!) {
                            SettingsCubit.get(context)
                                .listIdCat
                                .remove(config.categories![3].id);
                          } else {
                            SettingsCubit.get(context)
                                .listIdCat
                                .add(config.categories![3].id!);
                          }
                          SettingsCubit.get(context).changeSelectedCat(
                              context, config.categories![3].id!);
                        },
                        background: AppColors.WHITE,
                      ),
                      if (config.categories![3].isSelected!) ...[
                        SizedBox(height: 16.h),
                        MyText(
                          title: AppLocalizations.of(context)!.tourType,
                          color: AppColors.GRAY3,
                        ),
                        SizedBox(height: 16.h),
                        Row(
                          children: [
                            IconNavigationRange(
                              isSelected: indexSelectedTourType == 0,
                              title: AppLocalizations.of(context)!
                                  .entertainmentTour,
                              width: 150,
                              onTap: () {
                                SettingsCubit.get(context).changeTourType(0);
                              },
                            ),
                            SizedBox(width: 16.w),
                            IconNavigationRange(
                              isSelected: indexSelectedTourType == 1,
                              width: 150,
                              title: AppLocalizations.of(context)!.trainingTour,
                              onTap: () {
                                SettingsCubit.get(context).changeTourType(1);
                              },
                            ),
                          ],
                        ),
                        SizedBox(height: 8.h),
                        MyContainerShape(
                          bgContainer: AppColors.WHITE,
                          paddingHorizontal: 0,
                          paddingVertical: 0,
                          enableShadow: false,
                          borderRadius: 11,
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 12.w, vertical: 10.h),
                                child: Row(
                                  children: [
                                    SvgPicture.asset(
                                      'assets/images/ic_motorcycle.svg',
                                      width: 16.r,
                                    ),
                                    SizedBox(width: 8.w),
                                    MyText(
                                      title: AppLocalizations.of(context)!
                                          .roundCategory,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.ICON_COLOR,
                                    ),
                                    const Spacer(),
                                    IconButton(
                                      constraints: const BoxConstraints(),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 4.r, vertical: 4.r),
                                      splashColor: AppColors.TRANSPARENT,
                                      onPressed: () {
                                        SettingsCubit.get(context)
                                            .changeIsExpandedTourType(
                                                !statusExpandedTourType);
                                      },
                                      icon: Transform.rotate(
                                        angle: statusExpandedTourType
                                            ? pi * (4 / 4)
                                            : pi * (0 / 4),
                                        child: SvgPicture.asset(
                                          'assets/images/arrows/ic_arrow_up.svg',
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Divider(
                                height: 1,
                                thickness: 1,
                                color: AppColors.ICON_COLOR.withOpacity(.3),
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.only(start: 35.w),
                                child: AnimatedSize(
                                  duration: const Duration(milliseconds: 300),
                                  child: SizedBox(
                                    height: statusExpandedTourType ? null : 0,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        SizedBox(height: 12.h),
                                        if (SettingsCubit.get(context)
                                                .indexTourType ==
                                            0)
                                          ListView.builder(
                                            padding: EdgeInsets.zero,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            itemCount: HomeCubit.get(context)
                                                .appConfig!
                                                .tourTypes!
                                                .length,
                                            itemBuilder: (context, index) {
                                              String? navRang =
                                                  HomeCubit.get(context)
                                                      .appConfig!
                                                      .tourTypes![index]
                                                      .type;
                                              print(navRang);

                                              if (navRang != null) {
                                                if (navRang ==
                                                    'entertainment') {
                                                  return Padding(
                                                    padding: EdgeInsets.only(
                                                        bottom: 8.h),
                                                    child: MyCheckBox(
                                                      notify: true,
                                                      initValue:
                                                          HomeCubit.get(context)
                                                              .appConfig!
                                                              .tourTypes![index]
                                                              .isSelected,
                                                      title: HomeCubit.get(
                                                                  context)
                                                              .appConfig!
                                                              .tourTypes![index]
                                                              .name ??
                                                          "",
                                                      onChanged:
                                                          (bool? enabled) {
                                                        if (enabled != null) {
                                                          SettingsCubit.get(
                                                                  context)
                                                              .changeSubCategory(
                                                                  context,
                                                                  3,
                                                                  HomeCubit.get(
                                                                          context)
                                                                      .appConfig!
                                                                      .tourTypes![
                                                                          index]
                                                                      .id!);
                                                          //!here
                                                        }
                                                      },
                                                    ),
                                                  );
                                                } else {
                                                  return SizedBox();
                                                }
                                              } else {
                                                return SizedBox();
                                              }
                                            },
                                          ),
                                        if (SettingsCubit.get(context)
                                                .indexTourType ==
                                            1)
                                          ListView.builder(
                                            padding: EdgeInsets.zero,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            itemCount: HomeCubit.get(context)
                                                .appConfig!
                                                .tourTypes!
                                                .length,
                                            itemBuilder: (context, index) {
                                              String? navRang =
                                                  HomeCubit.get(context)
                                                      .appConfig!
                                                      .tourTypes![index]
                                                      .type;
                                              print(navRang);
                                              if (navRang != null) {
                                                if (navRang == 'training') {
                                                  return Padding(
                                                    padding: EdgeInsets.only(
                                                        bottom: 8.h),
                                                    child: MyCheckBox(
                                                      notify: true,
                                                      initValue:
                                                          HomeCubit.get(context)
                                                              .appConfig!
                                                              .tourTypes![index]
                                                              .isSelected,
                                                      title: HomeCubit.get(
                                                                  context)
                                                              .appConfig!
                                                              .tourTypes![index]
                                                              .name ??
                                                          "",
                                                      onChanged:
                                                          (bool? enabled) {
                                                        if (enabled != null) {
                                                          SettingsCubit.get(
                                                                  context)
                                                              .changeSubCategory(
                                                                  context,
                                                                  3,
                                                                  HomeCubit.get(
                                                                          context)
                                                                      .appConfig!
                                                                      .tourTypes![
                                                                          index]
                                                                      .id!);
                                                          //!here
                                                        }
                                                      },
                                                    ),
                                                  );
                                                } else {
                                                  return SizedBox();
                                                }
                                              } else {
                                                return SizedBox();
                                              }
                                            },
                                          ),

                                        // ListView.builder(
                                        //   padding: EdgeInsets.zero,
                                        //   physics:
                                        //       const NeverScrollableScrollPhysics(),
                                        //   shrinkWrap: true,
                                        //   itemCount: HomeCubit.get(context)
                                        //       .appConfig!
                                        //       .tourTypes!
                                        //       .length,
                                        //   itemBuilder: (context, index) {
                                        //     return Padding(
                                        //       padding:
                                        //           EdgeInsets.only(bottom: 8.h),
                                        //       child: MyCheckBox(
                                        //         notify: true,
                                        //         initValue:
                                        //             HomeCubit.get(context)
                                        //                 .appConfig!
                                        //                 .tourTypes![index]
                                        //                 .isSelected,
                                        //         title: HomeCubit.get(context)
                                        //                 .appConfig!
                                        //                 .tourTypes![index]
                                        //                 .name ??
                                        //             "",
                                        //         onChanged: (bool? enabled) {
                                        //           if (enabled != null) {
                                        //             SettingsCubit.get(context)
                                        //                 .changeSubCategory(
                                        //                     context,
                                        //                     3,
                                        //                     HomeCubit.get(
                                        //                             context)
                                        //                         .appConfig!
                                        //                         .tourTypes![
                                        //                             index]
                                        //                         .id!);
                                        //             //!here
                                        //           }
                                        //         },
                                        //       ),
                                        //     );
                                        //   },
                                        // ),

                                        SizedBox(height: 14.h),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10.h),
                      ],
                      SizedBox(height: 16.h),
                      ItemService2(
                        title: config.categories![4].name ?? "",
                        icPath: config.categories![4].icon!,
                        background: AppColors.WHITE,
                        showCheck: true,
                        isSvg: true,
                        isSelected: config.categories![4].isSelected!,
                        onTap: () {
                          if (config.categories![4].isSelected!) {
                            SettingsCubit.get(context)
                                .listIdCat
                                .remove(config.categories![4].id);
                          } else {
                            SettingsCubit.get(context)
                                .listIdCat
                                .add(config.categories![4].id!);
                          }
                          SettingsCubit.get(context).changeSelectedCat(
                              context, config.categories![4].id!);
                        },
                      ),
                      if (config.categories![4].isSelected!) ...[
                        SizedBox(height: 8.h),
                        MyContainerShape(
                          bgContainer: AppColors.WHITE,
                          paddingHorizontal: 0,
                          paddingVertical: 0,
                          enableShadow: false,
                          borderRadius: 11,
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 12.w, vertical: 10.h),
                                child: Row(
                                  children: [
                                    SvgPicture.asset(
                                      'assets/images/ic_car.svg',
                                      width: 16.r,
                                    ),
                                    SizedBox(width: 8.w),
                                    MyText(
                                      title: AppLocalizations.of(context)!
                                          .vehicleClass,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.ICON_COLOR,
                                    ),
                                    const Spacer(),
                                    IconButton(
                                      constraints: const BoxConstraints(),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 4.r, vertical: 4.r),
                                      splashColor: AppColors.TRANSPARENT,
                                      onPressed: () {
                                        SettingsCubit.get(context)
                                            .changeIsExpandedVehicleClass(
                                                !statusExpandedCarType);
                                      },
                                      icon: Transform.rotate(
                                        angle: statusExpandedCarType
                                            ? pi * (0 / 4)
                                            : pi * (4 / 4),
                                        child: SvgPicture.asset(
                                          'assets/images/arrows/ic_arrow_up.svg',
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Divider(
                                height: 1,
                                thickness: 1,
                                color: AppColors.ICON_COLOR.withOpacity(.3),
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.only(start: 35.w),
                                child: AnimatedSize(
                                  duration: const Duration(milliseconds: 300),
                                  child: SizedBox(
                                    height: statusExpandedCarType ? null : 0,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        SizedBox(height: 12.h),
                                        ListView.builder(
                                          padding: EdgeInsets.zero,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: HomeCubit.get(context)
                                              .appConfig!
                                              .carTypes!
                                              .length,
                                          itemBuilder: (context, index) {
                                            return Padding(
                                              padding:
                                                  EdgeInsets.only(bottom: 8.h),
                                              child: MyCheckBox(
                                                notify: true,
                                                initValue:
                                                    HomeCubit.get(context)
                                                        .appConfig!
                                                        .carTypes![index]
                                                        .isSelected,
                                                title: HomeCubit.get(context)
                                                        .appConfig!
                                                        .carTypes![index]
                                                        .name ??
                                                    "",
                                                onChanged: (bool? enabled) {
                                                  if (enabled != null) {
                                                    SettingsCubit.get(context)
                                                        .changeSubCategory(
                                                            context,
                                                            4,
                                                            HomeCubit.get(
                                                                    context)
                                                                .appConfig!
                                                                .carTypes![
                                                                    index]
                                                                .id!);
                                                    //!here
                                                  }
                                                },
                                              ),
                                            );
                                          },
                                        ),
                                        SizedBox(height: 14.h),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 12.h),
                        MyText(
                          title: AppLocalizations.of(context)!.navigationRange,
                          color: AppColors.GRAY3,
                        ),
                        SizedBox(height: 12.h),
                        SizedBox(
                          height: 40.h,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: HomeCubit.get(context)
                                  .appConfig!
                                  .navRangeTypes!
                                  .length,
                              itemBuilder: (context, index) {
                                return Row(
                                  children: [
                                    IconNavigationRange(
                                      width: 100,
                                      isSelected: HomeCubit.get(context)
                                          .appConfig!
                                          .navRangeTypes![index]
                                          .isSelected!,
                                      title: HomeCubit.get(context)
                                              .appConfig!
                                              .navRangeTypes![index]
                                              .name ??
                                          "",
                                      onTap: () {
                                        SettingsCubit.get(context)
                                            .selectNavRange(
                                                context,
                                                HomeCubit.get(context)
                                                    .appConfig!
                                                    .navRangeTypes![index]
                                                    .id!);
                                      },
                                    ),
                                    SizedBox(width: 16.w),
                                  ],
                                );
                              }),
                        ),
                        SizedBox(height: 12.h),
                        MyText(
                          title: AppLocalizations.of(context)!.typeOfRide,
                          color: AppColors.GRAY3,
                        ),
                        SizedBox(height: 12.h),
                        SizedBox(
                          height: 40.h,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: HomeCubit.get(context)
                                  .appConfig!
                                  .mishwarTypes!
                                  .length,
                              itemBuilder: (context, index) {
                                return Row(
                                  children: [
                                    IconNavigationRange(
                                      width: 100,
                                      isSelected: HomeCubit.get(context)
                                          .appConfig!
                                          .mishwarTypes![index]
                                          .isSelected!,
                                      title: HomeCubit.get(context)
                                              .appConfig!
                                              .mishwarTypes![index]
                                              .name ??
                                          "",
                                      onTap: () {
                                        SettingsCubit.get(context)
                                            .selectMashuar(
                                                context,
                                                HomeCubit.get(context)
                                                    .appConfig!
                                                    .mishwarTypes![index]
                                                    .id!);
                                      },
                                    ),
                                    SizedBox(width: 16.w),
                                  ],
                                );
                              }),
                        ),
                      ],
                    ],
                  );
                },
              );
            },
          ),
          SizedBox(height: 25.h),
        ],
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: BlocConsumer<SettingsCubit, SettingsState>(
              listener: (context, state) async {
                if (state is UpdateServiceFailed) {
                  AppHelpers.showSnackBar(context,
                      message: state.message, error: true);
                }

                if (state is UpdateServiceSuccess) {
                  await SharedPrefController().setNavigationFromService(true);
                  AppHelpers.navigationToPageAndExitAll(context, MainScreen());
                  AppHelpers.showSnackBar(context, message: state.message);
                }
              },
              builder: (context, state) {
                if (state is UpdateServiceLoading) {
                  return LoadingWidget();
                }
                return MyElevatedButton(
                  title: AppLocalizations.of(context)!.saveTheModification,
                  onPressed: () async {
                    print(SettingsCubit.get(context).listIdCat);
                    SettingsCubit.get(context).updateService(context,
                        listCat: SettingsCubit.get(context).listIdCat,
                        carTypeId:
                            2 /* SettingsCubit.get(context).indexVehicleClass */,
                        navRangeId:
                            1 /* SettingsCubit.get(context)
                            .indexTypeNavigationRange */
                        );

                    // Navigator.pop(context);
                  },
                  titleColor: AppColors.BLACK,
                );
              },
            ),
          ),
          SizedBox(height: (MediaQuery.of(context).padding.bottom) + 10.h),
        ],
      ),
    );
  }
}
