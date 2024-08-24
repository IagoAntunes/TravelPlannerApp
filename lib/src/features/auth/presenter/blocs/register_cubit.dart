import 'package:bloc/bloc.dart';
import 'package:travelplannerapp/src/features/auth/domain/repository/i_auth_repository.dart';
import 'package:travelplannerapp/src/features/auth/presenter/states/register_state.dart';

class RegisterCubit extends Cubit<IRegisterState> {
  RegisterCubit({
    required IAuthRepository authRepository,
  })  : _authRepository = authRepository,
        super(IdleRegisterState());

  final IAuthRepository _authRepository;

  void register(String username, String email, String password) async {
    emit(LoadingRegisterState());
    final result = await _authRepository.register(username, email, password);
    if (result.isSuccess) {
      emit(SuccessRegisterListener());
    } else {
      emit(FailureRegisterListener(message: result.statusMsg));
    }
    emit(IdleRegisterState());
  }
}
