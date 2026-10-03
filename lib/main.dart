import 'package:easy_plus_service_provider/core/network/api/notification_api.dart';
import 'package:easy_plus_service_provider/core/storage/pref/shared_pref_controller.dart';
import 'package:easy_plus_service_provider/features/main/views/manager/language_cubit/language_cubit.dart';
import 'package:easy_plus_service_provider/features/on_boarding/views/pages/splash_screen.dart';
import 'package:easy_plus_service_provider/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'app_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await SharedPrefController().initSharedPref();
  await NotificationApi().initNotification();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: AppConfig.providers,
      child: ScreenUtilInit(
        designSize: const Size(390, 844),
        useInheritedMediaQuery: true,
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return BlocBuilder<LanguageCubit, LanguageState>(
            builder: (context, state) {
              int indexLang = LanguageCubit.get(context).indexLang;
              String lang = SharedPrefController().getLang;
              LanguageCubit.get(context).changeLanguage(lang == 'ar'
                  ? 0
                  : lang == 'en'
                      ? 1
                      : 2);

              return MaterialApp(
                title: 'Easy Plus Service Provider',
                debugShowCheckedModeBanner: false,
                theme: AppConfig.theme,
                localizationsDelegates: AppConfig.settingsLocalizations,
                supportedLocales: AppConfig.supportedLocales,
                locale: Locale(indexLang == 0
                    ? 'ar'
                    : indexLang == 1
                        ? 'en'
                        : 'or'),
                home: const SplashScreen(),
              );
            },
          );
        },
      ),
    );
  }
}
