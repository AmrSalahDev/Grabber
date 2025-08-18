import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:go_transitions/go_transitions.dart';
import 'package:grabber/features/home/ui/cubit/basket_cubit.dart';
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
        builder: (context, state) => BlocProvider(
          create: (context) => BasketCubit(),
          child: HomeScreen(),
        ),
        pageBuilder: GoTransitions.fadeUpwards.call,
      ),
    ],
  );
}
