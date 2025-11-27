import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/business_plan_controller.dart';
import 'business_plan_quiz_screen.dart';

class BusinessPlanOverviewScreen extends StatelessWidget {
  BusinessPlanOverviewScreen({Key? key}) : super(key: key);

  final controller = Get.put(BusinessPlanController());

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
          'Business Planning',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    'Business Overview',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 12),

                  // Progress Bar
                  LinearProgressIndicator(
                    value: 0.5, // Step 1 of 2
                    minHeight: 6,
                    backgroundColor: Colors.grey[200],
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                    borderRadius: BorderRadius.circular(3),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Step 1 of 2',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: 32),

                  // Form Fields
                  _buildTextField(
                    label: 'Business Name *',
                    controller: controller.businessNameController,
                    hint: 'Enter your business name',
                  ),
                  SizedBox(height: 20),
                  _buildTextField(
                    label: 'Business Type *',
                    controller: controller.businessTypeController,
                    hint: 'e.g., Technology, Retail, Service',
                  ),
                  SizedBox(height: 20),
                  _buildTextField(
                    label: 'Mission',
                    controller: controller.missionController,
                    hint: 'What is your business mission?',
                    maxLines: 3,
                  ),
                  SizedBox(height: 20),
                  _buildTextField(
                    label: 'Vision',
                    controller: controller.visionController,
                    hint: 'What is your business vision?',
                    maxLines: 3,
                  ),
                ],
              ),
            ),
          ),
          // Next Button
          Padding(
            padding: const EdgeInsets.all(20),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  // Basic validation
                  if (controller.businessNameController.text.isEmpty ||
                      controller.businessTypeController.text.isEmpty) {
                    Get.snackbar('Error', 'Please fill in required fields',
                        snackPosition: SnackPosition.BOTTOM);
                    return;
                  }
                  Get.to(() => BusinessPlanQuizScreen());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Next Step',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required String hint,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 8),
        TextField(
          controller: controller,
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: Colors.grey[400]),
            filled: true,
            fillColor: Colors.grey[50],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey[200]!),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey[200]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.black),
            ),
          ),
        ),
      ],
    );
  }
}
