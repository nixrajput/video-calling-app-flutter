import 'package:get/get.dart';
import 'package:video_calling_app/modules/auth/bindings/change_password_binding.dart';
import 'package:video_calling_app/modules/auth/bindings/login_binding.dart';
import 'package:video_calling_app/modules/auth/bindings/password_binding.dart';
import 'package:video_calling_app/modules/auth/bindings/register_binding.dart';
import 'package:video_calling_app/modules/auth/views/change_password_view.dart';
import 'package:video_calling_app/modules/auth/views/forgot_password_view.dart';
import 'package:video_calling_app/modules/auth/views/login_view.dart';
import 'package:video_calling_app/modules/auth/views/register_view.dart';
import 'package:video_calling_app/modules/auth/views/reset_password_view.dart';
import 'package:video_calling_app/modules/calling/bindings/calling_binding.dart';
import 'package:video_calling_app/modules/calling/views/calling_view.dart';
import 'package:video_calling_app/modules/home/bindings/home_binding.dart';
import 'package:video_calling_app/modules/home/views/home_view.dart';

part 'app_routes.dart';

abstract class AppPages {
  static var transitionDuration = const Duration(milliseconds: 200);

  static final pages = [
    GetPage(
      name: _Routes.login,
      page: LoginView.new,
      transitionDuration: transitionDuration,
      binding: LoginBinding(),
      transition: Transition.downToUp,
    ),
    GetPage(
      name: _Routes.register,
      page: RegisterView.new,
      transitionDuration: transitionDuration,
      binding: RegisterBinding(),
      transition: Transition.downToUp,
    ),
    GetPage(
      name: _Routes.home,
      page: HomeView.new,
      transitionDuration: transitionDuration,
      binding: HomeBinding(),
      transition: Transition.downToUp,
    ),

    GetPage(
      name: _Routes.forgotPassword,
      page: ForgotPasswordView.new,
      transitionDuration: transitionDuration,
      binding: PasswordBinding(),
      transition: Transition.downToUp,
    ),
    GetPage(
      name: _Routes.resetPassword,
      page: ResetPasswordView.new,
      transitionDuration: transitionDuration,
      binding: PasswordBinding(),
      transition: Transition.downToUp,
    ),
    GetPage(
      name: _Routes.changePassword,
      page: ChangePasswordView.new,
      transitionDuration: transitionDuration,
      binding: ChangePasswordBinding(),
      transition: Transition.downToUp,
    ),
    GetPage(
      name: _Routes.calling,
      page: CallingView.new,
      transitionDuration: transitionDuration,
      binding: CallingBinding(),
      transition: Transition.downToUp,
    ),
    // GetPage(
    //   name: _Routes.settings,
    //   page: SettingsView.new,
    //   binding: SettingBinding(),
    //   transitionDuration: transitionDuration,
    //   transition: Transition.downToUp,
    // ),
  ];
}
