import 'package:go_router/go_router.dart';
import 'package:go_transitions/go_transitions.dart';
import 'package:grabber/features/home/ui/screens/home_screen.dart';

class AppPaths {
  static const home = '/home';
}

class AppRouter {
  static final router = GoRouter(
    initialLocation: AppPaths.home,
    routes: [
      GoRoute(
        path: AppPaths.home,
        builder: (context, state) => HomeScreen(),
        pageBuilder: GoTransitions.fadeUpwards.call,
      ),
    ],
  );
}
