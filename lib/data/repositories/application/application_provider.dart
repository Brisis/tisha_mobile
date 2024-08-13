import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:tisha_app/core/config/constants.dart';
import 'package:tisha_app/core/config/exception_handlers.dart';
import 'package:tisha_app/core/config/http_handler.dart';

class ApplicationProvider {
  Future<dynamic> getApplications() async {
    try {
      final response = await http.get(
        Uri.parse("${AppUrls.SERVER_URL}/applications"),
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

  Future<dynamic> getFarmerApplications({
    required String token,
    required String userId,
  }) async {
    try {
      final response = await http.get(
        Uri.parse("${AppUrls.SERVER_URL}/applications/user/$userId"),
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

  Future<dynamic> addApplication({
    required String token,
    required String inputId,
    required String userId,
    required String message,
    required double quantity,
  }) async {
    try {
      Map body = {
        "inputId": inputId,
        "quantity": quantity,
        "message": message,
        "userId": userId,
      };
      final response = await http.post(
        Uri.parse("${AppUrls.SERVER_URL}/applications"),
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

  Future<dynamic> updateFarmerApplication({
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
            "${AppUrls.SERVER_URL}/applications/update-assigned/$inputId/user/$userId"),
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
