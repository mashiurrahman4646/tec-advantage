import 'package:get/get.dart';

class SmallBusinessSectionSelectionController extends GetxController {
  final selectedSection = RxnString();

  final sections = const [
    {'title': 'Business Overview', 'slug': 'business-overview'},
    {'title': 'Aspiring Business', 'slug': 'aspiring-business'},
    {'title': 'Current Processes & Pain Points', 'slug': 'current-processes-pain-points'},
    {'title': 'Operations & Growth', 'slug': 'operations-growth'},
  ];

  void select(String slug) {
    selectedSection.value = slug;
  }
}