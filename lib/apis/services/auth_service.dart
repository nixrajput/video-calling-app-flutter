import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:get/get.dart';
import 'package:video_calling_app/constants/strings.dart';
import 'package:video_calling_app/helpers/utils.dart';
import 'package:video_calling_app/routes/route_management.dart';

class AuthService extends GetxService {
  static AuthService get find => Get.find();

  String _authToken = '';
  String _expiresAt = '';
  String _channelId = '';
  String _agoraUid = '';
  StreamSubscription<dynamic>? _streamSubscription;

  String get authToken => _authToken;

  String get expiresAt => _expiresAt;

  String get channelId => _channelId;

  String get agoraUid => _agoraUid;

  set setAuthToken(String value) => _authToken = value;

  set setExpiresAt(String value) => _expiresAt = value;

  set setChannelId(String value) => _channelId = value;

  set setAgoraUid(String value) => _agoraUid = value;

  Future<String> getToken() async {
    var _token = '';
    final decodedData = await AppUtils.readLoginDataFromLocalStorage();
    if (decodedData != null) {
      _expiresAt = decodedData[StringValues.expiresAt];
      setAuthToken = decodedData[StringValues.token];
      _token = decodedData[StringValues.token];
      autoLogout();
    }
    return _token;
  }

  Future<void> getChannelInfo() async {
    final decodedData = await AppUtils.readChannelDataFromLocalStorage();
    if (decodedData != null) {
      setChannelId = decodedData[StringValues.channelId].toString();
      setAgoraUid = decodedData[StringValues.agoraUid].toString();
    }
  }

  void autoLogout() async {
    if (_expiresAt.isNotEmpty) {
      var _currentTimestamp =
          (DateTime.now().millisecondsSinceEpoch / 1000).round();
      if (int.parse(_expiresAt) < _currentTimestamp) {
        await _logout();
      }
    }
    // if (_profileData.value.user != null) {
    //   if (_profileData.value.user!.token == _token.value) {
    //     await _logout();
    //     AppUtils.showSnackBar(
    //       StringValues.tokenError,
    //       StringValues.error,
    //     );
    //   }
    // }
  }

  Future<void> _logout() async {
    RouteManagement.goToLoginView();
    setAuthToken = '';
    await AppUtils.clearLoginDataFromLocalStorage();
    AppUtils.showSnackBar(
      StringValues.logoutSuccessful,
      StringValues.success,
    );
  }

  Future<void> logout() async => await _logout();

  void _checkForInternetConnectivity() {
    _streamSubscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) async {
      if (result != ConnectivityResult.none) {
        AppUtils.closeDialog();
      } else {
        AppUtils.showNoInternetDialog();
      }
    });
  }

  @override
  onInit() async {
    _checkForInternetConnectivity();
    super.onInit();
  }

  @override
  onClose() {
    _streamSubscription?.cancel();
    super.onClose();
  }
}
