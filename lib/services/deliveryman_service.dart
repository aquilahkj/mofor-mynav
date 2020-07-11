import 'package:dio/dio.dart';
import 'package:mynav/models/user_info_detail_model.dart';
import 'package:mynav/net/dio_client.dart';

class UserService {
  DioClient _dioClient;
  UserService({DioClient dioClient}) {
    if (dioClient != null) {
      _dioClient = dioClient;
    } else {
      _dioClient = DioClient.instance;
    }
  }

  Future<UserInfoDetailModel> getDetail({CancelToken cancelToken}) async {
    var res = await _dioClient.getRequest('/api/Deliveryman', cancelToken: cancelToken);
    return UserInfoDetailModel.fromMap(res);
  }
}
