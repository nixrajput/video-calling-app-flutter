import 'package:get/get.dart';
import 'package:video_calling_app/routes/app_pages.dart';

abstract class RouteManagement {
  static void goToLoginView() {
    Get.offAllNamed(AppRoutes.login);
  }

  static void goToSplashView() {
    Get.offAllNamed(AppRoutes.splash);
  }

  static void goToErrorView() {
    Get.offAllNamed(AppRoutes.error);
  }

  static void goToRegisterView() {
    Get.toNamed(AppRoutes.register);
  }

  static void goToForgotPasswordView() {
    Get.toNamed(AppRoutes.forgotPassword);
  }

  static void goToResetPasswordView() {
    Get.offAndToNamed(AppRoutes.resetPassword);
  }

  static void goToHomeView() {
    Get.offAllNamed(AppRoutes.home);
  }

  static void goToSettingsView() {
    Get.toNamed(AppRoutes.settings);
  }

  static void goToChangePasswordView() {
    Get.toNamed(AppRoutes.changePassword);
  }

  static void goToCallingView({String? channelId}) {
    Get.offAndToNamed(AppRoutes.calling, arguments: channelId);
  }

  static void goToStartView() {
    Get.toNamed(AppRoutes.start);
  }

  static void goToJoinView() {
    Get.toNamed(AppRoutes.join);
  }

  static void goToProfileView() {
    Get.toNamed(AppRoutes.profile);
  }

  static void goToBack() {
    Get.back();
  }
}
