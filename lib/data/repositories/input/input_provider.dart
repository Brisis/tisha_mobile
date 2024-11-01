import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:tisha_app/core/config/constants.dart';
import 'package:tisha_app/core/config/exception_handlers.dart';
import 'package:tisha_app/core/config/http_handler.dart';

class InputProvider {
  Future<dynamic> getInputs() async {
    try {
      final response = await http.get(
        Uri.parse("${AppUrls.SERVER_URL}/inputs"),
        headers: {
          "Content-Type": "application/json",
          "accept": "application/json",
          "Access-Control-Allow-Origin": "*"
        },
      );

      return HttpHandler.returnResponse(response);
    } on SocketException {
      throw const FetchDataException(message: "No Internet connection");
    } on TimeoutException {
      throw const ApiNotRespondingException(message: "Api not responding");
    }
  }

  Future<dynamic> getAllFarmerInputs({
    required String token,
  }) async {
    try {
      final response = await http.get(
        Uri.parse("${AppUrls.SERVER_URL}/inputs/assigned"),
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

  Future<dynamic> getFarmerInputs({
    required String token,
    required String userId,
  }) async {
    try {
      final response = await http.get(
        Uri.parse("${AppUrls.SERVER_URL}/inputs/user/$userId"),
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

  Future<dynamic> addInput({
    required String token,
    required String name,
    required int quantity,
    required String? unit,
    required String type,
    required String scheme,
    required String barcode,
    required String? chassisNumber,
    required String? engineType,
    required String? numberPlate,
    required String? color,
    required String locationId,
    required String userId,
  }) async {
    try {
      Map body = {
        "name": name,
        "quantity": quantity,
        "unit": unit,
        "type": type,
        "scheme": scheme,
        "barcode": barcode,
        "chassisNumber": chassisNumber,
        "engineType": engineType,
        "numberPlate": numberPlate,
        "color": color,
        "locationId": locationId,
        "userId": userId,
      };
      final response = await http.post(
        Uri.parse("${AppUrls.SERVER_URL}/inputs"),
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

  Future<dynamic> notifyInput({
    required String token,
    required String inputId,
  }) async {
    try {
      final response = await http.patch(
        Uri.parse("${AppUrls.SERVER_URL}/inputs/$inputId/notify"),
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

  Future<dynamic> addFarmerInput({
    required String token,
    required String inputId,
    required String userId,
    required int quantity,
  }) async {
    try {
      Map body = {
        "inputId": inputId,
        "quantity": quantity,
      };
      final response = await http.post(
        Uri.parse("${AppUrls.SERVER_URL}/inputs/add-to-farmer/$userId"),
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

  Future<dynamic> updateFarmerInput({
    required String token,
    required String userId,
    required String inputId,
    required bool received,
    required double payback,
  }) async {
    try {
      Map body = {
        "inputId": inputId,
        "received": received,
        "payback": payback,
      };
      final response = await http.patch(
        Uri.parse(
            "${AppUrls.SERVER_URL}/inputs/update-assigned/$inputId/user/$userId"),
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
