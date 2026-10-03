import 'package:easy_plus_service_provider/core/utils/app_colors.dart';
import 'package:easy_plus_service_provider/features/auth/views/manager/auth_cubit/auth_cubit.dart';
import 'package:easy_plus_service_provider/features/main/views/manager/common_quastions_cubit/common_quastions_cubit.dart';
import 'package:easy_plus_service_provider/features/main/views/manager/compliants_cubit/complaints_cubit.dart';
import 'package:easy_plus_service_provider/features/main/views/manager/home_cubit/home_cubit.dart';
import 'package:easy_plus_service_provider/features/main/views/manager/language_cubit/language_cubit.dart';
import 'package:easy_plus_service_provider/features/main/views/manager/main_cubit/main_cubit.dart';
import 'package:easy_plus_service_provider/features/main/views/manager/my_account_cubit/my_account_cubit.dart';
import 'package:easy_plus_service_provider/features/main/views/manager/my_request_cubit/my_request_cubit.dart';
import 'package:easy_plus_service_provider/features/main/views/manager/settings_cubit/settings_cubit.dart';
import 'package:easy_plus_service_provider/features/main/views/manager/total_price_cubit/total_price_cubit.dart';
import 'package:easy_plus_service_provider/features/main/views/manager/tracking_cubit/tracking_cubit.dart';
import 'package:easy_plus_service_provider/features/main/views/manager/wallet_cubit/wallet_cubit.dart';
import 'package:easy_plus_service_provider/features/on_boarding/views/manager/onboarding_cubit/on_boarding_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/src/bloc_provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AppConfig {
  static List<SingleChildWidget> providers = [
    BlocProvider(create: (context) => AuthCubit()),
    BlocProvider(create: (context) => MainCubit()),
    BlocProvider(create: (context) => HomeCubit()),
    BlocProvider(create: (context) => MyRequestCubit()),
    BlocProvider(create: (context) => MyAccountCubit()),
    BlocProvider(create: (context) => TrackingCubit()),
    BlocProvider(create: (context) => SettingsCubit()),
    BlocProvider(create: (context) => LanguageCubit()),
    BlocProvider(create: (context) => TotalPriceCubit()),
    BlocProvider(create: (context) => CommonQuastionsCubit()),
    BlocProvider(create: (context) => ComplaintsCubit()),
    BlocProvider(create: (context) => OnBoardingCubit()),
    BlocProvider(create: (context) => OnBoardingCubit()),
    BlocProvider(create: (context) => WalletCubit()),
  ];

  static Iterable<LocalizationsDelegate<dynamic>> settingsLocalizations =
      const [
    AppLocalizations.delegate, // Add this line
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ];

  static Iterable<Locale> supportedLocales = const [
    Locale('en'),
    Locale('ar'),
    Locale('or'),
  ];

  static ThemeData? theme = ThemeData(
    primarySwatch: AppColors.APP_THEME,
    scaffoldBackgroundColor: AppColors.WHITE,
  );
}
