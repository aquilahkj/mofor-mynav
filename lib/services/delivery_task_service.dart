import 'package:dio/dio.dart';
import 'package:mynav/models/delivery_task_model.dart';
import 'package:mynav/models/delivery_task_query.dart';
import 'package:mynav/models/page_list.dart';
import 'package:mynav/net/dio_client.dart';

class DeliveryTaskService {
  DioClient _dioClient;
  DeliveryTaskService({DioClient dioClient}) {
    if (dioClient != null) {
      _dioClient = dioClient;
    } else {
      _dioClient = DioClient.instance;
    }
  }

  Future<PageList<DeliveryTaskModel>> query(DeliveryTaskQuery query, {CancelToken cancelToken}) async {
    var res = await _dioClient.getRequest('/api/deliveryTask/query',
        queryParameters: query.toMap(), cancelToken: cancelToken);
    final data = res['data'].map<DeliveryTaskModel>((item) => DeliveryTaskModel.fromMap(item)).toList();
    return PageList<DeliveryTaskModel>.create(res, data);
  }
}
