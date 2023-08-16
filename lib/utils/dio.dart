import 'dart:io';

import 'package:dio/dio.dart';
import 'package:test_poke/utils/dio_contract.dart';

class DioHandler implements DioContracts {
  final Dio dio;

  final CancelToken _cancelToken = CancelToken();

  var header = {
    HttpHeaders.contentTypeHeader: "application/json",
    HttpHeaders.acceptHeader: "application/json",
  };

  DioHandler({required this.dio});
  cancel() {
    _cancelToken.cancel('Cancelled');
  }

  @override
  Future getData(
      {required String url,
      Map<String, dynamic>? queryParams,
      Map<String, dynamic>? header}) async {
    try {
      var res = await dio.get(
        url,
        cancelToken: _cancelToken,
        queryParameters: queryParams,
        options: Options(
          headers: header ?? this.header,
          validateStatus: (status) {
            return status! < 500;
          },
        ),
      );
      // dikomen karena kemungkinan dipakai jika diperlukan untuk melakukan trace error
      // log(jsonEncode(url), name: "url");
      // log(jsonEncode(queryParams), name: "Paraams");
      // log(jsonEncode(header), name: "Header");
      // log(jsonEncode(res.data), name: "Respose");
      if (res.statusCode == 200 || res.statusCode == 201) {
        return res.data;
      } else if (res.statusCode == 401) {
        throw res.data['error'];
      } else if (res.statusCode == 404) {
        throw res.statusCode.toString();
      } else {
        if (res.data is String) {
          throw res.data;
        } else if (res.data['error'] != null) {
          throw "${res.data['error']}";
        } else {
          throw "${res.statusMessage}";
        }
      }
    } on DioException catch (e) {
      throw dioErrorHandler(errorType: e);
    }
  }

  @override
  Future postData({
    required String url,
    dynamic param,
    Map<String, dynamic>? header,
    showDialogExpired = true,
  }) async {
    try {
      // log(jsonEncode(url), name: "url");
      // log(jsonEncode(header), name: "Header");
      // log(param.toString(), name: "param");
      // log(param.toString(), name: "d");
      var res = await dio.post(
        url,
        cancelToken: cancel(),
        data: param,
        options: Options(
          headers: header,
          validateStatus: (status) {
            return status! < 500;
          },
        ),
      );
      // List<String>? cookies = res.headers['set-cookie'];
      // log(jsonEncode(res), name: "responsezz");
      // log(jsonEncode(url),name: "url");
      // log(jsonEncode(header),name: "Header");
      if (res.statusCode == 200 || res.statusCode == 201) {
        return res.data;
      } else if (res.statusCode == 401) {
        throw res.data['error'];
      } else if (res.statusCode == 404) {
        throw "URL path tidak ditemukan";
      } else {
        if (res.data['error'] != null) {
          throw res.data['error'];
        } else {
          throw "Error ${res.statusMessage}";
        }
      }
    } on DioException catch (e) {
      throw dioErrorHandler(errorType: e);
    }
  }

  @override
  Future putData(
      {required String url,
      String? param,
      Map<String, dynamic>? header}) async {
    try {
      var res = await dio.put(
        url,
        data: param,
        cancelToken: _cancelToken,
        options: Options(
          headers: header,
          validateStatus: (status) {
            return status! < 500;
          },
        ),
      );
      if (res.statusCode == 200) {
        return res.data;
      } else if (res.statusCode == 401) {
        throw res.data['error'];
      } else {
        if (res.data['error'] != null) {
          throw res.data['error'];
        } else {
          throw "Error ${res.statusMessage}";
        }
      }
    } on DioException catch (e) {
      throw dioErrorHandler(errorType: e);
    }
  }

  @override
  Future patchData(
      {required String url,
      String? param,
      Map<String, dynamic>? header}) async {
    try {
      var res = await dio.patch(
        url,
        data: param,
        cancelToken: _cancelToken,
        options: Options(
          headers: header,
          validateStatus: (status) {
            return status! < 500;
          },
        ),
      );
      if (res.statusCode == 200 || res.statusCode == 201) {
        return res;
      } else if (res.statusCode == 401) {
        throw res.data['error'];
      } else {
        if (res.data['error'] != null) {
          throw res.data['error'];
        } else {
          throw "Error ${res.statusMessage}";
        }
      }
    } on DioException catch (e) {
      throw dioErrorHandler(errorType: e);
    }
  }

  String dioErrorHandler({required DioException errorType}) {
    String msg = "";
    switch (errorType) {
      case DioException.receiveTimeout:
        msg = "Gagal menerima data";
        break;
      case DioException.connectionTimeout:
        msg = "Koneksi tidak stabil";
        break;
      case DioException.sendTimeout:
        msg = "Gagal mengirim data";
        break;
      case DioException.connectionError:
        msg = "Koneksi Internet Terputus";
        break;
      case DioException.requestCancelled:
        msg = "Request ";
        break;
      default:
        msg = "Error Data";
    }
    return msg;
  }

  @override
  Future deleteData(
      {required String url,
      dynamic param,
      Map<String, dynamic>? header}) async {
    try {
      var res = await dio.delete(
        url,
        data: param,
        cancelToken: _cancelToken,
        options: Options(
          headers: header,
          validateStatus: (status) {
            return status! < 500;
          },
        ),
      );
      if (res.statusCode == 200) {
        return res;
      } else if (res.statusCode == 401) {
        throw res.data['error'];
      } else {
        throw "Error ${res.statusMessage}";
      }
    } on DioException catch (e) {
      throw dioErrorHandler(errorType: e);
    }
  }
}
