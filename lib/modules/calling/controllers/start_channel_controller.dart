import 'package:get/get.dart';

class StartChannelController extends GetxController {
  static StartChannelController get find => Get.find();

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
