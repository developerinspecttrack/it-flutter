import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiEndpoints {
  static final String baseUrl = dotenv.env['BACKEND_URL'] ?? '';
  static final String auth = "$baseUrl/api/auth";
  static final String login = "$auth/login";
  static final String loginComplete = "$login/verify";
  static final String user = "$baseUrl/api/user";
  static final String profile = "$user/profile";
  static final String userProfile = "$user/profile/update";
  static final String userRole = "$user/userRole";
}
