part of 'repositories.dart';

class RestaurantRepository {

  bool error;
  String message;
  int count;
  List<Restaurant> restaurants;

  RestaurantRepository({
    required this.error,
    required this.message,
    required this.count,
    required this.restaurants,
  });

  factory RestaurantRepository.fromJson(Map<String, dynamic> json) =>
      RestaurantRepository(
        error: json['error'],
        message: json['message'],
        count: json['count'],
        restaurants: List<Restaurant>.from(
          json['restaurants'].map(
            (item) => Restaurant.fromJson(item),
          ),
        ),
      );
}
