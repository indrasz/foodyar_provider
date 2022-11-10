import 'package:flutter/material.dart';
import 'package:foodyar/src/data/providers/restaurant_provider.dart';
import 'package:foodyar/src/data/services/api_services.dart';
import 'package:foodyar/src/modules/pages/home_page.dart';
import 'package:provider/provider.dart';

void main () => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<RestaurantProvider>(
          create: (context) => RestaurantProvider(
            apiService: ApiService(),
          ),
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomePage(),
      ),
    );
  }
}