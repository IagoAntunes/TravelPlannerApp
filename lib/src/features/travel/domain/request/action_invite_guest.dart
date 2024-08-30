// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ActionInviteGuest {
  String guestId;
  String action;
  ActionInviteGuest({
    required this.guestId,
    required this.action,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'guestId': guestId,
      'status': action,
    };
  }

  String toJson() => json.encode(toMap());
}
