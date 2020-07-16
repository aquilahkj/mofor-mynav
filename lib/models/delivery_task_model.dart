import 'dart:convert';

class DeliveryTaskModel {
  DeliveryTaskModel({
    this.id,
    this.sheet,
    this.waybillId,
    this.waybillSheet,
    this.shippingPointName,
    this.taskType,
    this.status,
    this.statusDesc,
    this.beginPointLongitude,
    this.beginPointLatitude,
    this.beginPointAddress,
    this.beginPointLinkmanName,
    this.beginPointLinkmanPhone,
    this.endPointLongitude,
    this.endPointLatitude,
    this.endPointAddress,
    this.endPointLinkmanName,
    this.endPointLinkmanPhone,
    this.commission,
    this.creationTime,
    this.beginTime,
    this.arrivalTime,
    this.orderType,
    this.orderTypeDescription,
    this.pickupBeginTime,
    this.pickupEndTime,
    this.promiseBeginTime,
    this.promiseEndTime,
    this.isDelay,
    this.delayBeginTime,
    this.delayEndTime,
    this.isSettled,
    this.isOverTime,
    this.bagQty,
    this.beginPointDistance,
    this.endPointDistance,
    this.isArrivedAtPick,
  });

  final String id;
  final String sheet;
  final String waybillId;
  final String waybillSheet;
  final String shippingPointName;
  final int taskType;
  final int status;
  final String statusDesc;
  final double beginPointLongitude;
  final double beginPointLatitude;
  final String beginPointAddress;
  final String beginPointLinkmanName;
  final String beginPointLinkmanPhone;
  final double endPointLongitude;
  final double endPointLatitude;
  final String endPointAddress;
  final String endPointLinkmanName;
  final String endPointLinkmanPhone;
  final double commission;
  final DateTime creationTime;
  final DateTime beginTime;
  final DateTime arrivalTime;
  final int orderType;
  final String orderTypeDescription;
  final DateTime pickupBeginTime;
  final DateTime pickupEndTime;
  final DateTime promiseBeginTime;
  final DateTime promiseEndTime;
  final bool isDelay;
  final DateTime delayBeginTime;
  final DateTime delayEndTime;
  final bool isSettled;
  final bool isOverTime;
  final int bagQty;
  final double beginPointDistance;
  final double endPointDistance;
  final bool isArrivedAtPick;

  DeliveryTaskModel copyWith({
    String id,
    String sheet,
    String waybillId,
    String waybillSheet,
    String shippingPointName,
    int taskType,
    int status,
    String statusDesc,
    double beginPointLongitude,
    double beginPointLatitude,
    String beginPointAddress,
    String beginPointLinkmanName,
    String beginPointLinkmanPhone,
    double endPointLongitude,
    double endPointLatitude,
    String endPointAddress,
    String endPointLinkmanName,
    String endPointLinkmanPhone,
    double commission,
    DateTime creationTime,
    DateTime beginTime,
    DateTime arrivalTime,
    int orderType,
    String orderTypeDescription,
    DateTime pickupBeginTime,
    DateTime pickupEndTime,
    DateTime promiseBeginTime,
    DateTime promiseEndTime,
    bool isDelay,
    DateTime delayBeginTime,
    DateTime delayEndTime,
    bool isSettled,
    bool isOverTime,
    int bagQty,
    double beginPointDistance,
    double endPointDistance,
    bool isArrivedAtPick,
  }) =>
      DeliveryTaskModel(
        id: id ?? this.id,
        sheet: sheet ?? this.sheet,
        waybillId: waybillId ?? this.waybillId,
        waybillSheet: waybillSheet ?? this.waybillSheet,
        shippingPointName: shippingPointName ?? this.shippingPointName,
        taskType: taskType ?? this.taskType,
        status: status ?? this.status,
        statusDesc: statusDesc ?? this.statusDesc,
        beginPointLongitude: beginPointLongitude ?? this.beginPointLongitude,
        beginPointLatitude: beginPointLatitude ?? this.beginPointLatitude,
        beginPointAddress: beginPointAddress ?? this.beginPointAddress,
        beginPointLinkmanName: beginPointLinkmanName ?? this.beginPointLinkmanName,
        beginPointLinkmanPhone: beginPointLinkmanPhone ?? this.beginPointLinkmanPhone,
        endPointLongitude: endPointLongitude ?? this.endPointLongitude,
        endPointLatitude: endPointLatitude ?? this.endPointLatitude,
        endPointAddress: endPointAddress ?? this.endPointAddress,
        endPointLinkmanName: endPointLinkmanName ?? this.endPointLinkmanName,
        endPointLinkmanPhone: endPointLinkmanPhone ?? this.endPointLinkmanPhone,
        commission: commission ?? this.commission,
        creationTime: creationTime ?? this.creationTime,
        beginTime: beginTime ?? this.beginTime,
        arrivalTime: arrivalTime ?? this.arrivalTime,
        orderType: orderType ?? this.orderType,
        orderTypeDescription: orderTypeDescription ?? this.orderTypeDescription,
        pickupBeginTime: pickupBeginTime ?? this.pickupBeginTime,
        pickupEndTime: pickupEndTime ?? this.pickupEndTime,
        promiseBeginTime: promiseBeginTime ?? this.promiseBeginTime,
        promiseEndTime: promiseEndTime ?? this.promiseEndTime,
        isDelay: isDelay ?? this.isDelay,
        delayBeginTime: delayBeginTime ?? this.delayBeginTime,
        delayEndTime: delayEndTime ?? this.delayEndTime,
        isSettled: isSettled ?? this.isSettled,
        isOverTime: isOverTime ?? this.isOverTime,
        bagQty: bagQty ?? this.bagQty,
        beginPointDistance: beginPointDistance ?? this.beginPointDistance,
        endPointDistance: endPointDistance ?? this.endPointDistance,
        isArrivedAtPick: isArrivedAtPick ?? this.isArrivedAtPick,
      );

  factory DeliveryTaskModel.fromJson(String str) => DeliveryTaskModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DeliveryTaskModel.fromMap(Map<String, dynamic> json) => DeliveryTaskModel(
        id: json["id"],
        sheet: json["sheet"],
        waybillId: json["waybillId"],
        waybillSheet: json["waybillSheet"],
        shippingPointName: json["shippingPointName"],
        taskType: json["taskType"],
        status: json["status"],
        statusDesc: json["statusDesc"],
        beginPointLongitude: json["beginPointLongitude"],
        beginPointLatitude: json["beginPointLatitude"],
        beginPointAddress: json["beginPointAddress"],
        beginPointLinkmanName: json["beginPointLinkmanName"],
        beginPointLinkmanPhone: json["beginPointLinkmanPhone"],
        endPointLongitude: json["endPointLongitude"],
        endPointLatitude: json["endPointLatitude"],
        endPointAddress: json["endPointAddress"],
        endPointLinkmanName: json["endPointLinkmanName"],
        endPointLinkmanPhone: json["endPointLinkmanPhone"],
        commission: json["commission"],
        creationTime: json["creationTime"] == null ? null : DateTime.parse(json["creationTime"]),
        beginTime: json["beginTime"] == null ? null : DateTime.parse(json["beginTime"]),
        arrivalTime: json["arrivalTime"] == null ? null : DateTime.parse(json["arrivalTime"]),
        orderType: json["orderType"],
        orderTypeDescription: json["orderTypeDescription"],
        pickupBeginTime: json["pickupBeginTime"] == null ? null : DateTime.parse(json["pickupBeginTime"]),
        pickupEndTime: json["pickupEndTime"] == null ? null : DateTime.parse(json["pickupEndTime"]),
        promiseBeginTime: json["promiseBeginTime"] == null ? null : DateTime.parse(json["promiseBeginTime"]),
        promiseEndTime: json["promiseEndTime"] == null ? null : DateTime.parse(json["promiseEndTime"]),
        isDelay: json["isDelay"],
        delayBeginTime: json["delayBeginTime"] == null ? null : DateTime.parse(json["delayBeginTime"]),
        delayEndTime: json["delayEndTime"] == null ? null : DateTime.parse(json["delayEndTime"]),
        isSettled: json["isSettled"],
        isOverTime: json["isOverTime"],
        bagQty: json["bagQty"],
        beginPointDistance: json["beginPointDistance"],
        endPointDistance: json["endPointDistance"],
        isArrivedAtPick: json["isArrivedAtPick"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "sheet": sheet,
        "waybillId": waybillId,
        "waybillSheet": waybillSheet,
        "shippingPointName": shippingPointName,
        "taskType": taskType,
        "status": status,
        "statusDesc": statusDesc,
        "beginPointLongitude": beginPointLongitude,
        "beginPointLatitude": beginPointLatitude,
        "beginPointAddress": beginPointAddress,
        "beginPointLinkmanName": beginPointLinkmanName,
        "beginPointLinkmanPhone": beginPointLinkmanPhone,
        "endPointLongitude": endPointLongitude,
        "endPointLatitude": endPointLatitude,
        "endPointAddress": endPointAddress,
        "endPointLinkmanName": endPointLinkmanName,
        "endPointLinkmanPhone": endPointLinkmanPhone,
        "commission": commission,
        "creationTime": creationTime == null ? null : creationTime.toIso8601String(),
        "beginTime": beginTime == null ? null : beginTime.toIso8601String(),
        "arrivalTime": arrivalTime == null ? null : arrivalTime.toIso8601String(),
        "orderType": orderType,
        "orderTypeDescription": orderTypeDescription,
        "pickupBeginTime": pickupBeginTime == null ? null : pickupBeginTime.toIso8601String(),
        "pickupEndTime": pickupEndTime == null ? null : pickupEndTime.toIso8601String(),
        "promiseBeginTime": promiseBeginTime == null ? null : promiseBeginTime.toIso8601String(),
        "promiseEndTime": promiseEndTime == null ? null : promiseEndTime.toIso8601String(),
        "isDelay": isDelay,
        "delayBeginTime": delayBeginTime == null ? null : delayBeginTime.toIso8601String(),
        "delayEndTime": delayEndTime == null ? null : delayEndTime.toIso8601String(),
        "isSettled": isSettled,
        "isOverTime": isOverTime,
        "bagQty": bagQty,
        "beginPointDistance": beginPointDistance,
        "endPointDistance": endPointDistance,
        "isArrivedAtPick": isArrivedAtPick,
      };
}
