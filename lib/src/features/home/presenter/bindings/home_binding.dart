import 'package:get_it/get_it.dart';
import 'package:travelplannerapp/src/features/home/presenter/blocs/home_cubit.dart';

class HomeBinding {
  static void setUpHomeBindings() {
    var getIt = GetIt.I;
    getIt.registerSingleton(HomeCubit());
  }
}
