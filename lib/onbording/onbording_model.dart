// File: lib/models/onboarding_model.dart

class OnboardingModel {
  final String image;
  final String title;
  final String description;

  OnboardingModel({
    required this.image,
    required this.title,
    required this.description,
  });

  // Convert model to JSON (optional for future use)
  Map<String, dynamic> toJson() {
    return {
      'image': image,
      'title': title,
      'description': description,
    };
  }

  // Create model from JSON (optional for future use)
  factory OnboardingModel.fromJson(Map<String, dynamic> json) {
    return OnboardingModel(
      image: json['image'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
    );
  }

  // Copy with method (optional for future use)
  OnboardingModel copyWith({
    String? image,
    String? title,
    String? description,
  }) {
    return OnboardingModel(
      image: image ?? this.image,
      title: title ?? this.title,
      description: description ?? this.description,
    );
  }
}