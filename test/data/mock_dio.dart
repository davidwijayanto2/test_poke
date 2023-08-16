import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

enum Method {
  get,
  post,
  patch,
  put,
  delete,
}

Dio mockDioServer({
  required String url,
  required Method method,
  required responseData,
  Map<String, List<String>>? responseHeader,
  int responseCode = 200,
  requestParams,
  String? token,
  String? auth,
}) {
  responseHeader ??= {
    Headers.contentTypeHeader: [Headers.jsonContentType]
  };
  final Dio dio = Dio(BaseOptions());
  final dioAdapter =
      DioAdapter(dio: dio, matcher: const FullHttpRequestMatcher());
  var header = {
    HttpHeaders.contentTypeHeader: "application/json",
    HttpHeaders.acceptHeader: "application/json",
  };
  if (token != null) {
    header.addAll({
      HttpHeaders.authorizationHeader: "Bearer $token",
    });
  }
  if (auth != null) {
    header.addAll({
      HttpHeaders.authorizationHeader: "Basic $auth",
    });
  }
  switch (method) {
    case Method.get:
      dioAdapter.onGet(
        url,
        (server) =>
            server.reply(responseCode, responseData, headers: responseHeader!),
        headers: header,
      );
      break;
    case Method.post:
      dioAdapter.onPost(
        url,
        (server) =>
            server.reply(responseCode, responseData, headers: responseHeader!),
        headers: header,
        data: jsonEncode(requestParams),
      );
      break;
    case Method.put:
      dioAdapter.onPut(
        url,
        (server) =>
            server.reply(responseCode, responseData, headers: responseHeader!),
        headers: header,
        data: jsonEncode(requestParams),
      );
      break;
    case Method.patch:
      dioAdapter.onPatch(
        url,
        (server) =>
            server.reply(responseCode, responseData, headers: responseHeader!),
        headers: header,
        data: jsonEncode(requestParams),
      );
      break;
    case Method.delete:
      dioAdapter.onDelete(
        url,
        (server) =>
            server.reply(responseCode, responseData, headers: responseHeader!),
        headers: header,
        data: jsonEncode(requestParams),
      );
      break;
    default:
      dioAdapter.onGet(
        url,
        (server) =>
            server.reply(responseCode, responseData, headers: responseHeader!),
        headers: header,
      );
      break;
  }

  return dio;
}
