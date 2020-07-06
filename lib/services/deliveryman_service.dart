import 'package:dio/dio.dart';
import 'package:mynav/models/deliveryman_app_detail_dto.dart';
import 'package:mynav/net/dio_utils.dart';

class DeliverymanService {
  static Future<DeliverymanAppDetailDto> getDetail(
      {CancelToken cancelToken}) async {
    var res = await DioUtils.instance
        .getRequest('/api/Deliveryman', cancelToken: cancelToken);
    return DeliverymanAppDetailDto.fromMap(res);
  }
}
