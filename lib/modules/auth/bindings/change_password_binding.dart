import 'package:get/get.dart';
import 'package:video_calling_app/modules/auth/controllers/change_password_controller.dart';

class ChangePasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(ChangePasswordController.new);
  }
}
