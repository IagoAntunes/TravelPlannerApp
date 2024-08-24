import 'dart:convert';

class RegisterUserRequest {
  String username;
  String email;
  String password;
  RegisterUserRequest({
    required this.username,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': username,
      'email': email,
      'password': password,
      "role": "ROLE_USER"
    };
  }

  String toJson() => json.encode(toMap());
}
