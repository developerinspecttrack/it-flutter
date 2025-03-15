import 'package:client/app/app.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:client/core/services/fquery_service.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:fquery/fquery.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await dotenv.load(fileName: ".env");
  } catch (e) {
    debugPrint("Failed to load .env file: $e");
  }
  runApp(QueryClientProvider(
    queryClient: FQueryService.client,
    child: DevicePreview(
      enabled: false,
      builder: (context) => const App(),
    ),
  ));
}
