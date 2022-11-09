import 'package:flutter/cupertino.dart';
import 'package:foodyar/src/data/repositories/repositories.dart';
import 'package:foodyar/src/data/services/api_services.dart';
import 'package:foodyar/src/utils/enums.dart';

class AppProvider extends ChangeNotifier {

  final ApiService apiService;

  AppProvider({required this.apiService});

  late RestaurantRepository _restaurantRepository;
  late RestaurantDetailRepository _restaurantDetailRepository;
  late ResultState _state;
  late String _message;
  final String _query = "";

  RestaurantRepository get result => _restaurantRepository;
  RestaurantDetailRepository get restaurant => _restaurantDetailRepository;
  ResultState get state => _state;
  String get message => _message;

  AppProvider getRestaurants() {
    _fetchRestaurants();
    return this;
  }

  AppProvider getRestaurant(String id) {
    _fetchRestaurant(id);
    return this;
  }

  Future<dynamic> _fetchRestaurants() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final response = await apiService.getList();
      if (response.restaurants.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'No data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _restaurantRepository = response;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Error while get data --> $e';
    }
  }

  Future<dynamic> _fetchRestaurant(String id) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final response = await apiService.getDetail(id);
      if (!response.error) {
        _state = ResultState.hasData;
        notifyListeners();
        return _restaurantDetailRepository = response;
      } else {
        _state = ResultState.noData;
        notifyListeners();
        return _message = "No data found";
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }

  void onSearch(String query) {
    query = query;
    _fetchRestaurants();
  }
}
