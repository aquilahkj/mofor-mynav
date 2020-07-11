import 'dart:convert';

import 'package:mynav/common/app_error.dart';

class JwtUtils {
  static Map<String, dynamic> parseJwt(String token) {
    if (token == null) throw AppError('Token为空');
    final parts = token.split('.');
    if (parts.length != 3) {
      throw AppError('Token结构错误');
    }
    final payload = parts[1];
    var normalized = base64Url.normalize(payload);
    var data = utf8.decode(base64Url.decode(normalized));
    final payloadMap = json.decode(data);
    if (payloadMap is! Map<String, dynamic>) {
      throw AppError('Token分析错误');
    }
    return payloadMap;
  }
}
