abstract class AppUrls {
  // Base URL
  static const String baseUrl =
      'https://nixlab-social-api.herokuapp.com/api/v1';
  static const String tokenBaseUrl =
      'https://nixlab-agora-token-server.herokuapp.com/api/v1';

//  Endpoints
  static const String loginEndpoint = '/login';
  static const String registerEndpoint = '/register';
  static const String updatePasswordEndpoint = '/change-password';
  static const String forgotPasswordEndpoint = '/forgot-password';
  static const String resetPasswordEndpoint = '/reset-password';

  static const String getRtcToken = '/rtcToken';
  static const String getRtmToken = '/rtmToken';

  static const String profileDetailsEndpoint = '/me';
  static const String uploadProfilePicEndpoint = '/upload-avatar';
  static const String updateProfileDetailsEndpoint = '/update-profile-details';
  static const String checkUsernameAvailableEndpoint = '/check-username';
  static const String updateUsernameEndpoint = '/change-username';
  static const String verifyEmailEndpoint = '/verify-email';

  static const String userDetailsEndpoint = '/profile-details';
}
