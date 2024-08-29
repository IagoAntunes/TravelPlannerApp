class CreateLinkRequest {
  String name;
  String url;
  int travelId;
  CreateLinkRequest({
    required this.name,
    required this.url,
    required this.travelId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'url': url,
      'travelId': travelId,
    };
  }
}
