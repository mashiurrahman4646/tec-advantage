import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../mockinterviewresult/mockinterviewresult.dart';

class MockInterviewAssessment extends StatefulWidget {
  const MockInterviewAssessment({Key? key}) : super(key: key);

  @override
  _MockInterviewAssessmentState createState() => _MockInterviewAssessmentState();
}

class _MockInterviewAssessmentState extends State<MockInterviewAssessment> {
  int? _selectedAnswerIndex;
  final PageController _pageController = PageController();
  int _currentPage = 0;

  // Sample questions data - just one question for demo
  final List<Map<String, dynamic>> _questions = [
    {
      'question': 'Tell me about yourself ?',
      'answers': [
        'I\'ve been working in business analysis for 5 years, mostly with cloud cost optimization, and I enjoy using data to drive decisions.',
        'I\'m a detail-oriented professional with strong teamwork skills and a passion for problem solving.',
        'I studied IT management, then transitioned into business systems roles where I learned to manage projects.',
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Custom App Bar with Progress - exactly like Figma
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
                // Header with back button and title
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
                      SizedBox(width: 40), // Balance the back button
                    ],
                  ),
                ),

                SizedBox(height: 16),

                // Question counter
                Container(
                  width: double.infinity,
                  child: Text(
                    'Question ${_currentPage + 1} to ${_questions.length}',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.black87,
                    ),
                  ),
                ),

                SizedBox(height: 12),

                // Progress bar - exactly like Figma
                Container(
                  height: 4,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Color(0xFFE0E0E0),
                    borderRadius: BorderRadius.circular(2),
                  ),
                  child: FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: (_currentPage + 1) / _questions.length,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 24),
              ],
            ),
          ),

          // Content
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: _questions.length,
              onPageChanged: (int page) {
                setState(() {
                  _currentPage = page;
                  _selectedAnswerIndex = null;
                });
              },
              itemBuilder: (context, index) {
                return _buildQuestionPage(_questions[index]);
              },
            ),
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
              // Back button
              Expanded(
                child: Container(
                  height: 48,
                  child: OutlinedButton(
                    onPressed: _currentPage > 0 ? () {
                      _pageController.previousPage(
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

              // Next/Submit button
              Expanded(
                child: Container(
                  height: 48,
                  child: ElevatedButton(
                    onPressed: _selectedAnswerIndex != null ? () {
                      if (_currentPage < _questions.length - 1) {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      } else {
                        // Navigate to results page
                        Get.to(() => MockInterviewResults());
                      }
                    } : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _selectedAnswerIndex != null ? Colors.black : Colors.grey[300],
                      foregroundColor: _selectedAnswerIndex != null ? Colors.white : Colors.grey[500],
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          _currentPage < _questions.length - 1 ? 'Next' : 'Submit',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Icon(
                          Icons.arrow_forward,
                          size: 18,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuestionPage(Map<String, dynamic> questionData) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Question - exactly matching Figma typography
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

          // Answer options - exactly matching Figma cards
          ...List.generate(questionData['answers'].length, (index) {
            final isSelected = _selectedAnswerIndex == index;
            return Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedAnswerIndex = index;
                  });
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
                    questionData['answers'][index],
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

          // Helper text - exactly matching Figma
          Text(
            'Take your time to choose the answer that best represents you',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
              fontWeight: FontWeight.w400,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 80), // Space for bottom navigation
        ],
      ),
    );
  }
}