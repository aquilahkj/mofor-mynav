import 'dart:convert';

class DeliverymanAppDetailDto {
  DeliverymanAppDetailDto({
    this.id,
    this.type,
    this.name,
    this.phone,
    this.enabled,
    this.accountEnabled,
    this.canTakeTask,
    this.isSetPayPassword,
    this.verifyStatus,
    this.isVerify,
    this.jobShippingCenterId,
    this.jobShippingCenterName,
    this.jobShippingPointId,
    this.jobShippingPointName,
    this.jobShippingPointLongitude,
    this.jobShippingPointLatitude,
    this.reason,
    this.canPushMt,
    this.canCreateTrunkReturn,
    this.headPicture,
    this.isNeedPayDeposit,
    this.isPayDeposit,
  });

  final String id;
  final int type;
  final String name;
  final String phone;
  final bool enabled;
  final bool accountEnabled;
  final bool canTakeTask;
  final bool isSetPayPassword;
  final int verifyStatus;
  final bool isVerify;
  final String jobShippingCenterId;
  final String jobShippingCenterName;
  final String jobShippingPointId;
  final String jobShippingPointName;
  final int jobShippingPointLongitude;
  final int jobShippingPointLatitude;
  final String reason;
  final bool canPushMt;
  final bool canCreateTrunkReturn;
  final String headPicture;
  final bool isNeedPayDeposit;
  final bool isPayDeposit;

  DeliverymanAppDetailDto copyWith({
    String id,
    int type,
    String name,
    String phone,
    bool enabled,
    bool accountEnabled,
    bool canTakeTask,
    bool isSetPayPassword,
    int verifyStatus,
    bool isVerify,
    String jobShippingCenterId,
    String jobShippingCenterName,
    String jobShippingPointId,
    String jobShippingPointName,
    int jobShippingPointLongitude,
    int jobShippingPointLatitude,
    String reason,
    bool canPushMt,
    bool canCreateTrunkReturn,
    String headPicture,
    bool isNeedPayDeposit,
    bool isPayDeposit,
  }) =>
      DeliverymanAppDetailDto(
        id: id ?? this.id,
        type: type ?? this.type,
        name: name ?? this.name,
        phone: phone ?? this.phone,
        enabled: enabled ?? this.enabled,
        accountEnabled: accountEnabled ?? this.accountEnabled,
        canTakeTask: canTakeTask ?? this.canTakeTask,
        isSetPayPassword: isSetPayPassword ?? this.isSetPayPassword,
        verifyStatus: verifyStatus ?? this.verifyStatus,
        isVerify: isVerify ?? this.isVerify,
        jobShippingCenterId: jobShippingCenterId ?? this.jobShippingCenterId,
        jobShippingCenterName:
            jobShippingCenterName ?? this.jobShippingCenterName,
        jobShippingPointId: jobShippingPointId ?? this.jobShippingPointId,
        jobShippingPointName: jobShippingPointName ?? this.jobShippingPointName,
        jobShippingPointLongitude:
            jobShippingPointLongitude ?? this.jobShippingPointLongitude,
        jobShippingPointLatitude:
            jobShippingPointLatitude ?? this.jobShippingPointLatitude,
        reason: reason ?? this.reason,
        canPushMt: canPushMt ?? this.canPushMt,
        canCreateTrunkReturn: canCreateTrunkReturn ?? this.canCreateTrunkReturn,
        headPicture: headPicture ?? this.headPicture,
        isNeedPayDeposit: isNeedPayDeposit ?? this.isNeedPayDeposit,
        isPayDeposit: isPayDeposit ?? this.isPayDeposit,
      );

  factory DeliverymanAppDetailDto.fromJson(String str) =>
      DeliverymanAppDetailDto.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DeliverymanAppDetailDto.fromMap(Map<String, dynamic> json) =>
      DeliverymanAppDetailDto(
        id: json["id"],
        type: json["type"],
        name: json["name"],
        phone: json["phone"],
        enabled: json["enabled"],
        accountEnabled: json["accountEnabled"],
        canTakeTask: json["canTakeTask"],
        isSetPayPassword: json["isSetPayPassword"],
        verifyStatus: json["verifyStatus"],
        isVerify: json["isVerify"],
        jobShippingCenterId: json["jobShippingCenterId"],
        jobShippingCenterName: json["jobShippingCenterName"],
        jobShippingPointId: json["jobShippingPointId"],
        jobShippingPointName: json["jobShippingPointName"],
        jobShippingPointLongitude: json["jobShippingPointLongitude"],
        jobShippingPointLatitude: json["jobShippingPointLatitude"],
        reason: json["reason"],
        canPushMt: json["canPushMt"],
        canCreateTrunkReturn: json["canCreateTrunkReturn"],
        headPicture: json["headPicture"],
        isNeedPayDeposit: json["isNeedPayDeposit"],
        isPayDeposit: json["isPayDeposit"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "type": type,
        "name": name,
        "phone": phone,
        "enabled": enabled,
        "accountEnabled": accountEnabled,
        "canTakeTask": canTakeTask,
        "isSetPayPassword": isSetPayPassword,
        "verifyStatus": verifyStatus,
        "isVerify": isVerify,
        "jobShippingCenterId": jobShippingCenterId,
        "jobShippingCenterName": jobShippingCenterName,
        "jobShippingPointId": jobShippingPointId,
        "jobShippingPointName": jobShippingPointName,
        "jobShippingPointLongitude": jobShippingPointLongitude,
        "jobShippingPointLatitude": jobShippingPointLatitude,
        "reason": reason,
        "canPushMt": canPushMt,
        "canCreateTrunkReturn": canCreateTrunkReturn,
        "headPicture": headPicture,
        "isNeedPayDeposit": isNeedPayDeposit,
        "isPayDeposit": isPayDeposit,
      };
}
