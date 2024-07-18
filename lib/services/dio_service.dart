import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:maids/enums/http_verbs.dart';
import 'package:maids/exception/base_exception.dart';

import '../app/app.logger.dart';

class DioService {
  final Dio _dio = Dio();
  final _logger = getLogger('DioService');

  DioService() {
    if (kDebugMode) {
      _dio.interceptors.addAll([
        LogInterceptor(
          responseBody: true,
          requestHeader: true,
          responseHeader: false,
          request: false,
          requestBody: true,
        ),
      ]);
    }
  }

  Future makeHttpRequest({
    required HttpVerbs verb,
    required String path,
    Map<String, dynamic> queryParameters = const {},
    Map<String, dynamic> body = const {},
  }) async {
    try {
      final response = await _sendRequest(
        verb: verb,
        path: path,
        queryParameters: queryParameters,
        body: body,
      );

      return response.data;
    } on DioException catch (e) {
      if (e.type == DioExceptionType.unknown && e.error is SocketException) {
        _logger.e(
          'This seems to be a network issue. Please check your network and try again.',
        );
        throw BaseException(
          message: 'No Internet Connection',
        );
      }

      if (e.type == DioExceptionType.connectionTimeout) {
        _logger.e(
          'This seems to be a network issue. Please check your network and try again.',
        );
        throw BaseException(
          message: 'Request took too long to deliver',
        );
      }

      if (e.type == DioExceptionType.connectionError) {
        _logger.e(
          'This seems to be a network issue. Please check your network and try again.',
        );
        throw BaseException(
          message:
              'Opps, we lost connection there. Please check your network and try again.',
        );
      }

      _logger.e(
        'A response error occurred. ${e.response?.statusCode}\nERROR: ${e.message}',
      );
      throw BaseException(
        message: 'Unknown Error Has Ocurred!',
      );
    } catch (e, s) {
      _logger.wtf('Could not make a request to this path: $path', e, s);

      rethrow;
    }
  }

  Future<Response> _sendRequest({
    required HttpVerbs verb,
    required String path,
    Map<String, dynamic> queryParameters = const {},
    Map<String, dynamic> body = const {},
  }) async {
    Response response;

    switch (verb) {
      case HttpVerbs.post:
        response =
            await _dio.post(path, queryParameters: queryParameters, data: body);

      case HttpVerbs.update:
        response = await _dio.patch(path, data: body);

      case HttpVerbs.delete:
        response = await _dio.delete(path);
      case HttpVerbs.get:
      default:
        response = await _dio.get(
          path,
          queryParameters: queryParameters,
          data: body,
        );
    }

    return response;
  }
}
