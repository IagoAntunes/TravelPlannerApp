abstract class ILoginState {}

abstract class ILoginListener extends ILoginState {}

class IdleLoginState extends ILoginState {}

class LoadingLoginState extends ILoginState {}

class SuccessLoginListener extends ILoginListener {}

class FailureLoginListener extends ILoginListener {
  String message;
  FailureLoginListener({
    required this.message,
  });
}
