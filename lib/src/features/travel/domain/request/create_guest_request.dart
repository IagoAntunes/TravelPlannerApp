class CreateGuestRequest {
  String email;
  int travelId;
  CreateGuestRequest({
    required this.email,
    required this.travelId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'travelId': travelId,
    };
  }
}
