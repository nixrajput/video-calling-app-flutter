import 'package:get/get.dart';
import 'package:video_calling_app/modules/profile/controllers/profile_controller.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(ProfileController.new, fenix: true);
  }
}
