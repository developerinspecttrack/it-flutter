import 'dart:convert';
import 'dart:io';
import 'package:client/core/constants/api_constants.dart';
import 'package:client/core/services/user/storage.dart';
import 'package:client/features/auth/models/auth.model.dart';
import 'package:client/features/auth/models/login.model.dart';
import 'package:client/features/auth/models/userprofile.model.dart';
import 'package:client/features/auth/models/userroleresponse.model.dart';
import 'package:http/http.dart' as http;

class HttpStatusCode {
  static const int ok = 200;
  static const int badRequest = 400;
  static const int unauthorized = 401;
  static const int forbidden = 403;
  static const int notFound = 404;
  static const int internalServerError = 500;
}

enum ApiExceptionType {
  offline,
  badRequest,
  unauthorized,
  forbidden,
  notFound,
  serverError,
  unknown
}

class ApiException implements Exception {
  final String message;
  final ApiExceptionType type;
  ApiException(this.type, this.message);
}

class ApiServices {
  static String baseUrl = ApiEndpoints.baseUrl;

  Future<OtpResponse> sendotp(String email) async {
    try {
      print("called sendotp with email to ${ApiEndpoints.login} ");
      final response = await http.post(
        Uri.parse(ApiEndpoints.login),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"email": email}),
      );
      print("response: $response");

      if (response.statusCode == 201 || response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);

        if (responseData.containsKey("otpId")) {
          String otpId = await responseData["otpId"];
          print("otpid $otpId");

          UserService.setOtpId(otpId);
        }

        return OtpResponse.fromJson(responseData);
      } else {
        print('error sending otp: ${response.statusCode} - ${response.body}")');
        throw ApiException(ApiExceptionType.serverError,
            "Server error: ${response.statusCode} - ${response.body}");
      }
    } on SocketException {
      throw ApiException(ApiExceptionType.offline, "You are offline");
    } catch (e) {
      throw ApiException(ApiExceptionType.unknown, "An error occurred: $e");
    }
  }

  Future<LoginResponse> verifyOtp(String otp, double lat, double long) async {
    try {
      String otpId = (await UserService.getOtpId()) ?? '';
      print('otp id $otpId');
      print(
        "verify otp send to ${ApiEndpoints.loginComplete}",
      );

      print("otpId send to servr $otpId");

      final response = await http.post(
        Uri.parse(ApiEndpoints.loginComplete),
        headers: {"Content-Type": "application/json"},
        body:
            jsonEncode({"otpId": otpId, "otp": otp, "lat": lat, "long": long}),
      );
      print("Login response ${response.body}");

      final Map<String, dynamic> responseData = jsonDecode(response.body);

      if (responseData.containsKey("accessToken") &&
          responseData.containsKey("refreshToken") &&
          responseData.containsKey("userAddress") &&
          responseData.containsKey("isProfileUpdated")) {
        String accessToken = responseData["accessToken"];
        String refreshToken = responseData["refreshToken"];
        String userAddress = responseData["userAddress"];
        bool isProfileUpdated = responseData["isProfileUpdated"];

        await UserService.setUserAccessToken(accessToken);
        await UserService.setUserRefreshToken(refreshToken);
        await UserService.setUserAddress(userAddress);
        await UserService.setProfileStatus(isProfileUpdated);
        print('response data $responseData');

        return LoginResponse.fromJson(responseData);
      } else {
        throw ApiException(ApiExceptionType.serverError,
            "Server error: ${response.statusCode} - ${response.body}");
      }
    } on SocketException {
      throw ApiException(ApiExceptionType.offline, "You are offline");
    } catch (e) {
      print('error while verifying otp');
      throw ApiException(ApiExceptionType.unknown, "An error occurred: $e");
    }
  }

  Future<UserProfile> getUserProfile() async {
    final accessToken = await UserService.getUserAccessToken();
    if (accessToken == null) {
      print("Cannot make API call: Access token is null");
      throw Exception("Authentication required");
    }
    print('api call triggered with access token: $accessToken');
    final response = await http.get(
      Uri.parse(ApiEndpoints.profile),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken'
      },
    );

    print('response: ${response.body}');

    if (response.statusCode == 200 || response.statusCode == 201) {
      final jsonResponse = json.decode(response.body);
      return UserProfile.fromJson(jsonResponse);
    } else {
      throw Exception('Failed to get User Profile');
    }
  }

  Future<UserRoleResponse> setUserRole(String userType) async {
    final body = jsonEncode({
      'userType': userType,
    });
    final accessToken = await UserService.getUserAccessToken();
    if (accessToken == null) {
      print("Cannot make API call: Access token is null");
      throw Exception("Authentication required");
    }

    final response = await http.put(Uri.parse(ApiEndpoints.userRole),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken'
        },
        body: body);

    print('response: ${response.body}');

    if (response.statusCode == 200 || response.statusCode == 201) {
      final jsonResponse = json.decode(response.body);
      return UserRoleResponse.fromJson(jsonResponse);
    } else {
      throw Exception('Failed to get User Profile');
    }
  }

  Future<UserRoleResponse> setUserProfile(
      {required String name,
      required String contactNumner,
      required String department,
      required String state}) async {
    final body = jsonEncode({
      'name': name,
      'contactNumber': contactNumner,
      'department': department,
      'state': state,
    });
    final accessToken = await UserService.getUserAccessToken();
    if (accessToken == null) {
      print("Cannot make API call: Access token is null");
      throw Exception("Authentication required");
    }

    final response = await http.post(Uri.parse(ApiEndpoints.userProfile),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken'
        },
        body: body);

    print('response: ${response.body}');

    if (response.statusCode == 200 || response.statusCode == 201) {
      final jsonResponse = json.decode(response.body);
      return UserRoleResponse.fromJson(jsonResponse);
    } else {
      throw Exception('Failed to get User Profile');
    }
  }
}
