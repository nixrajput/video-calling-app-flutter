import 'package:get/get.dart';
import 'package:video_calling_app/modules/auth/controllers/register_controller.dart';

class RegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(RegisterController.new);
  }
}
