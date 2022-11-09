part of 'repositories.dart';

class RestaurantDetailRepository {
  bool error;
  String message;
  Restaurant restaurant;

  RestaurantDetailRepository({
    required this.error,
    required this.message,
    required this.restaurant,
  });

  factory RestaurantDetailRepository.fromJson(Map<String, dynamic> json) =>
      RestaurantDetailRepository(
        error: json["error"],
        message: json["message"],
        restaurant: Restaurant.fromJson(
          json["restaurant"],
        ),
      );
}
