import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:easy_plus_service_provider/core/utils/app_helpers.dart';
import 'package:easy_plus_service_provider/core/widgets/loading_widget.dart';
import 'package:easy_plus_service_provider/core/widgets/my_text.dart';
import 'package:easy_plus_service_provider/features/main/model/qustion.dart';
import 'package:easy_plus_service_provider/features/main/views/manager/common_quastions_cubit/common_quastions_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:lottie/lottie.dart';

import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/widgets/my_app_bar.dart';
import '../../../../../../core/widgets/my_contianer_shape.dart';
import '../../../widgets/settings/common_qustions/item_qustions.dart';

class CommonQuestionsScreen extends StatefulWidget {
  const CommonQuestionsScreen({super.key});

  @override
  State<CommonQuestionsScreen> createState() => _CommonQuestionsScreenState();
}

class _CommonQuestionsScreenState extends State<CommonQuestionsScreen> {
  var _scrollController = ScrollController();

  @override
  void initState() {
    _scrollController.addListener(pagination);
    super.initState();
  }

  void pagination() async {
    if ((_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) &&
        (CommonQuastionsCubit.get(context).listQustion.length <
            CommonQuastionsCubit.get(context).total)) {
      await CommonQuastionsCubit.get(context)
          .getQustion(context, loadPagination: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.BG_SCAFOLLD,
      appBar: MyAppBar(
        backgroundColor: AppColors.BG_SCAFOLLD,
        title: AppLocalizations.of(context)!.commonQuestions,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
          child: Column(
            children: [
              Expanded(
                child: MyContainerShape(
                  borderRadius: 11,
                  paddingHorizontal: 12,
                  paddingVertical: 12,
                  child:
                      BlocConsumer<CommonQuastionsCubit, CommonQuastionsState>(
                    listener: (context, state) {
                      if (state is FailedQustionData) {
                        AppHelpers.showSnackBar(
                          context,
                          message: state.message,
                          error: true,
                        );
                      }
                    },
                    builder: (context, state) {
                      if (state is LoadingQustionData) {
                        return LoadingWidget();
                      }
                      if (state is FailedQustionData) {
                        return Center(
                          child: LottieBuilder.asset(
                            'assets/images/ic_json/faild.json',
                          ),
                        );
                      }

                      List<Qustion> listQustion =
                          CommonQuastionsCubit.get(context).listQustion;
                      return Column(
                        children: [
                          if (listQustion.length > 0) ...[
                            Expanded(
                              child: CustomRefreshIndicator(
                                leadingScrollIndicatorVisible: true,
                                trailingScrollIndicatorVisible: true,
                                builder: AppHelpers.getIndecatorDelegate(),
                                onRefresh: () async {
                                  CommonQuastionsCubit.get(context)
                                      .getQustion(context);
                                },
                                child: ListView.builder(
                                  controller: _scrollController,
                                  physics: AlwaysScrollableScrollPhysics(),
                                  itemCount: listQustion.length,
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 16.w),
                                  itemBuilder: (context, index) {
                                    return Column(
                                      children: [
                                        ItemQuestions(
                                            qustion: listQustion[index]),
                                        SizedBox(height: 12.h),
                                      ],
                                    );
                                  },
                                ),
                              ),
                            ),
                          ] else ...[
                            Center(
                              child: MyText(
                                title:
                                    AppLocalizations.of(context)!.noDataOrders,
                              ),
                            )
                          ],
                          (state is QustionLoadingPagination)
                              ? const LoadingWidget()
                              : const SizedBox(),
                        ],
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
