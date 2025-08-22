// 📦 Package imports:
import 'package:latlong2/latlong.dart';

abstract class TrackOrderRepo {
  Future<List<LatLng>> fetchRoute(LatLng start, LatLng end);
}
