import 'package:get/get.dart';
import 'package:video_calling_app/modules/auth/controllers/password_controller.dart';

class PasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(PasswordController.new);
  }
}
