part of 'app_pages.dart';

abstract class AppRoutes {
  static const splash = _Routes.splash;
  static const error = _Routes.error;
  static const home = _Routes.home;

  static const login = _Routes.login;
  static const register = _Routes.register;

  static const settings = _Routes.settings;

  static const forgotPassword = _Routes.forgotPassword;
  static const resetPassword = _Routes.resetPassword;
  static const changePassword = _Routes.changePassword;

  static const editProfile = _Routes.editProfile;

  static const calling = _Routes.calling;
  static const postDetails = _Routes.postDetails;

  static const userProfile = _Routes.userProfile;
}

abstract class _Routes {
  static const splash = '/';
  static const error = '/error';
  static const home = '/home';

  static const login = '/login';
  static const register = '/register';

  static const settings = '/settings';

  static const forgotPassword = '/forgot_password';
  static const resetPassword = '/reset_password';
  static const changePassword = '/change_password';

  static const editProfile = '/edit_profile';

  static const calling = '/calling';
  static const postDetails = '/post_details';

  static const userProfile = '/user_profile';
}
