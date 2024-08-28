class CreateActivityRequest {
  String name;
  String date;
  int travelId;
  CreateActivityRequest({
    required this.name,
    required this.date,
    required this.travelId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'date': date,
      'travelId': travelId,
    };
  }
}
