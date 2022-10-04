abstract class StringValues {
  static const appName = 'LiveBox';
  static const welcome = 'Welcome';
  static const hello = 'Hello';
  static const register = 'Register';
  static const login = 'Login';
  static const logout = 'Logout';
  static const forgotPassword = 'Forgot Password';
  static const resetPassword = 'Reset Password';
  static const name = 'Name';
  static const firstName = 'First Name';
  static const lastName = 'Last Name';
  static const email = 'Email';
  static const username = 'Username';
  static const password = 'Password';
  static const emailUname = 'Email or Username';
  static const confirmPassword = 'Confirm Password';
  static const newPassword = 'New Password';
  static const oldPassword = 'Old Password';
  static const settings = 'Settings';
  static const profile = 'Profile';
  static const doNotHaveAccount = "Don't have an account?";
  static const alreadyHaveAccount = "Already have an account?";
  static const okay = 'Okay';
  static const info = 'info';
  static const success = 'success';
  static const warning = 'warning';
  static const error = 'error';
  static const none = 'none';
  static const message = 'message';
  static const enterFirstName = 'Enter your first name';
  static const enterLastName = 'Enter your last name';
  static const enterEmail = 'Enter your email';
  static const enterUsername = 'Enter an username';
  static const enterPassword = 'Enter a password';
  static const enterOldPassword = 'Enter current password';
  static const enterNewPassword = 'Enter a new password';
  static const enterOtp = 'Enter the OTP';
  static const enterConfirmPassword = 'Retype your password';
  static const errorOccurred = 'An error occurred, please try again.';
  static const unknownErrorOccurred = 'An unknown error occurred.';
  static const loginSuccessful = 'Logged in successfully.';
  static const registrationSuccessful = 'Registered successfully.';
  static const logoutSuccessful = 'Logged out successfully.';
  static const token = 'token';
  static const expiresAt = 'expiresAt';
  static const loginData = 'loginData';
  static const userData = 'userData';
  static const home = 'Home';
  static const search = 'Search';
  static const notifications = 'Notifications';
  static const theme = 'Theme';
  static const getOtp = 'Get OTP';
  static const otp = 'OTP';
  static const otpSendSuccessful = 'OTP sent successfully to your email.';
  static const doNotHaveOtp = "Don't have an OTP?";
  static const alreadyHaveOtp = "Already have an OTP?";
  static const passwordChangeSuccessful = 'Password changed successfully.';
  static const editProfile = 'Edit Profile';
  static const updateProfileSuccessful = 'Profile updated successfully.';
  static const updateUsernameSuccessful = 'Username updated successfully.';
  static const tokenError = 'Token is expired or invalid.';
  static const changePassword = 'Change Password';
  static const changeUsername = 'Change Username';
  static const changeProfilePicture = 'Change Profile Picture';
  static const changeName = 'Change Name';
  static const about = 'About';
  static const userNotFoundError = 'User details not found.';
  static const save = 'Save';
  static const dob = 'DOB';
  static const birthDate = 'Date of Birth';
  static const gender = 'Gender';
  static const phoneNo = 'Phone Number';
  static const countryCode = 'Country Code';
  static const cropImage = 'Crop Image';
  static const refresh = 'Refresh';
  static const noPosts = 'No posts to show.';
  static const writeSomethingAboutYou = 'Write something about you...';
  static const dobFormat = 'dd mmm, yyyy';
  static const select = 'Select';
  static const noData = 'No data to show.';
  static const internetConnError =
      'Internet connection is poor or unavailable.';
  static const connTimedOut = 'Connection timed out.';
  static const formatExcError = 'Format error occurred.';
  static const authDetailsSaved = 'Auth details saved.';
  static const authDetailsNotSaved = "Auth details couldn't saved.";
  static const authDetailsFound = 'Auth details found.';
  static const authDetailsNotFound = 'Auth details not found.';
  static const authDetailsRemoved = 'Auth details removed.';
  static const usernameAvailable = 'Username available.';
  static const usernameNotAvailable = 'Username not available.';
  static const userIdNotFound = 'User Id not found.';
  static const privateAccountWarning = 'Account is private.';
  static const deleteConfirmationText = "Are you sure to delete?";
  static const yes = 'Yes';
  static const no = 'No';
  static const exit = 'Exit';
  static const male = 'Male';
  static const female = 'Female';
  static const others = 'Others';
  static const delete = 'Delete';
  static const share = 'Share';
  static const report = 'Report';
  static const public = 'public';
  static const private = 'private';
  static const display = 'Display';
  static const account = 'Account';
  static const security = 'Security';
  static const privacy = 'Privacy';
  static const channelId = "channelId";
  static const agoraUid = "agoraUid";
  static const channelData = "channelData";
  static const channelDataSaved = "Channel info saved.";
  static const channelDataFound = "Channel info found.";
  static const channelDataNotFound = "Channel info not found.";
  static const start = "Start";
  static const join = "Join";
  static const profileData = "profileData";
  static const profileDetailsSaved = 'Profile details saved.';
  static const profileDetailsNotSaved = "Profile details couldn't saved.";
  static const profileDetailsFound = 'Profile details found.';
  static const profileDetailsNotFound = 'Profile details not found.';
  static const profileDetailsRemoved = 'Profile details removed.';

  static const String themeMode = 'themeMode';
  static const String system = 'System';
  static const String light = 'Light';
  static const String dark = 'Dark';
  static const appUpdateAvailable = 'App update available';
  static const verifyYourAccount = 'Verify your account';
  static const verifyAccount = 'Verify Account';
  static const loginToAccount = 'Login To Account';
  static const resendOtp = 'Resend OTP';
  static const enterEmailForOtp =
      'Enter your email address and an OTP will be sent to your email address if account exists';
  static const enterOtpYouGet =
      'An OTP has been sent to your email address, please enter OTP to proceed';
  static const sendOtp = 'Send OTP';
}

abstract class AssetValues {
  static const String appIcon = 'assets/icon.png';
  static const String avatar = 'assets/avatar.png';
  static const String vector1 = 'assets/vector-1.png';
  static const String error = 'assets/error.png';
}

extension StringCasingExtension on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';

  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');
}
