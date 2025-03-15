import 'package:client/core/utils/secured_storage.dart';

class UserService {
  static Future<void> setOtpId(String otpId) async {
    await SecuredStorage.writeValue("otpId", otpId);
  }

  static Future<String?> getOtpId() async {
    return await SecuredStorage.readValue("otpId");
  }

  static Future<void> setUserToken(String userToken) async {
    await SecuredStorage.writeValue("userToken", userToken);
  }

  static Future<String?> getUserToken() async {
    return await SecuredStorage.readValue("userToken");
  }

  static Future<void> logOutUser() async {
    await SecuredStorage.deleteValue("userToken");
  }
}
