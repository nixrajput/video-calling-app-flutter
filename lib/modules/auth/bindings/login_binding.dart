import 'package:get/get.dart';
import 'package:video_calling_app/modules/auth/controllers/login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(LoginController.new);
  }
}
