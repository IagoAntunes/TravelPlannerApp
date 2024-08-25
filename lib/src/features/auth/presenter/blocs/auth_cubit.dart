import 'package:bloc/bloc.dart';
import 'package:travelplannerapp/services/database/external/sharedPreferences/shared_preferences_service.dart';

import '../states/auth_state.dart';

class AuthCubit extends Cubit<IAuthState> {
  AuthCubit({
    required SharedPreferencesService service,
  })  : _service = service,
        super(IdleAuthState(isAuthenticated: false));

  final SharedPreferencesService _service;

  void logout() async {
    _service.saveData("isAuthenticated", false);
    emit(IdleAuthState(isAuthenticated: false));
  }

  void authenticated() async {
    _service.saveData("isAuthenticated", true);
    emit(IdleAuthState(isAuthenticated: true));
  }
}
