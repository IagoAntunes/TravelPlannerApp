import 'package:travelplannerapp/src/features/travel/domain/model/link_model.dart';

class LinkAdapter {
  static Map<String, dynamic> toMap(LinkModel link) {
    return {
      'name': link.name,
      'url': link.url,
    };
  }

  static LinkModel fromMap(Map<String, dynamic> map) {
    return LinkModel(
      name: map['name'],
      url: map['url'],
    );
  }
}
