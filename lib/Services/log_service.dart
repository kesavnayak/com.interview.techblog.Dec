import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info/device_info.dart';
import 'package:intl/intl.dart';
import 'package:techblog/Enum/index.dart';
import 'package:techblog/Models/index.dart';

class LogService {
  void addLog(dynamic message, LogState level, AndroidDeviceInfo androidInfo) {
    LogModel logModel = LogModel(
      level: level.toString(),
      message: message,
      property: {
        'Device': androidInfo.device,
        "AndroidId": androidInfo.androidId
      },
    );
    final df1 = DateFormat("dd-MM-yyyy-hh-mm-ss");

    final CollectionReference collection =
        FirebaseFirestore.instance.collection("Logs");

    collection.doc(df1.format(DateTime.now())).set(logModel.toJson());
  }
}
