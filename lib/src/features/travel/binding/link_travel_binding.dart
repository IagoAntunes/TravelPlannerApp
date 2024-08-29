import 'package:get_it/get_it.dart';
import 'package:travelplannerapp/src/features/travel/datasource/link_datasource.dart';
import 'package:travelplannerapp/src/features/travel/domain/repository/i_link_repository.dart';
import 'package:travelplannerapp/src/features/travel/infra/datasource/i_link_datasource.dart';
import 'package:travelplannerapp/src/features/travel/infra/repository/link_repository.dart';
import 'package:travelplannerapp/src/features/travel/modules/links_travel/presenter/links_travel_cubit.dart';

class LinkTravelBinding {
  static void setUpLinkTravelBinding() {
    var getIt = GetIt.I;
    getIt.registerFactory<ILinkRepository>(
      () => LinkRepository(
        linkDataSource: getIt(),
      ),
    );
    getIt.registerFactory<ILinkDataSource>(
      () => LinkDataSource(
        httpService: getIt(),
      ),
    );

    getIt.registerFactory(
      () => LinksTravelCubit(linkRepository: getIt()),
    );
  }
}
