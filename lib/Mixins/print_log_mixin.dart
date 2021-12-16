import 'package:techblog/Services/index.dart';
import 'package:device_info/device_info.dart';

mixin PrintLogMixin {
  final LogService _logService = LogService();
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

  void printLog(dynamic message, [level]) async {
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    if (message != null) {
      _logService.addLog(message.toString(), level, androidInfo);
    }
  }
}
