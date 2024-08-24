import 'package:bloc/bloc.dart';
import 'package:travelplannerapp/src/features/auth/domain/repository/i_auth_repository.dart';

import '../states/login_state.dart';

class LoginCubit extends Cubit<ILoginState> {
  LoginCubit({required IAuthRepository repository})
      : _repository = repository,
        super(IdleLoginState());

  final IAuthRepository _repository;

  void login(String email, String password) async {
    emit(LoadingLoginState());
    var result = await _repository.login(email, password);
    if (result.isSuccess) {
      emit(SuccessLoginListener());
    } else {
      emit(FailureLoginListener(message: result.statusMsg));
    }
    emit(IdleLoginState());
  }
}
