import 'package:get/get.dart';
import 'package:video_calling_app/modules/profile/controllers/edit_name_controller.dart';

class EditNameBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(EditNameController.new);
  }
}
