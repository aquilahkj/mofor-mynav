import 'package:dio/dio.dart';
import 'package:mynav/models/entity.dart';
import 'package:mynav/net/dio_client.dart';

class OAuthService {
  DioClient _dioClient;
  OAuthService({DioClient dioClient}) {
    if (dioClient != null) {
      _dioClient = dioClient;
    } else {
      _dioClient = DioClient.instance;
    }
  }

  Future<JsonWebTokenModel> signIn(AppLoginRequestModel model, {CancelToken cancelToken}) async {
    var res = await _dioClient.postRequest('/api/oAuth/signIn', model.toMap(), cancelToken: cancelToken);
    return JsonWebTokenModel.fromMap(res);
  }

  Future<JsonWebTokenModel> signInByCode(AppLoginByCodeRequestModel model, {CancelToken cancelToken}) async {
    var res = await _dioClient.postRequest('/api/oAuth/signInByCode', model.toMap(), cancelToken: cancelToken);
    return JsonWebTokenModel.fromMap(res);
  }

  Future<JsonWebTokenModel> refreshToken(RefreshTokenRequestModel model, {CancelToken cancelToken}) async {
    var res = await _dioClient.postRequest('/api/oAuth/refreshToken', model.toMap(), cancelToken: cancelToken);
    return JsonWebTokenModel.fromMap(res);
  }
}
