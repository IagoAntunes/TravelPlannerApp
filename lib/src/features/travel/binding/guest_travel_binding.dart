import 'package:get_it/get_it.dart';
import 'package:travelplannerapp/src/features/travel/datasource/guest_datasource.dart';
import 'package:travelplannerapp/src/features/travel/domain/repository/i_guest_repository.dart';
import 'package:travelplannerapp/src/features/travel/infra/datasource/i_guest_datasource.dart';
import 'package:travelplannerapp/src/features/travel/infra/repository/guest_repository.dart';
import 'package:travelplannerapp/src/features/travel/modules/guests_travel/presenter/blocs/guest_travel_cubit.dart';

class GuestTravelBinding {
  static void setUpGuestTravelBinding() {
    var getIt = GetIt.I;

    getIt.registerFactory<IGuestDataSource>(
      () => GuestDataSource(httpService: getIt()),
    );

    getIt.registerFactory<IGuestRepository>(
      () => GuestRepository(guestDataSource: getIt()),
    );

    getIt.registerFactory(
      () => GuestTravelCubit(guestRepository: getIt()),
    );
  }
}
