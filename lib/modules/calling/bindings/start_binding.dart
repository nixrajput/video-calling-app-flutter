import 'package:get/get.dart';
import 'package:video_calling_app/modules/calling/controllers/start_channel_controller.dart';

class StartBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(StartChannelController.new);
  }
}
