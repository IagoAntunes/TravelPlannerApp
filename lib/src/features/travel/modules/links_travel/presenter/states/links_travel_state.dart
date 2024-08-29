import '../../../../domain/model/link_model.dart';

abstract class ILinksTravelState {}

abstract class ILinksTravelListener extends ILinksTravelState {}

class LoadingCreateLinkTravelState extends ILinksTravelState {}

class SuccessCreateLinkTravelListener extends ILinksTravelListener {
  SuccessCreateLinkTravelListener({
    required this.link,
  });

  final LinkModel link;
}

class SuccessDeletedLinkTravelListener extends ILinksTravelListener {
  SuccessDeletedLinkTravelListener({
    required this.linkId,
  });

  int linkId;
}

class FailureCreateLinkTravelListener extends ILinksTravelListener {}

class IdleLinksTravelState extends ILinksTravelState {}
