import 'package:get_it/get_it.dart';

import '../blocs/create_travel_cubit.dart';

class CreateTravelBinding {
  static void setUpCreateTravelBindings() {
    var getIt = GetIt.I;
    getIt.registerFactory(() => CreateTravelCubit());
  }
}
