import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:video_calling_app/apis/services/auth_service.dart';
import 'package:video_calling_app/apis/services/theme_controller.dart';
import 'package:video_calling_app/constants/colors.dart';
import 'package:video_calling_app/constants/strings.dart';
import 'package:video_calling_app/constants/themes.dart';
import 'package:video_calling_app/helpers/utility.dart';
import 'package:video_calling_app/modules/app_update/app_update_controller.dart';
import 'package:video_calling_app/modules/profile/controllers/profile_controller.dart';
import 'package:video_calling_app/routes/app_pages.dart';

void main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    await initServices();
    runApp(const MyApp());
    await AppUpdateController.find.checkAppUpdate(
      showLoading: false,
      showAlert: false,
    );
  } catch (err) {
    AppUtility.printLog(err);
  }
}

bool isLogin = false;
String serverHealth = "offline";

Future<void> initServices() async {
  await GetStorage.init();
  Get
    ..put(AppThemeController(), permanent: true)
    ..put(AuthService(), permanent: true)
    ..put(ProfileController(), permanent: true)
    ..put(AppUpdateController(), permanent: true);

  serverHealth = await Get.find<AuthService>().checkServerHealth();
  AppUtility.printLog("ServerHealth: $serverHealth");

  /// If [serverHealth] is `offline` or `maintenance`,
  /// then return
  if (serverHealth.toLowerCase() == "offline" ||
      serverHealth.toLowerCase() == "maintenance") {
    return;
  }
  await Get.find<AuthService>().getToken().then((token) async {
    Get.find<AuthService>().autoLogout();
    if (token.isNotEmpty) {
      var tokenValid = await Get.find<AuthService>().validateToken(token);
      if (tokenValid) {
        var hasData = await Get.find<ProfileController>().getProfileDetails();
        if (hasData) {
          isLogin = true;
        } else {
          await AppUtility.clearLoginDataFromLocalStorage();
        }
      } else {
        await AppUtility.clearLoginDataFromLocalStorage();
      }
    }
    isLogin
        ? AppUtility.printLog("User is logged in")
        : AppUtility.printLog("User is not logged in");
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (SchedulerBinding.instance.window.platformBrightness ==
        Brightness.light) {
      SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark,
          statusBarColor: ColorValues.lightBgColor,
          statusBarBrightness: Brightness.light,
          systemNavigationBarColor: ColorValues.lightBgColor,
          systemNavigationBarIconBrightness: Brightness.dark,
        ),
      );
    } else {
      SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.light,
          statusBarColor: ColorValues.darkBgColor,
          statusBarBrightness: Brightness.dark,
          systemNavigationBarColor: ColorValues.darkBgColor,
          systemNavigationBarIconBrightness: Brightness.light,
        ),
      );
    }

    return GetBuilder<AppThemeController>(
      builder: (logic) => ScreenUtilInit(
        designSize: const Size(392, 744),
        builder: (_, __) => GetMaterialApp(
          title: StringValues.appName,
          debugShowCheckedModeBanner: false,
          themeMode: _handleAppTheme(logic.themeMode),
          theme: AppThemes.lightTheme,
          darkTheme: AppThemes.darkTheme,
          getPages: AppPages.pages,
          initialRoute: serverHealth.toLowerCase() == "maintenance"
              ? AppRoutes.maintenance
              : isLogin
                  ? AppRoutes.home
                  : AppRoutes.login,
        ),
      ),
    );
  }

  _handleAppTheme(mode) {
    if (mode == StringValues.dark) {
      return ThemeMode.dark;
    }
    if (mode == StringValues.light) {
      return ThemeMode.light;
    }
    return ThemeMode.system;
  }
}
