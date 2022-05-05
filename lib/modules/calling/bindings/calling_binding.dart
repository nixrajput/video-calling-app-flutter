import 'package:get/get.dart';
import 'package:video_calling_app/modules/calling/controllers/channel_controller.dart';

class CallingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(ChannelController.new);
  }
}
