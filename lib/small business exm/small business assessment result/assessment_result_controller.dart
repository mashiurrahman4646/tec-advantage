import 'package:get/get.dart';
import '../../services/network_caller.dart';

class AssessmentResultController extends GetxController {
  final int value;
  AssessmentResultController({required this.value});

  final loading = true.obs;
  final error = RxnString();
  final data = Rxn<Map<String, dynamic>>();

  @override
  void onInit() {
    super.onInit();
    fetch();
  }

  Future<void> fetch() async {
    loading.value = true;
    error.value = null;
    final caller = NetworkCaller();
    final res = await caller.get('/small/business/assessments/by-range', params: {'value': value});
    if (res.isSuccess) {
      final Map<String, dynamic>? d = res.responseData?['data'] as Map<String, dynamic>?;
      data.value = d ?? {};
    } else {
      error.value = res.errorMessage;
    }
    loading.value = false;
  }
}