import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'package:tisha_app/core/config/constants.dart';
import 'package:tisha_app/core/config/exception_handlers.dart';
import 'package:tisha_app/core/config/http_handler.dart';
import 'package:tisha_app/data/models/farmer_input.dart';
import 'package:tisha_app/data/models/user.dart';

class UserProvider {
  Future<dynamic> updateUserDetails({
    required String token,
    required User user,
  }) async {
    try {
      Map body = {
        "name": user.name,
        "surname": user.surname,
        "dob": user.dob?.toIso8601String(),
        "age": user.age,
        "gender": user.gender?.name,
        "phone": user.phone,
        "address": user.address,
        "nationalId": user.nationalId,
        "farmSize": user.farmSize,
        "locationId": user.locationId,
        "coordinates": user.coordinates,
        "landOwnership": user.landOwnership?.name,
        "farmerType": user.farmerType?.name,
        "cropType": user.cropType?.name,
        "livestockType": user.livestockType?.name,
        "livestockNumber": user.livestockNumber,
      };

      final response = await http.patch(
        Uri.parse("${AppUrls.SERVER_URL}/users/${user.id}/update"),
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

  Future<dynamic> updateUserInputs({
    required String token,
    required String id,
    required List<FarmerInput> inputs,
  }) async {
    try {
      Map body = {
        "inputs": inputs,
      };
      final response = await http.patch(
        Uri.parse("${AppUrls.SERVER_URL}/users/$id/update-inputs"),
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
}
