import 'dart:async';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:tisha_app/core/config/constants.dart';
import 'package:tisha_app/core/config/exception_handlers.dart';
import 'package:tisha_app/core/config/http_handler.dart';

class FarmerProvider {
  Future<dynamic> getFarmers({
    required String token,
    required String userId,
    String? query,
  }) async {
    try {
      var uri = Uri.parse("${AppUrls.SERVER_URL}/users/swipes/$userId");
      if (query != null) {
        uri = Uri.parse(
            "${AppUrls.SERVER_URL}/users/swipes/$userId?query=$query");
      }
      final response = await http.get(
        uri,
        headers: {
          "Content-Type": "application/json",
          "accept": "application/json",
          "Access-Control-Allow-Origin": "*",
          'Authorization': 'Bearer $token',
        },
      );

      return HttpHandler.returnResponse(response);
    } on SocketException {
      throw const FetchDataException(message: "No Internet connection");
    } on TimeoutException {
      throw const ApiNotRespondingException(message: "Api not responding");
    }
  }

  Future<dynamic> getFarmer({
    required String token,
    required String id,
    String? query,
  }) async {
    try {
      var uri = Uri.parse("${AppUrls.SERVER_URL}/users/$id");
      if (query != null) {
        uri = Uri.parse("${AppUrls.SERVER_URL}/users/$id?query=$query");
      }
      final response = await http.get(
        uri,
        headers: {
          "Content-Type": "application/json",
          "accept": "application/json",
          "Access-Control-Allow-Origin": "*",
          'Authorization': 'Bearer $token',
        },
      );

      return HttpHandler.returnResponse(response);
    } on SocketException {
      throw const FetchDataException(message: "No Internet connection");
    } on TimeoutException {
      throw const ApiNotRespondingException(message: "Api not responding");
    }
  }
}
