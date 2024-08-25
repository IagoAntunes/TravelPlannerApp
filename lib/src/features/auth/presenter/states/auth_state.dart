abstract class IAuthState {
  bool isAuthenticated;

  IAuthState({required this.isAuthenticated});
}

class IdleAuthState extends IAuthState {
  IdleAuthState({required super.isAuthenticated});
}
