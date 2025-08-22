// 🎯 Dart imports:
import 'dart:convert';

// 📦 Package imports:
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';

// 🌎 Project imports:
import 'package:grabber/features/order_track/domain/repo/track_order_repo.dart';

class TrackOrderRepoImpl extends TrackOrderRepo {
  @override
  Future<List<LatLng>> fetchRoute(LatLng start, LatLng end) async {
    final url = Uri.parse(
      'https://router.project-osrm.org/route/v1/driving/'
      '${start.longitude},${start.latitude};'
      '${end.longitude},${end.latitude}'
      '?overview=full&geometries=geojson',
    );

    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final coords = data['routes'][0]['geometry']['coordinates'] as List;
      return coords.map((c) => LatLng(c[1], c[0])).toList();
    } else {
      throw Exception('OSRM error: ${response.body}');
    }
  }
}
