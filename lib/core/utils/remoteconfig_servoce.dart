// ignore_for_file: use_build_context_synchronously
import 'dart:developer';
import 'dart:io';
import 'package:easy_plus_service_provider/core/utils/app_dialogs.dart';
import 'package:easy_plus_service_provider/features/main/model/response_app_config.dart';
import 'package:easy_plus_service_provider/features/main/views/manager/home_cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class RemoteConfigService {
  String appStoreUrl =
      'https://apps.apple.com/il/app/5ways-captain-5%D9%88%D8%A7%D9%8A%D8%B2-%D9%83%D8%A7%D8%A8%D8%AA%D9%86/id6448885686';
  String playStoreUrl =
      'https://play.google.com/store/apps/details?id=com.kayan.easyPlusServiceProvider';

  Future<bool> requestUpdateApplication({
    required String? androidVersion,
    required String? iosVersion,
  }) async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String versionCode = packageInfo.buildNumber;

    log('minimum_app_version_ios $iosVersion');
    log('minimum_app_version_android $androidVersion');
    if (Platform.isAndroid) {
      return androidVersion == null ? true : versionCode == androidVersion;
    } else {
      return iosVersion == null ? true : versionCode == iosVersion;
    }
  }

  Future<bool> checkOurAppForUpdate(BuildContext context) async {
    App? app = HomeCubit.get(context).appConfig!.app;

    bool? uploadingAppANDROID = app!.isUploadAppAndroid;
    bool? uploadingAppIOS = app.isUploadAppIos;

    String? iosVersionCode = app.iosVersionCode;
    String? androidVersionCode = app.androidVersionCode;

    bool checkAppVersion = await requestUpdateApplication(
      androidVersion: androidVersionCode,
      iosVersion: iosVersionCode,
    );

    if (checkAppVersion) {
      // ? PASS
      return false;
    } else {
      if (Platform.isAndroid) {
        if (uploadingAppANDROID == null || uploadingAppANDROID) {
          // ? PASS
          return false;
        } else {
          AppDialogs.updateApplication(
            context,
            onTap: () {
              if (Platform.isAndroid) {
                openPlayStore();
              } else {
                openAppStore();
              }
            },
          );
          return true;
        }
      } else {
        if (uploadingAppIOS == null || uploadingAppIOS) {
          // ? PASS
          return false;
        } else {
          AppDialogs.updateApplication(
            context,
            onTap: () {
              if (Platform.isAndroid) {
                openPlayStore();
              } else {
                openAppStore();
              }
            },
          );
          return true;
        }
      }
    }
  }

  void openAppStore() async {
    if (!await launchUrl(
      Uri.parse(appStoreUrl),
    )) {
      throw Exception('Could not launch $appStoreUrl');
    }
  }

  void openPlayStore() async {
    if (!await launchUrl(
      Uri.parse(playStoreUrl),
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $playStoreUrl');
    }
  }
}
