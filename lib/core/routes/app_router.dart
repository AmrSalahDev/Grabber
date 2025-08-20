import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:go_transitions/go_transitions.dart';
import 'package:grabber/features/cart/ui/screens/cart_screen.dart';
import 'package:grabber/features/checkout/ui/screens/checkout_screen.dart';
import 'package:grabber/features/home/ui/cubit/basket_cubit.dart';
import 'package:grabber/features/home/ui/screens/home_screen.dart';

class AppPaths {
  static const home = '/home';
  static const cart = '/cart';
  static const checkout = '/checkout';
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
        pageBuilder: GoTransitions.slide.toRight.withFade.call,
      ),
      GoRoute(
        path: AppPaths.cart,
        builder: (context, state) {
          final basketCubit = state.extra as BasketCubit;
          return BlocProvider.value(
            value: basketCubit,
            child: const CartScreen(),
          );
        },
        pageBuilder: GoTransitions.fadeUpwards.call,
      ),
      GoRoute(
        path: AppPaths.checkout,
        builder: (context, state) => const CheckOutScreen(),
        pageBuilder: GoTransitions.fadeUpwards.call,
      ),
    ],
  );
}
