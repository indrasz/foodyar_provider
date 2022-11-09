class Menu {
  final String name;

  Menu({
    required this.name,
  });

  factory Menu.fromJson(Map<String, dynamic> json) => Menu(
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
  };
}