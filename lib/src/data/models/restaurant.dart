
import 'package:foodyar/src/data/models/category.dart';
import 'package:foodyar/src/data/models/review.dart';
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

  String getMediumPicture() => '${ApiImage.kImageMediumUrl}/$pictureId';

  String getLargePicture() => '${ApiImage.kImageLargeUrl}/$pictureId';
}

class RestaurantDetail {
  RestaurantDetail({
    required this.id,
    required this.name,
    required this.description,
    required this.city,
    required this.address,
    required this.pictureId,
    required this.categories,
    required this.menus,
    required this.rating,
    required this.customerReviews,
  });

  String id;
  String name;
  String description;
  String city;
  String address;
  String pictureId;
  List<Category> categories;
  Menus menus;
  double rating;
  List<Review> customerReviews;

  factory RestaurantDetail.fromJson(Map<String, dynamic> json) => RestaurantDetail(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    city: json["city"],
    address: json["address"],
    pictureId: json["pictureId"],
    categories: List<Category>.from(json["categories"].map((item) => Category.fromJson(item))),
    menus: Menus.fromJson(json["menus"]),
    rating: json["rating"].toDouble(),
    customerReviews: List<Review>.from(json["customerReviews"].map((item) => Review.fromJson(item))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "city": city,
    "address": address,
    "pictureId": pictureId,
    "categories": List<dynamic>.from(categories.map((item) => item.toJson())),
    "menus": menus.toJson(),
    "rating": rating,
    "customerReviews": List<dynamic>.from(customerReviews.map((item) => item.toJson())),
  };
}
