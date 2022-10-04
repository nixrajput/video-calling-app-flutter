import 'package:get/get.dart';
import 'package:video_calling_app/routes/app_pages.dart';

abstract class RouteManagement {
  static void goToLoginView() {
    Get.offAllNamed(AppRoutes.login);
  }

  static void goToServerMaintenanceView() {
    Get.offAllNamed(AppRoutes.maintenance);
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
    Get.toNamed(AppRoutes.resetPassword);
  }

  static void goToSendVerifyAccountOtpView() {
    Get.toNamed(AppRoutes.sendVerifyAccountOtp);
  }

  static void goToVerifyAccountView() {
    Get.toNamed(AppRoutes.verifyAccount);
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

  static void goToCallingView(
      {String? channelId, bool? enableVideo, bool? enableAudio}) {
    Get.offAndToNamed(AppRoutes.calling,
        arguments: [channelId, enableVideo, enableAudio]);
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

  static void goToAppUpdateView() {
    Get.offAllNamed(AppRoutes.appUpdate);
  }

  static void goToEditNameView() {
    Get.toNamed(AppRoutes.editName);
  }

  static void goToEditUsernameView() {
    Get.toNamed(AppRoutes.editUsername);
  }

  static void goToBack() {
    Get.back();
  }
}
