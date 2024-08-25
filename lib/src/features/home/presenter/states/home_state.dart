import '../blocs/home_cubit.dart';

abstract class IHomeState {
  HomeModuleType homeModuleType;
  IHomeState({
    required this.homeModuleType,
  });
}

class IdleHomeState extends IHomeState {
  IdleHomeState({required super.homeModuleType});
}
