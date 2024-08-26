class FetchTravelsRequest {
  String idUser;
  FetchTravelsRequest({
    required this.idUser,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'idUser': idUser,
    };
  }
}
