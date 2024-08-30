import 'package:travelplannerapp/src/features/auth/domain/models/user_model.dart';

abstract class IAuthState {
  bool isAuthenticated;
  UserModel? user;
  IAuthState({
    required this.isAuthenticated,
    this.user,
  });
}

class IdleAuthState extends IAuthState {
  IdleAuthState({
    required super.isAuthenticated,
    super.user,
  });
}
