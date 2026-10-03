import 'package:easy_plus_service_provider/features/main/views/manager/home_cubit/home_cubit.dart';
import 'package:easy_plus_service_provider/features/main/views/widgets/settings/settings_section/item_language.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/widgets/my_contianer_shape.dart';
import '../../../manager/language_cubit/language_cubit.dart';

class TabLanguage extends StatelessWidget {
  const TabLanguage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MyContainerShape(
      height: 76.h,
      enableShadow: false,
      paddingHorizontal: 11,
      paddingVertical: 11,
      borderRadius: 50,
      child: BlocBuilder<LanguageCubit, LanguageState>(
        builder: (context, state) {
          int index = LanguageCubit.get(context).indexLang;
          return Directionality(
            textDirection: TextDirection.rtl,
            child: Row(
              children: [
                ItemLanguage(
                  onTap: () {
                    if (index != 0) {
                      LanguageCubit.get(context).changeLanguage(0);
                      HomeCubit.get(context).setDataTourType(context);

                      HomeCubit.get(context).getHomeData(context);
                      HomeCubit.get(context).getAppConfig(context);
                    }
                  },
                  title: AppLocalizations.of(context)!.arabic,
                  isSelected: index == 0,
                ),
                ItemLanguage(
                  onTap: () {
                    if (index != 1) {
                      LanguageCubit.get(context).changeLanguage(1);
                      HomeCubit.get(context).setDataTourType(context);

                      HomeCubit.get(context).getHomeData(context);
                      HomeCubit.get(context).getAppConfig(context);
                    }
                  },
                  title: AppLocalizations.of(context)!.english,
                  isSelected: index == 1,
                ),
                ItemLanguage(
                  onTap: () {
                    if (index != 2) {
                      LanguageCubit.get(context).changeLanguage(2);
                      HomeCubit.get(context).setDataTourType(context);

                      HomeCubit.get(context).getHomeData(context);
                      HomeCubit.get(context).getAppConfig(context);
                    }
                  },
                  title: AppLocalizations.of(context)!.urdu,
                  isSelected: index == 2,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
