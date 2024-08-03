import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tisha_app/core/config/exception_handlers.dart';

abstract class HttpHandler {
  static dynamic returnResponse(http.Response response) {
    final responseBody = jsonDecode(response.body);
    switch (response.statusCode) {
      case 200:
        return responseBody;
      case 201:
        return responseBody;
      case 400:
        throw BadRequestException(
          message: responseBody["message"],
        );
      case 401:
      case 403:
        throw UnAuthorizedException(
          message: responseBody["message"],
        );
      case 404:
        throw UnAuthorizedException(
          message: responseBody["message"],
        );
      case 500:
      default:
        throw FetchDataException(
          message:
              'Error occurred while communication with server with status code : ${response.statusCode}',
        );
    }
  }
}
