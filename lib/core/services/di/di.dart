// 📦 Package imports:
import 'package:get_it/get_it.dart';

// 🌎 Project imports:
import 'package:grabber/features/order_track/data/repo/track_order_repo_impl.dart';
import 'package:grabber/features/order_track/domain/repo/track_order_repo.dart';
import 'package:grabber/features/order_track/domain/usecases/fetch_route_usecase.dart';
import 'package:grabber/features/order_track/ui/screens/cubit/track_order_cubit.dart';

final getIt = GetIt.instance;

void setupDependencies() {
  // services

  // repositories
  getIt.registerLazySingleton<TrackOrderRepo>(() => TrackOrderRepoImpl());

  // use cases
  getIt.registerLazySingleton<FetchRouteUseCase>(
    () => FetchRouteUseCase(getIt()),
  );

  // cubits
  getIt.registerFactory<TrackOrderCubit>(() => TrackOrderCubit(getIt()));
}
