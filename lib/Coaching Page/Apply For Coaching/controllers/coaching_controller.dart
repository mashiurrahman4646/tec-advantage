import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../models/coach_model.dart';
import '../services/coaching_api_service.dart';

class CoachingController extends GetxController {
  final isLoading = false.obs;
  final coaches = <CoachModel>[].obs;
  final selectedCoach = Rxn<CoachDetailsModel>();
  final selectedCoachId = RxnString();

  final currentMonth = DateTime.now().obs;
  final selectedDate = Rxn<DateTime>();
  final availableSlots = <TimeSlot>[].obs;
  final selectedSlot = Rxn<TimeSlot>();

  @override
  void onInit() {
    super.onInit();
    fetchCoaches();
  }

  Future<void> fetchCoaches() async {
    isLoading(true);
    final result = await CoachingApiService.getCoaches();
    if (result != null) {
      coaches.value = result;
      // Select the first coach by default if available
      if (coaches.isNotEmpty) {
        selectCoach(coaches.first.id);
      }
    }
    isLoading(false);
  }

  Future<void> selectCoach(String id) async {
    selectedCoachId.value = id;
    selectedDate.value = null;
    selectedSlot.value = null;
    availableSlots.clear();

    isLoading(true);
    final details = await CoachingApiService.getCoachDetails(id);
    if (details != null) {
      selectedCoach.value = details;
    }
    isLoading(false);
  }

  void selectDate(DateTime date) {
    // Toggle if same date is tapped again
    if (selectedDate.value != null &&
        DateFormat('dd-MM-yyyy').format(selectedDate.value!) ==
            DateFormat('dd-MM-yyyy').format(date)) {
      selectedDate.value = null;
      selectedSlot.value = null;
      availableSlots.clear();
    } else {
      selectedDate.value = date;
      selectedSlot.value = null;
      updateAvailableSlots(date);
    }
  }

  void updateAvailableSlots(DateTime date) {
    if (selectedCoach.value == null) return;

    final formattedDate = DateFormat('dd-MM-yyyy').format(date);

    // Find availability for the selected date
    final availability = selectedCoach.value!.details.firstWhere(
      (element) => element.date == formattedDate,
      orElse: () => CoachAvailability(date: '', id: '', slots: []),
    );

    // Filter slots where flag is 0 (available)
    // Actually, user wants to see all slots but maybe disable unavailable ones?
    // "flag 0 mane holo ai date a availeble ase and 1 hole availeble nai"
    // "date select korle se value te time deya ase oitaw dekhte parbe select korte parbe"
    // I will show all slots but maybe visually distinguish or only allow selecting flag 0.
    // For now, let's load all slots for that date.
    availableSlots.value = availability.slots;
  }

  void selectSlot(TimeSlot slot) {
    if (slot.flag == 0) {
      selectedSlot.value = slot;
    } else {
      Get.snackbar('Unavailable', 'This slot is not available',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  bool isDateAvailable(DateTime date) {
    if (selectedCoach.value == null) return false;
    final formattedDate = DateFormat('dd-MM-yyyy').format(date);
    return selectedCoach.value!.details
        .any((element) => element.date == formattedDate);
  }

  Future<void> apply(String name, String email) async {
    if (selectedCoachId.value == null) {
      Get.snackbar('Error', 'Please select a coach',
          snackPosition: SnackPosition.BOTTOM);
      return;
    }
    if (selectedDate.value == null) {
      Get.snackbar('Error', 'Please select a date',
          snackPosition: SnackPosition.BOTTOM);
      return;
    }
    if (selectedSlot.value == null) {
      Get.snackbar('Error', 'Please select a time slot',
          snackPosition: SnackPosition.BOTTOM);
      return;
    }
    if (name.isEmpty || email.isEmpty) {
      Get.snackbar('Error', 'Please enter name and email',
          snackPosition: SnackPosition.BOTTOM);
      return;
    }

    isLoading(true);
    final formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate.value!);
    final success = await CoachingApiService.applyForCoaching(
      coachId: selectedCoachId.value!,
      name: name,
      email: email,
      date: formattedDate,
      timeRange: selectedSlot.value!.value,
    );

    isLoading(false);

    if (success) {
      Get.snackbar('Success', 'Appointment Confirmed!',
          snackPosition: SnackPosition.BOTTOM);
      // Optional: Clear selection or navigate away
    } else {
      Get.snackbar('Error', 'Failed to confirm appointment',
          snackPosition: SnackPosition.BOTTOM);
    }
  }
}
