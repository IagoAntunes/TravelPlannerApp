import '../model/activity_model.dart';

class ActivityAdapter {
  static ActivityModel fromMap(Map<String, dynamic> map) {
    return ActivityModel(
      id: map['id'],
      name: map['name'],
      date: map['date'],
    );
  }

  static Map<String, dynamic> toMap(ActivityModel activity) {
    return {
      'id': activity.id,
      'name': activity.name,
      'date': activity.date,
    };
  }
}
