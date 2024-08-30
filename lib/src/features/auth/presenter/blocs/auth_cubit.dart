import 'package:bloc/bloc.dart';
import 'package:travelplannerapp/services/database/external/sharedPreferences/shared_preferences_keys.dart';
import 'package:travelplannerapp/services/database/external/sharedPreferences/shared_preferences_service.dart';
import 'package:travelplannerapp/src/features/auth/domain/models/user_model.dart';

import '../states/auth_state.dart';

class AuthCubit extends Cubit<IAuthState> {
  AuthCubit({
    required SharedPreferencesService service,
  })  : _service = service,
        super(IdleAuthState(isAuthenticated: false)) {
    init();
  }

  void init() async {
    if (state.user == null) {
      var userMap = await _service.getData("user");
      if (userMap != null) {
        var user = UserModel.fromJson(userMap);

        emit(IdleAuthState(
          isAuthenticated: state.isAuthenticated,
          user: user,
        ));
      }
    }
  }

  Future<void> get user async {
    if (state.user == null) {
      var userMap = await _service.getData("user");
      if (userMap != null) {
        var user = UserModel.fromMap(userMap);

        emit(IdleAuthState(
          isAuthenticated: state.isAuthenticated,
          user: user,
        ));
      }
    }
  }

  final SharedPreferencesService _service;

  void logout() async {
    _service.saveData("isAuthenticated", false);
    emit(IdleAuthState(isAuthenticated: false));
  }

  void authenticated(UserModel user) async {
    _service.saveData("isAuthenticated", true);
    _service.saveData(SharedPreferencesKeys.user, user.toJson());
    emit(IdleAuthState(isAuthenticated: true, user: user));
  }
}
