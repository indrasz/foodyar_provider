import 'package:foodyar/src/utils/constants.dart';

import 'menus.dart';

class Restaurant {

  final String id;
  final String name;
  final String description;
  final String pictureId;
  final String city;
  final double rating;

  Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
      id: json["id"],
      name: json["name"],
      description: json["description"],
      pictureId: json["pictureId"],
      city: json["city"],
      rating: json["rating"].toDouble(),
      );

  String getSmallPicture() => '${ApiImage.kImageSmallUrl}/$pictureId';
  String getMediumPicture() =>  '${ApiImage.kImageMediumUrl}/$pictureId';
  String getLargePicture() =>  '${ApiImage.kImageLargeUrl}/$pictureId';
}
