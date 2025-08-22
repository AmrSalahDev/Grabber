// 📦 Package imports:
import 'package:latlong2/latlong.dart';

// 🌎 Project imports:
import 'package:grabber/features/order_track/domain/repo/track_order_repo.dart';

class FetchRouteUseCase {
  final TrackOrderRepo trackOrderRepo;

  FetchRouteUseCase(this.trackOrderRepo);

  Future<List<LatLng>> call(LatLng start, LatLng end) =>
      trackOrderRepo.fetchRoute(start, end);
}
