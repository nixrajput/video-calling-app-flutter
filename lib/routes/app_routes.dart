part of 'app_pages.dart';

abstract class AppRoutes {
  static const splash = _Routes.splash;
  static const error = _Routes.error;
  static const home = _Routes.home;
  static const maintenance = _Routes.maintenance;

  static const login = _Routes.login;
  static const register = _Routes.register;

  static const settings = _Routes.settings;

  static const forgotPassword = _Routes.forgotPassword;
  static const resetPassword = _Routes.resetPassword;
  static const changePassword = _Routes.changePassword;
  static const sendVerifyAccountOtp = _Routes.sendVerifyAccountOtp;
  static const verifyAccount = _Routes.verifyAccount;

  static const profile = _Routes.profile;
  static const editProfile = _Routes.editProfile;
  static const editName = _Routes.editName;
  static const editUsername = _Routes.editUsername;

  static const calling = _Routes.calling;
  static const start = _Routes.start;
  static const join = _Routes.join;

  static const userProfile = _Routes.userProfile;

  static const appUpdate = _Routes.appUpdate;
}

abstract class _Routes {
  static const splash = '/';
  static const error = '/error';
  static const home = '/home';
  static const maintenance = '/maintenance';

  static const login = '/login';
  static const register = '/register';

  static const settings = '/settings';

  static const forgotPassword = '/forgot_password';
  static const resetPassword = '/reset_password';
  static const changePassword = '/change_password';
  static const sendVerifyAccountOtp = '/send_account_verification_otp';
  static const verifyAccount = '/verify_account';

  static const profile = '/profile';
  static const editProfile = '/edit_profile';
  static const editName = '/edit_name';
  static const editUsername = '/edit_username';

  static const calling = '/calling';
  static const start = '/start';
  static const join = '/join';

  static const userProfile = '/user_profile';

  static const appUpdate = '/app_update';
}
