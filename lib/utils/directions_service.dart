import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';

class DirectionsService {
  static const String _baseUrl =
      'https://api.openrouteservice.org/v2/directions/driving-car';
  static const String _apiKey = 'ey***YmMx***0='; // Replace with your key

  static Future<List<LatLng>> getRoute({
    required LatLng start,
    required LatLng end,
  }) async {
    final url = Uri.parse(
      '$_baseUrl?api_key=$_apiKey&start=${start.longitude},${start.latitude}&end=${end.longitude},${end.latitude}',
    );

    final response = await http.get(url);
    if (response.statusCode == 200) {
      final decoded = json.decode(response.body);
      final List<dynamic> coordinates =
          decoded['features'][0]['geometry']['coordinates'];

      return coordinates.map((coord) {
        final lon = coord[0] as double;
        final lat = coord[1] as double;
        return LatLng(lat, lon);
      }).toList();
    } else {
      throw Exception('Failed to fetch route: ${response.body}');
    }
  }
}
