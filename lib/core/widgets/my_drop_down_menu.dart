import 'package:easy_plus_service_provider/core/utils/app_colors.dart';
import 'package:easy_plus_service_provider/core/widgets/my_contianer_shape.dart';
import 'package:easy_plus_service_provider/core/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyDropdownMenu extends StatelessWidget {
  final String initValue;
  final List<String> listItems;
  final ValueChanged<String?> onChanged;
  final double? width;
  final double? height;
  final bool enabledBorder;
  final AlignmentDirectional alignment;
  final double paddingHorizontal;
  final Color textColor;
  final Color background;
  final bool isDense;
  final Widget? iconDropdown;
  final bool isExpanded;

  MyDropdownMenu({
    super.key,
    required this.initValue,
    required this.listItems,
    required this.onChanged,
    this.enabledBorder = true,
    this.isDense = false,
    this.alignment = AlignmentDirectional.center,
    this.width = null,
    this.height,
    this.paddingHorizontal = 20,
    this.textColor = AppColors.BLACK,
    this.iconDropdown,
    this.isExpanded = false,
    this.background = AppColors.TRANSPARENT,
  });

  @override
  Widget build(BuildContext context) {
    return MyContainerShape(
      width: width,
      height: height,
      paddingHorizontal: paddingHorizontal.w,
      alignment: alignment,
      enableRadius: true,
      enableBorder: enabledBorder,
      enableShadow: false,
      bgContainer: background,
      borderRadius: 10.r,
      topEndRaduis: 10.r,
      topStartRaduis: 10.r,
      bottomEndRaduis: 10.r,
      bottomStartRaduis: 10.r,
      widthBorder: 1,
      child: DropdownButton(
        borderRadius: BorderRadius.circular(10.r),
        alignment: alignment,
        underline: const SizedBox(),
        isExpanded: isExpanded,
        value: initValue,
        isDense: isDense,
        icon: setIcon(),
        dropdownColor: AppColors.WHITE,
        items: listItems.map((String items) {
          return DropdownMenuItem(
            value: items,
            alignment: alignment,
            child: MyText(
              textAlign: TextAlign.center,
              title: items,
              fontSize: 14,
              color: textColor,
            ),
          );
        }).toList(),
        onChanged: onChanged,
      ),
    );
  }

  Widget setIcon() {
    if (iconDropdown != null) {
      return iconDropdown!;
    }
    return SvgPicture.asset(
      'assets/images/arrows/ic_arrow_down.svg',
      width: 6.r,
      height: 6.r,
    );
  }
}
