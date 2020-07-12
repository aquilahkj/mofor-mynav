import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:mynav/common/application.dart';
import 'package:mynav/models/refresh_token_request_model.dart';
import 'package:mynav/services/oauth_service.dart';
import 'package:mynav/utils/log_utils.dart';
import 'package:sprintf/sprintf.dart';

import 'dio_client.dart';
import 'error_handle.dart';

class AuthInterceptor extends Interceptor {
  @override
  Future onRequest(RequestOptions options) {
    final String accessToken = Application.getAccessToken();
    if (accessToken.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $accessToken';
    }

    return super.onRequest(options);
  }
}

class TokenInterceptor extends Interceptor {
  Future<String> getToken() async {
    final refreshToken = Application.getRefreshToken();
    if (refreshToken != null) {
      final model = RefreshTokenRequestModel(refreshToken: refreshToken);
      _tokenDio.options = DioClient.instance.dio.options;
      final client = DioClient(_tokenDio);
      final service = OAuthService(dioClient: client);
      try {
        final data = await service.refreshToken(model);
        Application.setToken(data.accessToken, data.refreshToken);
        return data.accessToken;
      } catch (e) {
        LogUtils.e('Refresh Token Failed！');
      }
    }
    return null;
  }

  Dio _tokenDio = Dio();

  @override
  Future<Object> onResponse(Response response) async {
    //401代表token过期
    if (response != null && response.statusCode == ExceptionHandle.unauthorized) {
      LogUtils.v('----------- Auto Refresh Token ------------');
      final Dio dio = DioClient.instance.dio;
      dio.interceptors.requestLock.lock();
      String accessToken = await getToken(); // 获取新的accessToken
      LogUtils.v('NewToken $accessToken');
      // SpUtil.putString(Constant.accessToken, accessToken);
      dio.interceptors.requestLock.unlock();

      if (accessToken != null) {
        // 重新请求失败接口
        final RequestOptions request = response.request;
        request.headers['Authorization'] = 'Bearer $accessToken';
        try {
          LogUtils.v('----------- Rerequest Interface ------------');

          /// 避免重复执行拦截器，使用tokenDio
          final Response response = await _tokenDio.request(request.path,
              data: request.data,
              queryParameters: request.queryParameters,
              cancelToken: request.cancelToken,
              options: request,
              onReceiveProgress: request.onReceiveProgress);
          return response;
        } on DioError catch (e) {
          return e;
        }
      }
    }
    return super.onResponse(response);
  }
}

class LoggingInterceptor extends Interceptor {
  DateTime _startTime;
  DateTime _endTime;

  @override
  Future onRequest(RequestOptions options) {
    _startTime = DateTime.now();
    LogUtils.v('----------Start----------');
    if (options.queryParameters.isEmpty) {
      LogUtils.v('RequestUrl: ' + options.baseUrl + options.path);
    } else {
      LogUtils.v(
          'RequestUrl: ' + options.baseUrl + options.path + '?' + Transformer.urlEncodeMap(options.queryParameters));
    }
    LogUtils.v('RequestMethod: ' + options.method);
    LogUtils.v('RequestHeaders:' + options.headers.toString());
    LogUtils.v('RequestContentType: ${options.contentType}');
    LogUtils.v('RequestData: ${options.data.toString()}');
    return super.onRequest(options);
  }

  @override
  Future onResponse(Response response) {
    _endTime = DateTime.now();
    int duration = _endTime.difference(_startTime).inMilliseconds;
    if (response.statusCode == ExceptionHandle.success) {
      LogUtils.v('ResponseCode: ${response.statusCode}');
    } else {
      LogUtils.e('ResponseCode: ${response.statusCode}');
    }
    // 输出结果
    LogUtils.v(response.data);
    LogUtils.v('----------End: $duration ms----------');
    return super.onResponse(response);
  }

  @override
  Future onError(DioError err) {
    LogUtils.v('----------Error-----------');
    return super.onError(err);
  }
}

class AdapterInterceptor extends Interceptor {
  static const String _kMsg = 'msg';
  static const String _kSlash = '\'';
  static const String _kMessage = 'message';

  static const String _kNotFound = 'No Data';

  static const String _kFailureFormat = '{\"code\":%d,\"message\":\"%s\"}';
  static const String _kSuccessFormat = '{\"code\":0,\"data\":null,\"message\":\"\"}';

  @override
  Future onResponse(Response response) {
    Response r = adapterData(response);
    return super.onResponse(r);
  }

  @override
  Future onError(DioError err) {
    if (err.response != null) {
      adapterData(err.response);
    }
    return super.onError(err);
  }

  Response adapterData(Response response) {
    String result;
    String content = response.data == null ? '' : response.data.toString();

    /// 成功时，直接格式化返回
    if (response.statusCode == ExceptionHandle.success || response.statusCode == ExceptionHandle.success_not_content) {
      if (content == null || content.isEmpty) {
        content = _kSuccessFormat;
      } else {
        result = content;
      }
      response.statusCode = ExceptionHandle.success;
    } else {
      if (response.statusCode == ExceptionHandle.not_found) {
        /// 错误数据格式化后，按照成功数据返回
        result = sprintf(_kFailureFormat, [response.statusCode, _kNotFound]);
        response.statusCode = ExceptionHandle.success;
      } else {
        if (content == null || content.isEmpty) {
          // 一般为网络断开等异常
          result = content;
        } else {
          String msg;
          try {
            content = content.replaceAll("\\", '');
            if (_kSlash == content.substring(0, 1)) {
              content = content.substring(1, content.length - 1);
            }
            Map<String, dynamic> map = json.decode(content);
            if (map.containsKey(_kMessage)) {
              msg = map[_kMessage];
            } else if (map.containsKey(_kMsg)) {
              msg = map[_kMsg];
            } else {
              msg = 'Unknow Error';
            }
            result = sprintf(_kFailureFormat, [response.statusCode, msg]);
            // 401 token失效时，单独处理，其他一律为成功
            if (response.statusCode == ExceptionHandle.unauthorized) {
              response.statusCode = ExceptionHandle.unauthorized;
            } else {
              response.statusCode = ExceptionHandle.success;
            }
          } catch (e) {
            LogUtils.v('Exception：$e');
            // 解析异常直接按照返回原数据处理（一般为返回500,503 HTML页面代码）
            result = sprintf(_kFailureFormat, [response.statusCode, 'Service Exception(${response.statusCode})']);
          }
        }
      }
    }
    response.data = result;
    return response;
  }
}
