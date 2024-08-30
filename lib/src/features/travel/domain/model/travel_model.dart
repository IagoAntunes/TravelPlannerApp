import 'package:travelplannerapp/src/features/travel/domain/model/link_model.dart';

import 'guest_model.dart';

class TravelModel {
  int id;
  String localName;
  String startDate;
  String endDate;
  List<GuestModel>? guests = [];
  List<LinkModel>? links = [];
  String createdBy;
  TravelModel({
    required this.id,
    required this.localName,
    required this.startDate,
    required this.endDate,
    required this.guests,
    required this.links,
    required this.createdBy,
  });
}
