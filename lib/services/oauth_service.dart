import 'package:dio/dio.dart';
import 'package:mynav/models/app_login_request_model.dart';
import 'package:mynav/models/json_web_token_model.dart';
import 'package:mynav/net/dio_utils.dart';

class OAuthService {
  static Future<JsonWebTokenModel> signIn(AppLoginRequestModel model,
      {CancelToken cancelToken}) async {
    var res = await DioUtils.instance.postRequest(
        '/api/oAuth/signIn', model.toMap(),
        cancelToken: cancelToken);
    return JsonWebTokenModel.fromMap(res);
  }

//   // static Future refreshToken(Map params) async {
//   //   var res = await NetUtils()
//   //     .post(url: '/api/oAuth/refreshToken', params: params);
//   //   return res;
//   // }

//   // static Future getVerificationCode(Map params) async {
//   //   var res = await NetUtils()
//   //     .post(url: '/api/common/sendCode', params: params);
//   //   return res;
//   // }

//   // static Future loginByCode(Map params) async {
//   //   var res = await NetUtils()
//   //     .post(url: '/api/oAuth/signInByCode', params: params);
//   //   return res;
//   // }
}
