// import 'dart:convert';
// import 'package:http/http.dart' as http;

// class ApiService {
//   static const String baseUrl = 'http://localhost:3000'; // only domain + port

//   // change if needed

//   static Future<bool> acceptRide({
//     required String pickup,
//     required String drop,
//     required double fare,
//   }) async {
//     final url = Uri.parse('$baseUrl/accept-ride');
//     final body = {
//       'pickup': pickup,
//       'drop': drop,
//       'fare': fare.toString(),
//     };

//     try {
//       final response = await http.post(
//         url,
//         headers: {"Content-Type": "application/json"},
//         body: json.encode(body),
//       );

//       if (response.statusCode == 200) {
//         print("✅ Ride accepted successfully: ${response.body}");
//         return true;
//       } else {
//         print("❌ Failed with status ${response.statusCode}: ${response.body}");
//         return false;
//       }
//     } catch (e) {
//       print("❌ Error in acceptRide(): $e");
//       return false;
//     }
//   }

//   static Future<http.Response> bookRide({
//     required String commuterId,
//     required String pickup,
//     required String drop,
//     required double fare,
//   }) async {
//     final url = Uri.parse('$baseUrl/rides/book');
//     final response = await http.post(
//       url,
//       headers: {'Content-Type': 'application/json'},
//       body: jsonEncode({
//         'commuterId': commuterId,
//         'pickup': {'address': pickup},  // Modify if using lat/lng
//         'drop': {'address': drop},
//         'fare': fare,
//       }),
//     );
//     return response;
//   }
// }


import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'http://localhost:3000/api/rides'; // ✅ Base only

  static Future<http.Response> bookRide({
    required String commuterId,
    required String pickup,
    required String drop,
    required double fare,
  }) async {
    final url = Uri.parse('$baseUrl/book'); // ✅ Matches backend POST /book

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'commuterId': commuterId,
        'pickup': {'address': pickup},
        'drop': {'address': drop},
        'fare': fare,
      }),
    );

    return response;
  }

  static Future<bool> acceptRide({
    required String rideId,
    required String driverId,
  }) async {
    final url = Uri.parse('$baseUrl/accept');

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: json.encode({
        'rideId': rideId,
        'driverId': driverId,
      }),
    );

    return response.statusCode == 200;
  }

  static Future<bool> completeRide(String rideId) async {
    final url = Uri.parse('$baseUrl/complete');

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: json.encode({'rideId': rideId}),
    );

    return response.statusCode == 200;
  }

  static Future<List<dynamic>> getActiveRides() async {
    final url = Uri.parse('$baseUrl/active');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load active rides');
    }
  }

  static Future<List<dynamic>> getRidesByUser(String userId) async {
    final url = Uri.parse('$baseUrl/user/$userId');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to fetch rides');
    }
  }
}
