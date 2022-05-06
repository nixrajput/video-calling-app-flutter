import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class JoinChannelController extends GetxController {
  static JoinChannelController get find => Get.find();

  final channelIdTextController = TextEditingController();

  bool _micToggle = false;
  bool _cameraToggle = false;

  bool get micToggle => _micToggle;

  bool get cameraToggle => _cameraToggle;

  void enableVideo(value) {
    _cameraToggle = !value;
    update();
  }

  void enableAudio(value) {
    _micToggle = !value;
    update();
  }
}
