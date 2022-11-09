import 'menu.dart';

class Menus {

  final List<Menu> foods;
  final List<Menu> drinks;

  Menus({
    required this.foods,
    required this.drinks,
  });


  factory Menus.fromJson(Map<String, dynamic> json) => Menus(
    foods: List<Menu>.from(json["foods"].map((item) => Menu.fromJson(item))),
    drinks: List<Menu>.from(json["drinks"].map((item) => Menu.fromJson(item))),
  );

  Map<String, dynamic> toJson() => {
    "foods": List<dynamic>.from(foods.map((item) => item.toJson())),
    "drinks": List<dynamic>.from(drinks.map((item) => item.toJson())),
  };
}