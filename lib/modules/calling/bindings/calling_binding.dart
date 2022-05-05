import 'package:get/get.dart';
import 'package:video_calling_app/modules/calling/controllers/calling_controller.dart';

class CallingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(CallingController.new);
  }
}
