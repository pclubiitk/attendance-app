import 'package:hive_flutter/hive_flutter.dart';

class Storage {
  static Future<void> initialize() async {
    await Hive.initFlutter();
    await Hive.openBox('localStorage');
  }
}
