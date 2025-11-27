class CoachModel {
  final String id;
  final String name;
  final String description;

  CoachModel({
    required this.id,
    required this.name,
    required this.description,
  });

  factory CoachModel.fromJson(Map<String, dynamic> json) {
    return CoachModel(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
    );
  }
}

class CoachDetailsModel {
  final String id;
  final String name;
  final String description;
  final List<CoachAvailability> details;

  CoachDetailsModel({
    required this.id,
    required this.name,
    required this.description,
    required this.details,
  });

  factory CoachDetailsModel.fromJson(Map<String, dynamic> json) {
    var detailsList = <CoachAvailability>[];
    if (json['details'] != null) {
      json['details'].forEach((v) {
        detailsList.add(CoachAvailability.fromJson(v));
      });
    }

    return CoachDetailsModel(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      details: detailsList,
    );
  }
}

class CoachAvailability {
  final String date;
  final String id;
  final List<TimeSlot> slots;

  CoachAvailability({
    required this.date,
    required this.id,
    required this.slots,
  });

  factory CoachAvailability.fromJson(Map<String, dynamic> json) {
    List<TimeSlot> parsedSlots = [];

    // Iterate through all keys to find slots (slot1, slot2, etc.)
    json.forEach((key, value) {
      if (key.startsWith('slot') && value is Map<String, dynamic>) {
        parsedSlots.add(TimeSlot.fromJson(value));
      }
    });

    return CoachAvailability(
      date: json['date'] ?? '',
      id: json['_id'] ?? '',
      slots: parsedSlots,
    );
  }
}

class TimeSlot {
  final String id;
  final String value;
  final int flag; // 0 = available, 1 = unavailable

  TimeSlot({
    required this.id,
    required this.value,
    required this.flag,
  });

  factory TimeSlot.fromJson(Map<String, dynamic> json) {
    return TimeSlot(
      id: json['_id'] ?? '',
      value: json['value'] ?? '',
      flag: json['flag'] ?? 1,
    );
  }
}
