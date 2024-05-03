import 'dart:html';

import 'package:dio/dio.dart';

class ApiFunctions {
  Future<dynamic> doGetRequest(
    String url, [
    dynamic body,
    int retries = 2,
  ]) async {
    return HttpUtil().doGetRequest(
      url,
      body,
      retries,
    );
  }
}

class HttpUtil {
  final int waitTime = 30000;
  static final HttpUtil _instance = HttpUtil._internal();

  factory HttpUtil() => _instance;
  late Dio dio;

  HttpUtil._internal() {
    dio = Dio();
    // We set a limit of 50000 milliseconds so dio will try the HTTP call for 50000 milliseconds
    // if it fail to connect to the server during this time it will show the exception,
    // the more you increase the time, the longer dio will try to connect
    dio.options.connectTimeout = Duration(milliseconds: waitTime);
    dio.options.receiveTimeout = Duration(milliseconds: waitTime);
  }

  Future<dynamic> doGetRequest(
    String url, [
    dynamic queryParams,
    int retries = 2,
  ]) async {
    var options = Options();
    var response =
        await dio.get(url, options: options, queryParameters: queryParams);
    return response;
  }
}
