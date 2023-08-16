abstract class DioContracts {
  Future getData(
      {required String url,
      Map<String, dynamic> header,
      Map<String, dynamic> queryParams});

  Future postData(
      {required String url, String? param, Map<String, dynamic> header});

  Future patchData(
      {required String url, String? param, Map<String, dynamic> header});

  Future deleteData(
      {required String url, String? param, Map<String, dynamic> header});

  Future putData(
      {required String url, String? param, Map<String, dynamic> header});
}
