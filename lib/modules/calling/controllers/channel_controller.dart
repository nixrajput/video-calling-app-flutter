import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:video_calling_app/apis/providers/api_provider.dart';
import 'package:video_calling_app/apis/services/auth_service.dart';
import 'package:video_calling_app/constants/secrets.dart';
import 'package:video_calling_app/constants/strings.dart';
import 'package:video_calling_app/helpers/permissions.dart';
import 'package:video_calling_app/helpers/utils.dart';
import 'package:video_calling_app/routes/route_management.dart';
import 'package:wakelock/wakelock.dart';

class ChannelController extends GetxController {
  static ChannelController get find => Get.find();

  final _auth = AuthService.find;

  final _apiProvider = ApiProvider(http.Client());

  late RtcEngine _rtcEngine;

  bool _micToggle = false;
  bool _cameraToggle = false;
  bool _isConnecting = false;
  bool _switchRender = false;
  bool _showControls = true;

  late String _channelId;

  String _token = '';

  final List<int> _participants = [];

  bool get micToggle => _micToggle;

  bool get cameraToggle => _cameraToggle;

  bool get isConnecting => _isConnecting;

  bool get switchVideo => _switchRender;

  bool get showControls => _showControls;

  List<int> get participants => _participants;

  String get channelId => _channelId;

  Future<void> _getRtcToken() async {
    AppUtils.printLog("Get RTC Token Request...");

    try {
      final response =
          await _apiProvider.getRctToken(_channelId, _auth.agoraUid);

      final decodedData = jsonDecode(utf8.decode(response.bodyBytes));

      if (response.statusCode == 200) {
        _token = decodedData['key'];
      } else {
        AppUtils.showSnackBar(
          StringValues.noData,
          StringValues.error,
        );
      }
    } on SocketException {
      AppUtils.printLog(StringValues.internetConnError);
      AppUtils.showSnackBar(StringValues.internetConnError, StringValues.error);
    } on TimeoutException {
      AppUtils.printLog(StringValues.connTimedOut);
      AppUtils.printLog(StringValues.connTimedOut);
      AppUtils.showSnackBar(StringValues.connTimedOut, StringValues.error);
    } on FormatException catch (e) {
      AppUtils.printLog(StringValues.formatExcError);
      AppUtils.printLog(e);
      AppUtils.showSnackBar(StringValues.errorOccurred, StringValues.error);
    } catch (exc) {
      AppUtils.printLog(StringValues.errorOccurred);
      AppUtils.printLog(exc);
      AppUtils.showSnackBar(StringValues.errorOccurred, StringValues.error);
    }
  }

  void _addAgoraEventHandlers() {
    _rtcEngine.setEventHandler(
      RtcEngineEventHandler(
        error: (code) {
          final message = 'onError: $code';
          AppUtils.printLog(message);
          AppUtils.showSnackBar(message, 'error');
        },
        joinChannelSuccess: (channel, uid, elapsed) {
          final message = 'onJoinChannel: $channel, uid: $uid';
          AppUtils.printLog(message);
          AppUtils.showSnackBar("You joined.", 'success');
        },
        userJoined: (uid, elapsed) {
          final message = 'userJoined: $uid';
          AppUtils.printLog(message);
          _participants.add(uid);
          update();
          AppUtils.showSnackBar("$uid joined.", 'success');
        },
        userOffline: (uid, elapsed) {
          final message = 'userOffline: $uid reason: $elapsed';
          AppUtils.printLog(message);
          _participants.removeWhere((element) => element == uid);
          update();
          AppUtils.showSnackBar("$uid left.", 'warning');
        },
        leaveChannel: (stats) {
          final message = 'leaveChannel ${stats.toJson()}';
          AppUtils.printLog(message);
          _participants.clear();
          update();
        },
        connectionLost: () {
          const message = "Connection is poor or lost.";
          AppUtils.printLog(message);
          AppUtils.showSnackBar(message, 'warning');
        },
        connectionInterrupted: () {
          const message = "Connection is interrupted.";
          AppUtils.printLog(message);
          AppUtils.showSnackBar(message, 'warning');
        },
        userMuteAudio: (uid, audioMuted) {
          String message;
          if (audioMuted) {
            message = '$uid muted audio.';
          } else {
            message = '$uid unmuted audio.';
          }
          AppUtils.printLog(message);
          AppUtils.showSnackBar(message, 'warning');
        },
        userMuteVideo: (uid, videoMuted) {
          String message;
          if (videoMuted) {
            message = '$uid muted video.';
          } else {
            message = '$uid unmuted video.';
          }
          AppUtils.printLog(message);
          AppUtils.showSnackBar(message, 'warning');
        },
      ),
    );
  }

  void leaveChannel() async {
    await _rtcEngine.leaveChannel();
    update();
    RouteManagement.goToBack();
  }

  void toggleMuteVideo() {
    _cameraToggle = !_cameraToggle;
    _rtcEngine.muteLocalVideoStream(_cameraToggle);

    AppUtils.printLog("Camera: $_cameraToggle");
    update();
  }

  void toggleMuteAudio() {
    _micToggle = !_micToggle;
    _rtcEngine.muteLocalAudioStream(_micToggle);
    AppUtils.printLog("Mic: $_micToggle");
    update();
  }

  void switchCamera() {
    _rtcEngine.switchCamera();
    update();
  }

  void switchVideoRender() {
    _switchRender = !_switchRender;
    update();
  }

  void toggleShowControls() {
    _showControls = !_showControls;
    update();
  }

  Future<void> _initAgoraRtcEngine() async {
    await Wakelock.enable();
    _rtcEngine = await RtcEngine.create(AppSecrets.appId);
    _addAgoraEventHandlers();

    await _rtcEngine.enableVideo();
    await _rtcEngine.setChannelProfile(ChannelProfile.LiveBroadcasting);
    await _rtcEngine.setClientRole(ClientRole.Broadcaster);
  }

  Future<void> _init() async {
    var cameraPerm = await AppPermissions.checkCameraPermission();
    var micPerm = await AppPermissions.checkMicPermission();

    if (!cameraPerm || !micPerm) {
      RouteManagement.goToBack();
      return;
    }

    _isConnecting = true;
    update();

    await _getRtcToken().then((_) async {
      await _initAgoraRtcEngine();
      await _rtcEngine.joinChannel(
        _token,
        _channelId,
        null,
        int.parse(_auth.agoraUid),
      );
      _isConnecting = false;
      update();
    });
  }

  @override
  void onInit() {
    super.onInit();
    _channelId = Get.arguments[0] ?? _auth.channelId;
    _cameraToggle = Get.arguments[1] ?? false;
    _micToggle = Get.arguments[2] ?? false;
    AppUtils.printLog("Mic: $_micToggle");
    AppUtils.printLog("Camera: $_cameraToggle");
    _init();
  }

  @override
  void onClose() {
    _rtcEngine.leaveChannel();
    _rtcEngine.destroy();
    super.onClose();
  }
}
