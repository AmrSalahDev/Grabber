// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:flutter_native_splash/flutter_native_splash.dart';

// 🌎 Project imports:
import 'package:grabber/core/constants/app_colors.dart';
import 'package:grabber/core/routes/app_router.dart';
import 'package:grabber/core/services/di/di.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  setupDependencies();
  FlutterNativeSplash.remove();

  runApp(const GrabberApp());
}

class GrabberApp extends StatefulWidget {
  const GrabberApp({super.key});

  @override
  State<GrabberApp> createState() => _MyGrabberState();
}

class _MyGrabberState extends State<GrabberApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: AppColors.green,
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.white,
        bottomSheetTheme: BottomSheetThemeData(
          backgroundColor: AppColors.white,
          dragHandleColor: Colors.grey.shade300,
          dragHandleSize: Size(50, 5),
        ),
      ),
      routerConfig: AppRouter.router,
    );
  }
}
