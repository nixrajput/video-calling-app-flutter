import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:video_calling_app/apis/providers/api_provider.dart';
import 'package:video_calling_app/apis/services/auth_service.dart';
import 'package:video_calling_app/constants/strings.dart';
import 'package:video_calling_app/helpers/utils.dart';

class ChangePasswordController extends GetxController {
  static ChangePasswordController get find => Get.find();

  final _auth = AuthService.find;

  final _apiProvider = ApiProvider(http.Client());

  final oldPasswordTextController = TextEditingController();
  final newPasswordTextController = TextEditingController();
  final confirmPasswordTextController = TextEditingController();

  final FocusScopeNode focusNode = FocusScopeNode();

  final _isLoading = false.obs;
  final _showPassword = true.obs;
  final _showNewPassword = true.obs;

  bool get isLoading => _isLoading.value;

  bool get showPassword => _showPassword.value;

  bool get showNewPassword => _showNewPassword.value;

  void toggleViewPassword() {
    _showPassword(!_showPassword.value);
    update();
  }

  void toggleViewNewPassword() {
    _showNewPassword(!_showNewPassword.value);
    update();
  }

  Future<void> _changePassword(
    String oldPassword,
    String newPassword,
    String confPassword,
  ) async {
    if (oldPassword.isEmpty) {
      AppUtils.showSnackBar(
        StringValues.enterOldPassword,
        StringValues.warning,
      );
      return;
    }
    if (newPassword.isEmpty) {
      AppUtils.showSnackBar(
        StringValues.enterNewPassword,
        StringValues.warning,
      );
      return;
    }
    if (confPassword.isEmpty) {
      AppUtils.showSnackBar(
        StringValues.enterConfirmPassword,
        StringValues.warning,
      );
      return;
    }

    final body = {
      'oldPassword': oldPassword,
      'newPassword': newPassword,
      'confirmPassword': confPassword,
    };

    AppUtils.printLog("Change Password Request...");
    AppUtils.showLoadingDialog();
    _isLoading.value = true;
    update();

    try {
      final response = await _apiProvider.changePassword(body, _auth.authToken);

      final decodedData = jsonDecode(utf8.decode(response.bodyBytes));

      if (response.statusCode == 200) {
        await _auth.logout();
        AppUtils.closeDialog();
        _isLoading.value = false;
        update();
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

  Future<void> changePassword() async {
    AppUtils.closeFocus();
    await _changePassword(
      oldPasswordTextController.text.trim(),
      newPasswordTextController.text.trim(),
      confirmPasswordTextController.text.trim(),
    );
  }
}
