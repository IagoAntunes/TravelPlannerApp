import 'package:get_it/get_it.dart';
import 'package:travelplannerapp/src/features/travel/datasource/travel_datasource.dart';
import 'package:travelplannerapp/src/features/travel/infra/datasource/i_travel_datasource.dart';
import 'package:travelplannerapp/src/features/travel/modules/activities_travel/presenter/blocs/activity_travel_cubit.dart';

import '../domain/repository/i_travel_repository.dart';
import '../infra/repository/travel_repository.dart';
import '../modules/create_travel/presenter/blocs/create_travel_cubit.dart';
import '../modules/list_travels/presenter/blocs/list_travels_cubit.dart';

class TravelBinding {
  static void setUpTravelBinding() {
    var getIt = GetIt.I;
    getIt.registerFactory<ITravelsRepository>(
      () => TravelRepository(
        travelDataSource: getIt(),
      ),
    );
    getIt.registerFactory<ITravelDataSource>(
      () => TravelDataSource(
        httpService: getIt(),
      ),
    );
    getIt.registerFactory(
      () => ActivityTravelCubit(
        travelRepository: getIt(),
      ),
    );
    getIt.registerFactory(() => CreateTravelCubit(
          repository: getIt(),
        ));
    getIt.registerSingleton(
      ListTravelsCubit(
        travelRepository: getIt(),
      ),
    );
  }
}
