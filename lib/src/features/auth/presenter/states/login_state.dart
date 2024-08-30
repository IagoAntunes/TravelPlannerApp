import 'package:travelplannerapp/src/features/auth/domain/models/user_model.dart';

abstract class ILoginState {}

abstract class ILoginListener extends ILoginState {}

class IdleLoginState extends ILoginState {}

class LoadingLoginState extends ILoginState {}

class SuccessLoginListener extends ILoginListener {
  UserModel user;
  SuccessLoginListener({
    required this.user,
  });
}

class FailureLoginListener extends ILoginListener {
  String message;
  FailureLoginListener({
    required this.message,
  });
}
