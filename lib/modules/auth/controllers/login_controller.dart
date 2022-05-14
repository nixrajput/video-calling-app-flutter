import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:video_calling_app/apis/models/responses/login_response.dart';
import 'package:video_calling_app/apis/providers/api_provider.dart';
import 'package:video_calling_app/apis/services/auth_service.dart';
import 'package:video_calling_app/constants/strings.dart';
import 'package:video_calling_app/helpers/utils.dart';
import 'package:video_calling_app/modules/profile/controllers/profile_controller.dart';
import 'package:video_calling_app/routes/route_management.dart';

class LoginController extends GetxController {
  static LoginController get find => Get.find();

  final _auth = AuthService.find;
  final _profileController = ProfileController.find;

  final _apiProvider = ApiProvider(http.Client());

  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  final FocusScopeNode focusNode = FocusScopeNode();
  final _showPassword = true.obs;
  final _loginData = LoginResponse().obs;
  final _isLoading = false.obs;

  bool get isLoading => _isLoading.value;

  bool get showPassword => _showPassword.value;

  set setLoginData(LoginResponse value) {
    _loginData.value = value;
  }

  LoginResponse get loginData => _loginData.value;

  void _clearLoginTextControllers() {
    emailTextController.clear();
    passwordTextController.clear();
  }

  void toggleViewPassword() {
    _showPassword(!_showPassword.value);
    update();
  }

  Future<void> _login(String email, String password) async {
    if (email.isEmpty) {
      AppUtils.showSnackBar(
        StringValues.enterEmail,
        StringValues.warning,
      );
      return;
    }
    if (password.isEmpty) {
      AppUtils.showSnackBar(
        StringValues.enterPassword,
        StringValues.warning,
      );
      return;
    }

    final body = {
      'email': email,
      'password': password,
    };

    AppUtils.printLog("User Login Request...");
    AppUtils.showLoadingDialog();
    _isLoading.value = true;
    update();

    try {
      final response = await _apiProvider.login(body);

      final decodedData = jsonDecode(utf8.decode(response.bodyBytes));

      if (response.statusCode == 200) {
        setLoginData = LoginResponse.fromJson(decodedData);

        var token = loginData.token!;
        var expiresAt = loginData.expiresAt!;

        await AppUtils.saveLoginDataToLocalStorage(token, expiresAt);

        _auth.setAuthToken = token;
        _auth.setExpiresAt = expiresAt;
        _auth.autoLogout();

        await AppUtils.saveChannelDataToLocalStorage();
        await _auth.getChannelInfo();
        await _profileController.fetchProfileDetails();

        _clearLoginTextControllers();

        AppUtils.closeDialog();
        _isLoading.value = false;
        update();
        RouteManagement.goToHomeView();
        AppUtils.showSnackBar(
          StringValues.loginSuccessful,
          StringValues.success,
        );
      } else {
        AppUtils.closeDialog();
        _isLoading.value = false;
        update();
        AppUtils.showSnackBar(
          decodedData[StringValues.message],
          StringValues.error,
        );
      }
    } on SocketException {
      AppUtils.closeDialog();
      _isLoading.value = false;
      update();
      AppUtils.printLog(StringValues.internetConnError);
      AppUtils.showSnackBar(StringValues.internetConnError, StringValues.error);
    } on TimeoutException {
      AppUtils.closeDialog();
      _isLoading.value = false;
      update();
      AppUtils.printLog(StringValues.connTimedOut);
      AppUtils.printLog(StringValues.connTimedOut);
      AppUtils.showSnackBar(StringValues.connTimedOut, StringValues.error);
    } on FormatException catch (e) {
      AppUtils.closeDialog();
      _isLoading.value = false;
      update();
      AppUtils.printLog(StringValues.formatExcError);
      AppUtils.printLog(e);
      AppUtils.showSnackBar(StringValues.errorOccurred, StringValues.error);
    } catch (exc) {
      AppUtils.closeDialog();
      _isLoading.value = false;
      update();
      AppUtils.printLog(StringValues.errorOccurred);
      AppUtils.printLog(exc);
      AppUtils.showSnackBar(StringValues.errorOccurred, StringValues.error);
    }
  }

  Future<void> login() async {
    AppUtils.closeFocus();
    await _login(
      emailTextController.text.trim(),
      passwordTextController.text.trim(),
    );
  }
}
