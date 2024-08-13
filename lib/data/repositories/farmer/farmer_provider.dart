import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:tisha_app/core/config/constants.dart';
import 'package:tisha_app/core/config/exception_handlers.dart';
import 'package:tisha_app/core/config/http_handler.dart';

class FarmerProvider {
  Future<dynamic> getFarmers({
    required String token,
    String? query,
  }) async {
    try {
      var uri = Uri.parse("${AppUrls.SERVER_URL}/users");
      if (query != null) {
        uri = Uri.parse("${AppUrls.SERVER_URL}/users?query=$query");
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

  Future<dynamic> addFarmer({
    required String token,
    required String name,
    String? surname,
    DateTime? dob,
    int? age,
    String? gender,
    String? phone,
    String? address,
    String? nationalId,
    required double farmSize,
    required String locationId,
    String? coordinates,
    String? landOwnership,
    String? farmerType,
    String? cropType,
    String? livestockType,
    int? livestockNumber,
    required String email,
    required String password,
  }) async {
    try {
      Map body = {
        "name": name,
        "surname": surname,
        "dob": dob?.toIso8601String(),
        "age": age,
        "gender": gender,
        "phone": phone,
        "address": address,
        "nationalId": nationalId,
        "farmSize": farmSize,
        "locationId": locationId,
        "coordinates": coordinates,
        "landOwnership": landOwnership,
        "farmerType": farmerType,
        "cropType": cropType,
        "livestockType": livestockType,
        "livestockNumber": livestockNumber,
        "email": email,
        "password": password,
      };
      final response = await http.post(
        Uri.parse("${AppUrls.SERVER_URL}/users"),
        body: json.encode(body),
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
      // throw ExceptionHandlers.getExceptionString(e);
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
