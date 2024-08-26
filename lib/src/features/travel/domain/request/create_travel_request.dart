import 'dart:convert';

class CreateTravelRequest {
  String name;
  String startDate;
  String endDate;
  List<String> guests;
  CreateTravelRequest({
    required this.name,
    required this.startDate,
    required this.endDate,
    required this.guests,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'startDate': startDate,
      'endDate': endDate,
      'guests': guests
          .map(
            (e) => {'email': e},
          )
          .toList(),
    };
  }

  String toJson() => json.encode(toMap());
}
