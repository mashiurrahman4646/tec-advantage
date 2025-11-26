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
        Get.toNamed('/success-path-assessment', arguments: {'slug': 'small-business'});
        break;
      case 'Aspiring Entrepreneur':
        Get.toNamed('/success-path-assessment', arguments: {'slug': 'aspiring-entrepreneur'});
        break;
      case 'Looking to Get Into Tech':
        Get.toNamed('/success-path-assessment', arguments: {'slug': 'looking-to-get-into-tech'});
        break;
    }
  }
}