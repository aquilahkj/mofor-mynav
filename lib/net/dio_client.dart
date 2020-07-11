import 'dart:io';

import 'package:dio/dio.dart';
import 'package:mynav/models/result_model.dart';
import 'package:mynav/utils/log_utils.dart';
import 'error_handle.dart';

/// 默认dio配置
int _connectTimeout = 15000;
int _receiveTimeout = 15000;
int _sendTimeout = 10000;
String _baseUrl;
List<Interceptor> _interceptors = [];

/// 初始化Dio配置
void setInitDio({
  int connectTimeout,
  int receiveTimeout,
  int sendTimeout,
  String baseUrl,
  List<Interceptor> interceptors,
}) {
  _connectTimeout = connectTimeout ?? _connectTimeout;
  _receiveTimeout = receiveTimeout ?? _receiveTimeout;
  _sendTimeout = sendTimeout ?? _sendTimeout;
  _baseUrl = baseUrl ?? _baseUrl;
  _interceptors = interceptors ?? _interceptors;
}

/// @weilu https://github.com/simplezhli
class DioClient {
  static final DioClient _singleton = DioClient._();

  static DioClient get instance => _singleton;

  // factory DioClient() => _singleton;

  Dio _dio;

  Dio get dio => _dio;

  DioClient._() {
    final _options = BaseOptions(
      connectTimeout: _connectTimeout,
      receiveTimeout: _receiveTimeout,
      sendTimeout: _sendTimeout,
      responseType: ResponseType.json,
      validateStatus: (status) {
        // 不使用http状态码判断状态，使用AdapterInterceptor来处理（适用于标准REST风格）
        return true;
      },
      baseUrl: _baseUrl,
//  contentType: ContentType('application', 'x-www-form-urlencoded', charset: 'utf-8'),
    );
    _dio = Dio(_options);

    /// Fiddler抓包代理配置 https://www.jianshu.com/p/d831b1f7c45b
//    (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
//        (HttpClient client) {
//      client.findProxy = (uri) {
//        //proxy all request to localhost:8888
//        return 'PROXY 10.41.0.132:8888';
//      };
//      client.badCertificateCallback =
//          (X509Certificate cert, String host, int port) => true;
//    };

    /// 添加拦截器
    _interceptors.forEach((interceptor) {
      _dio.interceptors.add(interceptor);
    });
  }

  DioClient(this._dio);

  // 数据返回格式统一，统一处理异常
  Future<dynamic> _request(
    String method,
    String url, {
    dynamic data,
    Map<String, dynamic> queryParameters,
    CancelToken cancelToken,
    Options options,
  }) async {
    Response response;
    try {
      response = await _dio.request(
        url,
        data: data,
        queryParameters: queryParameters,
        options: _checkOptions(method, options),
        cancelToken: cancelToken,
      );
    } catch (e) {
      _cancel(e, url);
      print(e);
      throw ExceptionHandle.handleException(e);
    }
    if (response.statusCode != HttpStatus.ok) {
      throw NetError(response.statusCode, 'service error: statusCode: ${response.statusCode}');
    }

    ResultModel result;
    try {
      result = ResultModel.fromJson(response.data);
    } catch (e) {
      print(e);
      throw NetError(ExceptionHandle.parse_error, 'Result data parse error', error: e);
    }
    if (result.code != 1) {
      print('$url error, code:${result.code}, message:${result.message}');
      throw NetError(result.code, result.message);
    }
    return result.data;
  }

  Future<dynamic> getRequest(
    String url, {
    Map<String, dynamic> queryParameters,
    CancelToken cancelToken,
    Options options,
  }) async {
    return await _request("GET", url, queryParameters: queryParameters, cancelToken: cancelToken, options: options);
  }

  Future<dynamic> postRequest(
    String url,
    dynamic data, {
    Map<String, dynamic> queryParameters,
    CancelToken cancelToken,
    Options options,
  }) async {
    return await _request("POST", url,
        data: data, queryParameters: queryParameters, cancelToken: cancelToken, options: options);
  }

  Future<dynamic> putRequest(
    String url,
    dynamic data, {
    Map<String, dynamic> queryParameters,
    CancelToken cancelToken,
    Options options,
  }) async {
    return await _request("PUT", url,
        data: data, queryParameters: queryParameters, cancelToken: cancelToken, options: options);
  }

  Future<dynamic> patchRequest(
    String url,
    dynamic data, {
    Map<String, dynamic> queryParameters,
    CancelToken cancelToken,
    Options options,
  }) async {
    return await _request("PATCH", url,
        data: data, queryParameters: queryParameters, cancelToken: cancelToken, options: options);
  }

  Future<dynamic> deleteRequest(
    String url, {
    dynamic data,
    Map<String, dynamic> queryParameters,
    CancelToken cancelToken,
    Options options,
  }) async {
    return await _request("DELETE", url,
        data: data, queryParameters: queryParameters, cancelToken: cancelToken, options: options);
  }

  Future<dynamic> headRequest(
    String url, {
    Map<String, dynamic> queryParameters,
    CancelToken cancelToken,
    Options options,
  }) async {
    return await _request("HEAD", url, queryParameters: queryParameters, cancelToken: cancelToken, options: options);
  }

  Options _checkOptions(String method, Options options) {
    options ??= Options();
    options.method = method;
    options.responseType = ResponseType.plain;
    return options;
  }

  void _cancel(dynamic e, String url) {
    if (e is DioError && CancelToken.isCancel(e)) {
      LogUtils.e('取消请求接口： $url');
    }
  }
}
