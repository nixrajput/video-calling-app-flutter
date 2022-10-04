import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:video_calling_app/apis/models/responses/profile_response.dart';
import 'package:video_calling_app/apis/providers/api_provider.dart';
import 'package:video_calling_app/apis/services/auth_service.dart';
import 'package:video_calling_app/constants/strings.dart';
import 'package:video_calling_app/helpers/utility.dart';

class ProfileController extends GetxController {
  static ProfileController get find => Get.find();

  final _apiProvider = ApiProvider(http.Client());

  final _auth = AuthService.find;

  final _isLoading = false.obs;
  final _profileDetails = ProfileResponse().obs;

  bool get isLoading => _isLoading.value;

  ProfileResponse? get profileDetails => _profileDetails.value;

  set setProfileData(ProfileResponse value) {
    _profileDetails.value = value;
  }

  Future<bool> _getProfileDetails() async {
    AppUtility.printLog("Fetching Local Profile Details...");

    final decodedData = await AppUtility.readProfileDataFromLocalStorage();
    if (decodedData != null) {
      setProfileData = ProfileResponse.fromJson(decodedData);
      return true;
    } else {
      AppUtility.printLog(StringValues.profileDetailsNotFound);
    }
    return false;
  }

  Future<void> _fetchProfileDetails() async {
    _isLoading.value = true;
    update();
    AppUtility.printLog("Fetching Profile Details Request...");
    try {
      final response = await _apiProvider.getProfileDetails(_auth.authToken);

      final decodedData = jsonDecode(utf8.decode(response.bodyBytes));

      if (response.statusCode == 200) {
        setProfileData = ProfileResponse.fromJson(decodedData);
        await AppUtility.saveProfileDataToLocalStorage(decodedData);
        _isLoading.value = false;
        update();
      } else {
        _isLoading.value = false;
        update();
        AppUtility.showSnackBar(
          decodedData[StringValues.message],
          StringValues.error,
        );
      }
    } on SocketException {
      _isLoading.value = false;
      update();
      AppUtility.printLog(StringValues.internetConnError);
      AppUtility.showSnackBar(
          StringValues.internetConnError, StringValues.error);
    } on TimeoutException {
      _isLoading.value = false;
      update();
      AppUtility.printLog(StringValues.connTimedOut);
      AppUtility.showSnackBar(StringValues.connTimedOut, StringValues.error);
    } on FormatException catch (e) {
      _isLoading.value = false;
      update();
      AppUtility.printLog(StringValues.formatExcError);
      AppUtility.printLog(e);
      AppUtility.showSnackBar(StringValues.errorOccurred, StringValues.error);
    } catch (exc) {
      _isLoading.value = false;
      update();
      AppUtility.printLog(StringValues.errorOccurred);
      AppUtility.printLog(exc);
      AppUtility.showSnackBar(StringValues.errorOccurred, StringValues.error);
    }
  }

  Future<bool> getProfileDetails() async => await _getProfileDetails();

  Future<void> fetchProfileDetails() async => await _fetchProfileDetails();
}
