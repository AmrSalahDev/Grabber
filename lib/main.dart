import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:grabber/core/routes/app_router.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  Future.delayed(
    const Duration(seconds: 3),
    () => FlutterNativeSplash.remove(),
  );

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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.white,
      ),
      routerConfig: AppRouter.router,
    );
  }
}
