import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'controllers/coaching_controller.dart';

class CoachingBookingScreen extends StatelessWidget {
  CoachingBookingScreen({Key? key}) : super(key: key);

  final CoachingController controller = Get.put(CoachingController());
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Apply For Coaching',
          style: TextStyle(
            fontSize: 18,
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.isLoading.value && controller.coaches.isEmpty) {
          return Center(child: CircularProgressIndicator(color: Colors.black));
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Coach type selector
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: controller.coaches.map((coach) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: _buildCoachTypeChip(
                        coach.name,
                        coach.description,
                        controller.selectedCoachId.value == coach.id,
                        () => controller.selectCoach(coach.id),
                      ),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 32),

              // Divider line
              Container(
                height: 1,
                color: Colors.grey[300],
                margin: const EdgeInsets.symmetric(vertical: 16),
              ),

              if (controller.isLoading.value)
                Center(
                    child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: CircularProgressIndicator(color: Colors.black),
                ))
              else ...[
                // Pick a Convenient Date
                Text(
                  'Pick a Convenient Date',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 24),

                // Calendar
                _buildCalendar(context),
                const SizedBox(height: 24),

                // Selected date display
                if (controller.selectedDate.value != null) ...[
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey[300]!),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Icon(Icons.calendar_today, size: 16),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        DateFormat('dd MMM, yyyy')
                            .format(controller.selectedDate.value!),
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                ],

                // Select a Suitable Time Slot
                if (controller.availableSlots.isNotEmpty) ...[
                  Text(
                    'Select a Suitable Time Slot',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 4),
                  if (controller.selectedDate.value != null)
                    Text(
                      DateFormat('EEEE, dd MMMM')
                          .format(controller.selectedDate.value!),
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[500],
                      ),
                    ),
                  const SizedBox(height: 16),

                  // Time slots
                  Column(
                    children: controller.availableSlots.map((slot) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: _buildTimeSlot(
                          slot.value,
                          controller.selectedSlot.value?.id == slot.id,
                          slot.flag == 0,
                          () => controller.selectSlot(slot),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 24),
                ] else if (controller.selectedDate.value != null) ...[
                  Text(
                    'No slots available for this date',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[500],
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  const SizedBox(height: 24),
                ],

                // Divider line
                Container(
                  height: 1,
                  color: Colors.grey[300],
                  margin: const EdgeInsets.symmetric(vertical: 16),
                ),

                // Summary
                if (controller.selectedDate.value != null &&
                    controller.selectedSlot.value != null) ...[
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey[300]!),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Icon(Icons.calendar_today, size: 16),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        DateFormat('dd MMM, yyyy')
                            .format(controller.selectedDate.value!),
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey[300]!),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Icon(Icons.access_time, size: 16),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        controller.selectedSlot.value!.value,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                ],

                // Enter details
                Text(
                  'Enter details',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 16),

                // Name field
                Text(
                  'Name*',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[700],
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    hintText: 'Enter Your Name...',
                    hintStyle: TextStyle(color: Colors.grey[400]),
                    prefixIcon:
                        Icon(Icons.person_outline, color: Colors.grey[400]),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey[300]!),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey[300]!),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  ),
                ),
                const SizedBox(height: 16),

                // Email field
                Text(
                  'E-Mail-Address *',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[700],
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    hintText: 'example@xyz.com',
                    hintStyle: TextStyle(color: Colors.grey[400]),
                    prefixIcon:
                        Icon(Icons.email_outlined, color: Colors.grey[400]),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey[300]!),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey[300]!),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  ),
                ),
                const SizedBox(height: 32),

                // Confirm Appointment button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      controller.apply(
                          nameController.text, emailController.text);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      'Confirm Appointment',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        );
      }),
    );
  }

  Widget _buildCoachTypeChip(
      String name, String desc, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? Colors.black : Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey[300]!),
        ),
        child: Column(
          children: [
            Text(
              name,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                color: isSelected ? Colors.white : Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              desc,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 10,
                color: isSelected ? Colors.white70 : Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCalendar(BuildContext context) {
    final now = controller.currentMonth.value;
    final daysInMonth = DateUtils.getDaysInMonth(now.year, now.month);
    final firstDayOfMonth = DateTime(now.year, now.month, 1);

    final offset = (firstDayOfMonth.weekday + 1) % 7;

    final List<Widget> dayWidgets = [];

    // Empty slots for offset
    for (int i = 0; i < offset; i++) {
      dayWidgets.add(Container(width: 40, height: 40));
    }

    // Days
    for (int i = 1; i <= daysInMonth; i++) {
      final date = DateTime(now.year, now.month, i);
      final isAvailable = controller.isDateAvailable(date);
      final isSelected = controller.selectedDate.value != null &&
          DateFormat('dd-MM-yyyy').format(controller.selectedDate.value!) ==
              DateFormat('dd-MM-yyyy').format(date);
      final isToday = DateFormat('dd-MM-yyyy').format(DateTime.now()) ==
          DateFormat('dd-MM-yyyy').format(date);

      dayWidgets.add(
        GestureDetector(
          onTap: () {
            if (isAvailable) {
              controller.selectDate(date);
            } else {
              // Optional: Show unavailable message or just do nothing
              // Get.snackbar('Unavailable', 'No slots available for this date', snackPosition: SnackPosition.BOTTOM);
            }
          },
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: isSelected
                  ? Colors.black
                  : (isAvailable ? Colors.green : Colors.transparent),
              shape: BoxShape.circle,
              border: isToday && !isSelected && !isAvailable
                  ? Border.all(color: Colors.black)
                  : null,
            ),
            child: Center(
              child: Text(
                i.toString(),
                style: TextStyle(
                  fontSize: 14,
                  color: isSelected
                      ? Colors.white
                      : (isAvailable ? Colors.white : Colors.grey[400]),
                  fontWeight: isSelected || isToday || isAvailable
                      ? FontWeight.w600
                      : FontWeight.normal,
                ),
              ),
            ),
          ),
        ),
      );
    }

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(Icons.chevron_left, color: Colors.black),
              onPressed: () {
                controller.currentMonth.value =
                    DateTime(now.year, now.month - 1);
              },
            ),
            Text(
              DateFormat('MMMM yyyy').format(now),
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.black,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: Icon(Icons.chevron_right, color: Colors.white),
                onPressed: () {
                  controller.currentMonth.value =
                      DateTime(now.year, now.month + 1);
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // Week days header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: ['Sat', 'Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri']
              .map((day) => Container(
                    width: 40,
                    child: Text(
                      day,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ))
              .toList(),
        ),
        const SizedBox(height: 16),

        // Calendar Grid
        GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: dayWidgets.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7,
            mainAxisSpacing: 8,
            crossAxisSpacing: 0,
          ),
          itemBuilder: (context, index) {
            return Center(child: dayWidgets[index]);
          },
        ),
      ],
    );
  }

  Widget _buildTimeSlot(
      String timeRange, bool isSelected, bool isAvailable, VoidCallback onTap) {
    return GestureDetector(
      onTap: isAvailable ? onTap : null,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected
              ? Colors.black
              : (isAvailable ? Colors.grey[200] : Colors.grey[100]),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          timeRange,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14,
            color: isSelected
                ? Colors.white
                : (isAvailable ? Colors.grey[700] : Colors.grey[400]),
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
