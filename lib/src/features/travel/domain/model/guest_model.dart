import 'dart:convert';

class GuestModel {
  String email;
  String name;
  String status;
  GuestModel({
    required this.email,
    required this.name,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'name': name,
      'status': status,
    };
  }

  factory GuestModel.fromMap(Map<String, dynamic> map) {
    return GuestModel(
      email: map['email'] as String,
      name: map['name'] as String,
      status: map['status'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory GuestModel.fromJson(String source) =>
      GuestModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
