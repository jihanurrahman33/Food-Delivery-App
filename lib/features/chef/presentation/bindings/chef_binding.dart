import 'package:get/get.dart';
import '../controllers/chef_controller.dart';

class ChefBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChefController>(() => ChefController());
  }
}
