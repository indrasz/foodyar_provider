import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:foodyar/src/data/models/restaurant.dart';
import 'package:foodyar/src/data/services/api_services.dart';
import 'package:foodyar/src/utils/enums.dart';

class RestaurantProvider extends ChangeNotifier {
  final ApiService apiService;

  RestaurantProvider({required this.apiService}) {
    _getListRestaurant();
    // _fetchRestaurants();
  }

  // RestaurantProvider getRestaurants() {
  //   _fetchRestaurants();
  //   return this;
  // }

  late RestaurantModel _restResult;
  late ResultState _state;
  String _message = '';

  RestaurantModel get restResult => _restResult;
  ResultState get state => _state;
  String get message => _message;

  Future<dynamic> _getListRestaurant() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final result = await apiService.getListRestaurant();
      if (result.restaurants.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        _message = 'Empty data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _restResult = result;
      }
    } on SocketException catch (_) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'No internet connection';
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Error -> $e';
    }
  }


}
