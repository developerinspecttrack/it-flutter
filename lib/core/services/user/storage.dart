import 'package:client/core/utils/secured_storage.dart';

class UserService {
  static Future<void> setOtpId(String otpId) async {
    await SecuredStorage.writeValue("otpId", otpId);
  }

  static Future<String?> getOtpId() async {
    return await SecuredStorage.readValue("otpId");
  }

  static Future<void> setUserAccessToken(String userToken) async {
    return await SecuredStorage.writeValue("accessToken", userToken);
  }

  static Future<String?> getUserAccessToken() async {
    return await SecuredStorage.readValue("accessToken");
  }

  static Future<void> setUserRefreshToken(String userToken) async {
    return await SecuredStorage.writeValue("refreshToken", userToken);
  }

  static Future<String?> getUserRefreshToken() async {
    return await SecuredStorage.readValue("refreshToken");
  }

  static Future<void> logOutUser() async {
    await SecuredStorage.deleteValue("accessToken");
    await SecuredStorage.deleteValue("refreshToken");
    await SecuredStorage.deleteValue("otpId");
  }

  static Future<bool> isUserLoggedIn() async {
    print('Checking if user is logged in...');
    final accessToken = await getUserAccessToken();
    print('Access token value: "$accessToken"');
    final isLoggedIn = accessToken != null;
    print('Is user logged in? $isLoggedIn');
    return isLoggedIn;
  }
}
