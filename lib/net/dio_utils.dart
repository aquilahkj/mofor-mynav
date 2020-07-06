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

typedef SuccessCallback = Function(dynamic data);
typedef ErrorCallback = Function(int code, String msg);

/// @weilu https://github.com/simplezhli
class DioUtils {
  static final DioUtils _singleton = DioUtils._();

  static DioUtils get instance => DioUtils();

  factory DioUtils() => _singleton;

  static Dio _dio;

  Dio get dio => _dio;

  DioUtils._() {
    BaseOptions _options = BaseOptions(
      connectTimeout: _connectTimeout,
      receiveTimeout: _receiveTimeout,
      sendTimeout: _sendTimeout,
      responseType: ResponseType.plain,
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
      throw NetError(response.statusCode,
          'service error: statusCode: ${response.statusCode}');
    }
    ResultModel result;
    try {
      result = ResultModel.fromJson(response.data.toString());
    } catch (e) {
      print(e);
      throw NetError(ExceptionHandle.parse_error, 'Result data parse error',
          error: e);
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
    return await _request("GET", url,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
        options: options);
  }

  Future<dynamic> postRequest(
    String url,
    dynamic data, {
    Map<String, dynamic> queryParameters,
    CancelToken cancelToken,
    Options options,
  }) async {
    return await _request("POST", url,
        data: data,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
        options: options);
  }

  Future<dynamic> putRequest(
    String url,
    dynamic data, {
    Map<String, dynamic> queryParameters,
    CancelToken cancelToken,
    Options options,
  }) async {
    return await _request("PUT", url,
        data: data,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
        options: options);
  }

  Future<dynamic> patchRequest(
    String url,
    dynamic data, {
    Map<String, dynamic> queryParameters,
    CancelToken cancelToken,
    Options options,
  }) async {
    return await _request("PATCH", url,
        data: data,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
        options: options);
  }

  Future<dynamic> deleteRequest(
    String url, {
    dynamic data,
    Map<String, dynamic> queryParameters,
    CancelToken cancelToken,
    Options options,
  }) async {
    return await _request("DELETE", url,
        data: data,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
        options: options);
  }

  Future<dynamic> headRequest(
    String url, {
    Map<String, dynamic> queryParameters,
    CancelToken cancelToken,
    Options options,
  }) async {
    return await _request("HEAD", url,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
        options: options);
  }

  Options _checkOptions(String method, Options options) {
    options ??= Options();
    options.method = method;
    return options;
  }

  // Future request(
  //   Method method,
  //   String url, {
  //   SuccessCallback onSuccess,
  //   ErrorCallback onError,
  //   dynamic params,
  //   Map<String, dynamic> queryParameters,
  //   CancelToken cancelToken,
  //   Options options,
  // }) {
  //   String m = _getRequestMethod(method);
  //   return _request(
  //     m,
  //     url,
  //     data: params,
  //     queryParameters: queryParameters,
  //     options: options,
  //     cancelToken: cancelToken,
  //   ).then((ResultEntity result) {
  //     if (result.code == 0) {
  //       if (onSuccess != null) {
  //         onSuccess(result.data);
  //       }
  //     } else {
  //       _onError(result.code, result.message, onError);
  //     }
  //   }, onError: (dynamic e) {
  //     _cancelLogPrint(e, url);
  //     final NetError error = ExceptionHandle.handleException(e);
  //     _onError(error.code, error.msg, onError);
  //   });
  // }

  // Future<ResultEntity> request(
  //   Method method,
  //   String url, {
  //   dynamic params,
  //   Map<String, dynamic> queryParameters,
  //   CancelToken cancelToken,
  //   Options options,
  // }) async {
  //   String m = _getRequestMethod(method);
  //   ResultEntity result;
  //   try {
  //     result = await _request(
  //       m,
  //       url,
  //       data: params,
  //       queryParameters: queryParameters,
  //       options: options,
  //       cancelToken: cancelToken,
  //     );
  //   } catch (e, s) {
  //     final NetError error = ExceptionHandle.handleException(e);
  //     _cancel(e, url);
  //     throw error;
  //   }
  //   if (result.code != 0) {}
  //   return result;
  // }

  void _cancel(dynamic e, String url) {
    if (e is DioError && CancelToken.isCancel(e)) {
      Log.e('取消请求接口： $url');
    }
  }

  // void _onError(int code, String msg, ErrorCallback onError) {
  //   if (code == null) {
  //     code = ExceptionHandle.unknown_error;
  //     msg = '未知异常';
  //   }
  //   Log.e('接口请求异常： code: $code, mag: $msg');
  //   if (onError != null) {
  //     onError(code, msg);
  //   }
  // }

  // String _getRequestMethod(Method method) {
  //   String m;
  //   switch (method) {
  //     case Method.get:
  //       m = 'GET';
  //       break;
  //     case Method.post:
  //       m = 'POST';
  //       break;
  //     case Method.put:
  //       m = 'PUT';
  //       break;
  //     case Method.patch:
  //       m = 'PATCH';
  //       break;
  //     case Method.delete:
  //       m = 'DELETE';
  //       break;
  //     case Method.head:
  //       m = 'HEAD';
  //       break;
  //   }
  //   return m;
  // }
}

// Map<String, dynamic> parseData(String data) {
//   return json.decode(data);
// }

// enum Method { get, post, put, patch, delete, head }
