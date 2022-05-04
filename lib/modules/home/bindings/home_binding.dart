import 'package:get/get.dart';
import 'package:video_calling_app/modules/home/controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(HomeController.new);
  }
}
