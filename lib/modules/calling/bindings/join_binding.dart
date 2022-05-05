import 'package:get/get.dart';
import 'package:video_calling_app/modules/calling/controllers/join_channel_controller.dart';

class JoinBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(JoinChannelController.new);
  }
}
