import 'dart:async';
import 'dart:io';

import 'package:equatable/equatable.dart';

abstract class ExceptionHandlers {
  static getExceptionString(error) {
    if (error is SocketException) {
      return 'No internet connection.';
    } else if (error is HttpException) {
      return 'HTTP error occured.';
    } else if (error is FormatException) {
      return 'Invalid data format.';
    } else if (error is TimeoutException) {
      return 'Request timedout.';
    } else if (error is BadRequestException) {
      return error.message.toString();
    } else if (error is UnAuthorizedException) {
      return error.message.toString();
    } else if (error is NotFoundException) {
      return error.message.toString();
    } else if (error is FetchDataException) {
      return error.message.toString();
    } else {
      return 'Unknown error occured.';
    }
  }
}

class AppException extends Equatable implements Exception {
  final String? message;
  final String? prefix;
  final String? url;

  const AppException({
    this.message,
    this.prefix,
    this.url,
  });

  AppException copyWith({
    String? message,
    String? prefix,
    String? url,
  }) =>
      AppException(
        message: message ?? this.message,
        prefix: prefix ?? this.prefix,
        url: url ?? this.url,
      );

  @override
  List<Object?> get props => [
        message,
        prefix,
        url,
      ];

  @override
  bool? get stringify => true;
}

class BadRequestException extends AppException {
  const BadRequestException({
    String? message,
    String? url,
  }) : super(
          message: message,
          prefix: 'Bad request',
          url: url,
        );

  @override
  bool? get stringify => true;
}

class FetchDataException extends AppException {
  const FetchDataException({
    String? message,
    String? url,
  }) : super(
          message: message,
          prefix: 'Unable to process the request',
          url: url,
        );

  @override
  List<Object?> get props => [message, url];

  @override
  bool? get stringify => true;
}

class ApiNotRespondingException extends AppException {
  const ApiNotRespondingException({
    String? message,
    String? url,
  }) : super(
          message: message,
          prefix: 'Api not responding',
          url: url,
        );

  @override
  List<Object?> get props => [message, url];

  @override
  bool? get stringify => true;
}

class UnAuthorizedException extends AppException {
  const UnAuthorizedException({
    String? message,
    String? url,
  }) : super(
          message: message,
          prefix: 'Unauthorized request',
          url: url,
        );

  @override
  List<Object?> get props => [message, url];

  @override
  bool? get stringify => true;
}

class NotFoundException extends AppException {
  const NotFoundException({
    String? message,
    String? url,
  }) : super(
          message: message,
          prefix: 'Page not found',
          url: url,
        );

  @override
  List<Object?> get props => [message, url];

  @override
  bool? get stringify => true;
}
