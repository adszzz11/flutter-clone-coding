import 'package:flutter_clone_insta/src/controller/bottom_nav_controller.dart';
import 'package:get/get.dart';

class InitBinding extends Bindings {


  @override
  void dependencies() {
    Get.put(BottomNavController(), permanent: true);

  }
}
