import 'package:easy_plus_service_provider/core/utils/app_helpers.dart';
import 'package:easy_plus_service_provider/core/widgets/loading_widget.dart';
import 'package:easy_plus_service_provider/features/main/model/complaints.dart';
import 'package:easy_plus_service_provider/features/main/views/manager/compliants_cubit/complaints_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:lottie/lottie.dart';

import '../../../../../../../core/utils/app_colors.dart';
import '../../../../../../../core/widgets/my_app_bar.dart';
import '../../../../widgets/settings/complaint_request/item_complaint_request.dart';
import '../../../../widgets/settings/complaint_request/my_floating_action_button.dart';

class ComplaintRequestsScreen extends StatefulWidget {
  const ComplaintRequestsScreen({super.key});

  @override
  State<ComplaintRequestsScreen> createState() =>
      _ComplaintRequestsScreenState();
}

class _ComplaintRequestsScreenState extends State<ComplaintRequestsScreen> {
  var _scrollController = ScrollController();

  @override
  void initState() {
    ComplaintsCubit.get(context).getComplaints(context);
    _scrollController.addListener(pagination);

    super.initState();
  }

  void pagination() async {
    if ((_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) &&
        (ComplaintsCubit.get(context).listComplaints.length <
            ComplaintsCubit.get(context).total)) {
      await ComplaintsCubit.get(context)
          .getComplaints(context, loadPagination: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.BG_SCAFOLLD,
      appBar: MyAppBar(
        backgroundColor: AppColors.BG_SCAFOLLD,
        title: AppLocalizations.of(context)!.complaintsAndSuggestions,
      ),
      floatingActionButton: const MyFloatingActionButton(),
      body: BlocConsumer<ComplaintsCubit, ComplaintsState>(
        listener: (context, state) {
          if (state is ComplaintsFailed) {
            AppHelpers.showSnackBar(context,
                message: state.message, error: true);
          }
        },
        builder: (context, state) {
          if (state is ComplaintsLoading) {
            return const LoadingWidget();
          }

          if (state is ComplaintsFailed) {
            return LottieBuilder.asset(
              'assets/images/ic_json/faild.json',
              width: 300.w,
            );
          }

          if (ComplaintsCubit.get(context).listComplaints.length == 0) {
            return Center(
              child: LottieBuilder.asset(
                'assets/images/ic_json/no_data.json',
                width: 300.w,
              ),
            );
          }
          List<Complaints> listData =
              ComplaintsCubit.get(context).listComplaints;
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  controller: _scrollController,
                  padding:
                      EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
                  itemCount: listData.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        ItemComplaintRequest(data: listData[index]),
                        SizedBox(height: 12.h),
                      ],
                    );
                  },
                ),
              ),
              (state is ComplaintsLoadingPagination)
                  ? const LoadingWidget()
                  : const SizedBox(),
            ],
          );
        },
      ),
    );
  }
}
