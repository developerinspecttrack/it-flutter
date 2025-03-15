import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecuredStorage {
  static FlutterSecureStorage storage = const FlutterSecureStorage();

  static Future<String?> readValue(String key) {
    return storage.read(key: key);
  }

  static Future<void> writeValue(String key, String value) {
    return storage.write(key: key, value: value);
  }

  static Future<void> deleteValue(String key) {
    return storage.delete(key: key);
  }
}
