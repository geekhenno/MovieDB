import 'package:dio/dio.dart';
import 'package:movies/constants/constants.dart';

abstract class BaseDioApi {
  Dio _dio = new Dio();
  Response _response;
  String reqUrl;
  dynamic getResponse(Map<String, dynamic> response);

  Map<String, dynamic> getQueryParameters() {
    return {"api_key": Constants.movieApiKey};
  }

  dynamic data() {
    return {};
  }

  Future<Map<String, dynamic>> postRequest() async {
    dynamic _data = data();
    try {
      _response = await _dio.post(
        reqUrl,
        options: Options(
          headers: {},
        ),
        data: _data,
      );

      return getResponse({"data": _response.data, "status": true});
    } catch (e) {
      if (e is DioError) {
        return {'data': e.response, 'status': false, 'error': e.error};
      }
      return {'data': e, 'status': false};
    }
  }

  Future<Map<String, dynamic>> getRequest() async {
    print("getQueryParameters ${getQueryParameters()}");
    print("reqUrl $reqUrl");
    try {
      _response = await _dio.get(
        reqUrl,
        queryParameters: getQueryParameters(),
        options: Options(
          headers: {},
        ),
      );
      return getResponse({"data": _response.data, "status": true});
    } catch (e) {
      if (e is DioError) {
        print("dio Error $e");
        return {'data': e.response?.data, 'status': false, 'error': e.error};
      }
      print("Error $e");
      return {'data': e, 'status': false};
    }
  }

  Future<Map<String, dynamic>> putRequest() async {
    dynamic _data = data();

    try {
      _response = await _dio.put(
        reqUrl,
        data: _data,
        options: Options(
          headers: {},
        ),
      );

      return getResponse({"data": _response.data, "status": true});
    } catch (e) {
      if (e is DioError) {
        return {'data': e.response, 'status': false, 'error': e.error};
      }
      return {'data': e, 'status': false};
    }
  }

  Future<Map<String, dynamic>> postFormRequest() async {
    Map<String, dynamic> queries = getQueryParameters();
    final _data = data();
    try {
      _response = await _dio.post(
        reqUrl,
        queryParameters: queries,
        data: FormData.fromMap(_data),
        options: Options(headers: {}),
      );

      return getResponse({"data": _response.data, "status": true});
    } catch (e) {
      if (e is DioError) {
        return {'data': e.response, 'status': false, 'error': e.error};
      }
      return {'data': e, 'status': false};
    }
  }

  Future<Map<String, dynamic>> deleteRequest() async {
    Map<String, dynamic> queries = getQueryParameters();

    try {
      _response = await _dio.delete(
        reqUrl,
        queryParameters: queries,
        //  data: jsonEncode(data),
        options: Options(
          headers: {},
        ),
      );

      return getResponse({"data": _response.data, "status": true});
    } catch (e) {
      if (e is DioError) {
        return {'data': e.response, 'status': false, 'error': e.error};
      }
      return {'data': e, 'status': false};
    }
  }
}
