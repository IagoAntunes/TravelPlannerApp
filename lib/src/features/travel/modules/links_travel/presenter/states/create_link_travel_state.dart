import 'package:travelplannerapp/src/features/travel/domain/model/link_model.dart';

abstract class ICreateLinkTravelState {}

abstract class ICreateLinkTravelListener extends ICreateLinkTravelState {}

class SuccessCreateLinkTravelListener extends ICreateLinkTravelListener {
  SuccessCreateLinkTravelListener({required this.link});
  LinkModel link;
}

class FailureCreateLinkTravelListener extends ICreateLinkTravelListener {}

class IdleCreateLinkTravelState extends ICreateLinkTravelState {}

class LoadingCreateLinkTravelState extends ICreateLinkTravelState {}
