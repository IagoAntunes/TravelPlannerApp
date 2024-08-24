abstract class IRegisterState {}

abstract class IRegisterListener extends IRegisterState {}

class IdleRegisterState extends IRegisterState {}

class LoadingRegisterState extends IRegisterState {}

class SuccessRegisterListener extends IRegisterListener {}

class FailureRegisterListener extends IRegisterListener {
  String message;
  FailureRegisterListener({
    required this.message,
  });
}
