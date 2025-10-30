// success_path_selection/success_path_selection_controller.dart
import 'package:get/get.dart';

class SuccessPathSelectionController extends GetxController {
  var selectedPath = Rx<String?>(null);

  void selectPath(String path) {
    selectedPath.value = path;
  }

  void navigateToSelectedPath() {
    if (selectedPath.value == null) return;

    switch (selectedPath.value) {
      case 'Small Business Owner':
        Get.toNamed('/small-business-assessment');
        break;
      case 'Aspiring Entrepreneur':
        Get.toNamed('/aspiring-entrepreneur-assessment');
        break;
      case 'Looking to Get Into Tech':
        Get.toNamed('/tech-career-assessment');
        break;
    }
  }
}