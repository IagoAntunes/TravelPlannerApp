import 'guest_model.dart';

class TravelModel {
  int id;
  String localName;
  String startDate;
  String endDate;
  List<GuestModel>? guests = [];
  TravelModel({
    required this.id,
    required this.localName,
    required this.startDate,
    required this.endDate,
    required this.guests,
  });
}
