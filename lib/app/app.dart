import 'package:client/app/routes/app_router.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: DevicePreview.appBuilder,
      useInheritedMediaQuery: true,
      routes: AppRouter.routes,
      debugShowCheckedModeBanner: false,
      locale: DevicePreview.locale(context),
      initialRoute: AppRouter.initialRoute,
    );
  }
}
