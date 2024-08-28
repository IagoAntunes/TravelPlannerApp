import '../model/guest_model.dart';

class GuestAdapter {
  static Map<String, dynamic> toMap(GuestModel guest) {
    return <String, dynamic>{
      'name': guest.name,
      'email': guest.email,
      'status': guest.status,
    };
  }

  static GuestModel fromMap(Map<String, dynamic> guest) {
    return GuestModel(
      id: guest['id'],
      email: guest['email'],
      name: guest['name'],
      status: guest['status'],
    );
  }
}
