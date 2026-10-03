import 'package:easy_plus_service_provider/core/widgets/my_text.dart';
import 'package:easy_plus_service_provider/features/main/model/response_app_config.dart';
import 'package:easy_plus_service_provider/features/main/views/widgets/home/item_option.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ItemFilter extends StatelessWidget {
  const ItemFilter({
    super.key,
    required this.listOption,
    required this.title,
    required this.onClickOption,
  });

  final List<CustomClass> listOption;
  final String title;
  final Function(int index) onClickOption;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MyText(
          title: title,
          fontWeight: FontWeight.bold,
        ),
        SizedBox(height: 12.h),
        SizedBox(
            height: 30.h,
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: listOption.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Row(
                  children: [
                    ItemOption(
                      onTapOption: () {
                        onClickOption(index);
                      },
                      isSelected: listOption[index].isSelected!,
                      title: listOption[index].name ?? "",
                    ),
                    SizedBox(width: 12.w),
                  ],
                );
              },
            )),
        SizedBox(height: 12.h),
      ],
    );
  }
}
