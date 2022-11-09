import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:foodyar/src/res/res.dart';
import 'package:foodyar/src/utils/constants.dart';
import 'package:foodyar/src/data/repositories/repositories.dart';

class ApiService {
  Future<RestaurantRepository> getList() async {
    try {
      final response = await http.get(Uri.parse(ApiEndPoint.kApiList));
      if (response.statusCode == 200) {
        return RestaurantRepository.fromJson(json.decode(response.body));
      } else {
        throw Exception(failedGetData);
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<RestaurantRepository> search({String query = ""}) async {
    try {
      final response = await http.get(
        Uri.parse('${ApiEndPoint.kApiSearch}?q=$query'),
      );
      if (response.statusCode == 200) {
        return RestaurantRepository.fromJson(
          json.decode(response.body),
        );
      } else {
        throw Exception(failedGetData);
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<RestaurantDetailRepository> getDetail(String id) async {
    final response = await http.get(Uri.parse('${ApiEndPoint.kApiDetail}/$id'));
    if (response.statusCode == 200) {
      return RestaurantDetailRepository.fromJson(
        json.decode(response.body),
      );
    } else {
      throw Exception(failedGetData);
    }
  }
}
