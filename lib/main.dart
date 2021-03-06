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
import 'package:video_calling_app/helpers/utils.dart';
import 'package:video_calling_app/modules/profile/controllers/profile_controller.dart';
import 'package:video_calling_app/routes/app_pages.dart';

void main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    await initServices();
    runApp(const MyApp());
  } catch (err) {
    AppUtils.printLog(err);
  }
}

bool isLogin = false;

Future<void> initServices() async {
  await GetStorage.init();
  Get
    ..put(AppThemeController(), permanent: true)
    ..put(AuthService(), permanent: true)
    ..put(ProfileController(), permanent: true);

  await Get.find<AuthService>().getToken().then((value) async {
    Get.find<AuthService>().autoLogout();
    if (value.isNotEmpty) {
      var hasData = await Get.find<ProfileController>().getProfileDetails();
      if (hasData) {
        await Get.find<AuthService>().getChannelInfo();
        isLogin = true;
      }
    }
    isLogin
        ? AppUtils.printLog("User is logged in.")
        : AppUtils.printLog("User is not logged in.");
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
        builder: (_) => GetMaterialApp(
          title: StringValues.appName,
          debugShowCheckedModeBanner: false,
          themeMode: _handleAppTheme(logic.themeMode),
          theme: AppThemes.lightTheme,
          darkTheme: AppThemes.darkTheme,
          getPages: AppPages.pages,
          initialRoute: isLogin ? AppRoutes.home : AppRoutes.login,
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
