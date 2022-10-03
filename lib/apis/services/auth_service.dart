import 'dart:async';
import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:video_calling_app/apis/providers/api_provider.dart';
import 'package:video_calling_app/constants/strings.dart';
import 'package:video_calling_app/helpers/utility.dart';

class AuthService extends GetxService {
  static AuthService get find => Get.find();

  final _apiProvider = ApiProvider(http.Client());

  String _authToken = '';
  int _expiresAt = 0;
  int _channelId = 0;
  String _agoraUid = '';
  StreamSubscription<dynamic>? _streamSubscription;

  String get authToken => _authToken;

  int get expiresAt => _expiresAt;

  int get channelId => _channelId;

  String get agoraUid => _agoraUid;

  set setAuthToken(String value) => _authToken = value;

  set setExpiresAt(int value) => _expiresAt = value;

  set setChannelId(int value) => _channelId = value;

  set setAgoraUid(String value) => _agoraUid = value;

  Future<String> getToken() async {
    var token = '';
    final decodedData = await AppUtility.readLoginDataFromLocalStorage();
    if (decodedData != null) {
      _expiresAt = decodedData[StringValues.expiresAt];
      setAuthToken = decodedData[StringValues.token];
      token = decodedData[StringValues.token];
      await getChannelInfo();
    }
    return token;
  }

  Future<void> getChannelInfo() async {
    final decodedData = await AppUtility.readChannelDataFromLocalStorage();
    if (decodedData != null) {
      setChannelId = decodedData[StringValues.channelId];
      setAgoraUid = decodedData[StringValues.agoraUid].toString();
    }
    AppUtility.printLog("channelId: $_channelId");
    AppUtility.printLog("agoraUid: $_agoraUid");
  }

  Future<String> _checkServerHealth() async {
    AppUtility.printLog('Check Server Health Request');
    var serverHealth = 'offline';
    try {
      final response = await _apiProvider.checkServerHealth();

      final decodedData = jsonDecode(utf8.decode(response.bodyBytes));
      AppUtility.printLog(decodedData);
      if (response.statusCode == 200) {
        AppUtility.printLog('Check Server Health Success');
        serverHealth = decodedData['server'];
      } else {
        AppUtility.printLog('Check Server Health Error');
        serverHealth = decodedData['server'];
      }
    } catch (exc) {
      AppUtility.printLog('Check Server Health Error');
      AppUtility.printLog(StringValues.errorOccurred);
      AppUtility.printLog(exc);
    }

    return serverHealth;
  }

  Future<bool> _validateToken(String token) async {
    var isValid = false;
    try {
      final response = await _apiProvider.validateToken(token);

      final decodedData = jsonDecode(utf8.decode(response.bodyBytes));
      AppUtility.printLog(decodedData);
      if (response.statusCode == 200) {
        isValid = true;
        AppUtility.printLog(decodedData[StringValues.message]);
      } else {
        AppUtility.printLog(decodedData[StringValues.message]);
      }
    } catch (exc) {
      AppUtility.printLog(StringValues.errorOccurred);
      AppUtility.printLog(exc);
    }

    return isValid;
  }

  void autoLogout() async {
    if (_expiresAt > 0) {
      var currentTimestamp =
          (DateTime.now().millisecondsSinceEpoch / 1000).round();
      if (_expiresAt < currentTimestamp) {
        setAuthToken = '';
        setExpiresAt = 0;
        await AppUtility.clearLoginDataFromLocalStorage();
      }
    }
  }

  Future<void> _logout(bool showLoading) async {
    AppUtility.printLog("Logout Request");
    setAuthToken = '';
    setExpiresAt = 0;
    await AppUtility.clearLoginDataFromLocalStorage();
    AppUtility.printLog("Logout Success");
  }

  void _checkForInternetConnectivity() {
    _streamSubscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) async {
      if (result != ConnectivityResult.none) {
        AppUtility.closeDialog();
      } else {
        AppUtility.showNoInternetDialog();
      }
    });
  }

  Future<void> logout({showLoading = false}) async =>
      await _logout(showLoading);

  Future<bool> validateToken(String token) async => await _validateToken(token);

  Future<String> checkServerHealth() async => await _checkServerHealth();

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
