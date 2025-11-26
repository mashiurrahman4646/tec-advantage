import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../mockinterviewresult/mockinterviewresult.dart';
import 'mock_interview_controller.dart';

class MockInterviewAssessment extends StatelessWidget {
  const MockInterviewAssessment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final c = Get.isRegistered<MockInterviewController>()
        ? Get.find<MockInterviewController>()
        : Get.put(MockInterviewController(), permanent: true);
    final pageController = PageController();

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 8,
              left: 16,
              right: 16,
              bottom: 0,
            ),
            color: Colors.white,
            child: Column(
              children: [
                Container(
                  height: 48,
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.black, size: 24),
                        onPressed: () => Get.back(),
                        padding: EdgeInsets.zero,
                        constraints: BoxConstraints(minWidth: 40, minHeight: 40),
                      ),
                      Expanded(
                        child: Text(
                          'Discover Your Strengths',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(width: 40),
                    ],
                  ),
                ),

                SizedBox(height: 16),

                Container(
                  width: double.infinity,
                  child: Obx(() => Text(
                    c.loading.value || c.questions.isEmpty
                        ? 'Loading questions...'
                        : 'Question ${c.currentPage.value + 1} to ${c.questions.length}',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.black87,
                    ),
                  )),
                ),

                SizedBox(height: 12),

                Container(
                  height: 4,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Color(0xFFE0E0E0),
                    borderRadius: BorderRadius.circular(2),
                  ),
                  child: Obx(() => FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: c.questions.isEmpty ? 0 : (c.currentPage.value + 1) / c.questions.length,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  )),
                ),

                SizedBox(height: 24),
              ],
            ),
          ),

          Expanded(
            child: Obx(() => c.loading.value
                ? Center(child: CircularProgressIndicator())
                : (c.error.value != null
                    ? Center(child: Text(c.error.value!, style: TextStyle(color: Colors.red)))
                    : PageView.builder(
                        controller: pageController,
                        itemCount: c.questions.length,
                        onPageChanged: (int page) {
                          c.onPageChanged(page);
                        },
                        itemBuilder: (context, index) {
                          return _buildQuestionPage(c, c.questions[index]);
                        },
                      ))),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              spreadRadius: 0,
              blurRadius: 8,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: SafeArea(
          child: Row(
            children: [
              Expanded(
                child: Container(
                  height: 48,
                  child: OutlinedButton(
                    onPressed: c.currentPage.value > 0 ? () {
                      pageController.previousPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    } : null,
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Colors.grey[300]!, width: 1),
                      foregroundColor: Colors.black54,
                      backgroundColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      'Back',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Container(
                  height: 48,
                  child: Obx(() => ElevatedButton(
                    onPressed: c.canProceed ? () {
                      c.selectedIndices[c.currentPage.value] = c.selectedIndex.value;
                      if (c.currentPage.value < c.questions.length - 1) {
                        pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      } else {
                        final total = c.computeTotalScore();
                        Get.to(() => const MockInterviewResults(), arguments: {'score': total});
                      }
                    } : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: c.canProceed ? Colors.black : Colors.grey[300],
                      foregroundColor: c.canProceed ? Colors.white : Colors.grey[500],
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Obx(() => Text(
                          c.currentPage.value < c.questions.length - 1 ? 'Next' : 'Submit',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        )),
                        const SizedBox(width: 6),
                        Icon(
                          Icons.arrow_forward,
                          size: 18,
                        ),
                      ],
                    ),
                  )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuestionPage(MockInterviewController c, Map<String, dynamic> questionData) {
    return Obx(() => SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            questionData['question'],
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w600,
              color: Colors.black,
              height: 1.3,
            ),
          ),
          const SizedBox(height: 24),
          ...List.generate((questionData['answers'] as List).length, (index) {
            final isSelected = c.selectedIndex.value == index;
            return Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: GestureDetector(
                onTap: () {
                  c.selectAnswer(index);
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: isSelected ? Colors.blue : Color(0xFFE5E7EB),
                      width: isSelected ? 2 : 1,
                    ),
                    boxShadow: isSelected ? [
                      BoxShadow(
                        color: Colors.blue.withOpacity(0.1),
                        spreadRadius: 0,
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ] : [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.02),
                        spreadRadius: 0,
                        blurRadius: 1,
                        offset: Offset(0, 1),
                      ),
                    ],
                  ),
                  child: Text(
                    (questionData['answers'][index] is Map
                        ? questionData['answers'][index]['text']
                        : questionData['answers'][index].toString()),
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: Colors.black87,
                      height: 1.4,
                    ),
                  ),
                ),
              ),
            );
          }),
          const SizedBox(height: 32),
          Text(
            'Take your time to choose the answer that best represents you',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
              fontWeight: FontWeight.w400,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 80),
        ],
      ),
    ));
  }
}