import 'dart:convert';

import 'package:travelplannerapp/src/features/travel/domain/model/travel_model.dart';

import '../model/guest_model.dart';

class TravelAdapter {
  static Map<String, dynamic> toMap(TravelModel travel) {
    return <String, dynamic>{
      'id': travel.id,
      'localName': travel.localName,
      'startDate': travel.startDate,
      'endDate': travel.endDate,
    };
  }

  static TravelModel fromMap(Map<String, dynamic> map) {
    return TravelModel(
      id: map['id'] as int,
      localName: map['localName'] as String,
      startDate: map['startDate'] as String,
      endDate: map['endDate'] as String,
      guests: map['guests'] != null
          ? List<GuestModel>.from(
              (map['guests'] as List)
                  .map((x) => GuestModel.fromMap(x as Map<String, dynamic>)),
            )
          : [],
    );
  }

  static String toJson(TravelModel travel) => json.encode(toMap(travel));

  static TravelModel fromJson(String source) =>
      TravelAdapter.fromMap(json.decode(source) as Map<String, dynamic>);
}