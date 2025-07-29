// // import 'dart:ui';
// // import 'package:flutter/foundation.dart' show kIsWeb;
// // import 'package:flutter/material.dart';
// // import 'package:flutter_map/flutter_map.dart';
// // import 'package:latlong2/latlong.dart';
// // import 'package:geolocator/geolocator.dart';
// // import 'package:hive/hive.dart';
// // import 'package:rayride/offline_Booking_Screen.dart';
// // import 'package:uuid/uuid.dart';
// // import 'package:connectivity_plus/connectivity_plus.dart';
// // import 'dart:html' as html; // for web only
// // import 'shared_ride_dashboard_screen.dart';

// // class RideBookingScreen extends StatefulWidget {
// //   const RideBookingScreen({super.key});

// //   @override
// //   _RideBookingScreenState createState() => _RideBookingScreenState();
// // }

// // class _RideBookingScreenState extends State<RideBookingScreen> {
// //   final TextEditingController _dropController = TextEditingController();
// //   String _locationStatus = "Detecting current location...";
// //   Position? _currentPosition;

// //   @override
// //   void initState() {
// //     super.initState();
// //     _determinePosition();
// //   }

// //   Future<void> _determinePosition() async {
// //     bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
// //     if (!serviceEnabled) {
// //       setState(() {
// //         _locationStatus = 'Location services are disabled.';
// //       });
// //       return;
// //     }

// //     LocationPermission permission = await Geolocator.checkPermission();
// //     if (permission == LocationPermission.denied) {
// //       permission = await Geolocator.requestPermission();
// //       if (permission == LocationPermission.denied) {
// //         setState(() {
// //           _locationStatus = 'Location permissions are denied';
// //         });
// //         return;
// //       }
// //     }

// //     if (permission == LocationPermission.deniedForever) {
// //       setState(() {
// //         _locationStatus = 'Location permissions are permanently denied.';
// //       });
// //       return;
// //     }

// //     Position position = await Geolocator.getCurrentPosition(
// //       desiredAccuracy: LocationAccuracy.high,
// //     );

// //     setState(() {
// //       _currentPosition = position;
// //       _locationStatus =
// //           "Lat: ${position.latitude.toStringAsFixed(4)}, Lng: ${position.longitude.toStringAsFixed(4)}";
// //     });
// //   }

// //   /// ✅ Universal connectivity check: works for Web and Mobile
// //   Future<bool> _checkConnection() async {
// //     if (kIsWeb) {
// //       return html.window.navigator.onLine ?? false;
// //     } else {
// //       var result = await Connectivity().checkConnectivity();
// //       return result != ConnectivityResult.none;
// //     }
// //   }

// //   Future<bool> _handleBooking(String pickup, String drop, double fare) async {
// //     bool isOnline = await _checkConnection();
// //     final booking = {
// //       'id': Uuid().v4(),
// //       'pickup': pickup,
// //       'drop': drop,
// //       'fare': fare,
// //       'isSynced': isOnline,
// //     };

// //     if (isOnline) {
// //       await Future.delayed(Duration(seconds: 1));
// //       print("✅ Sent booking to server: $pickup → $drop");
// //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
// //         content: Text("Ride booked successfully (online)!"),
// //         backgroundColor: Colors.green,
// //       ));
// //       return true;
// //     } else {
// //       final box = await Hive.openBox('offline_bookings');
// //       await box.put(booking['id'], booking);
// //       print("💾 Saved booking offline: $pickup → $drop");
// //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
// //         content: Text("No internet! Ride saved offline."),
// //         backgroundColor: Colors.orange,
// //       ));
// //       return false;
// //     }
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     LatLng defaultCenter = LatLng(28.6139, 77.2090); // Delhi center

// //     return Scaffold(
// //       body: Stack(
// //         children: [
// //           FlutterMap(
// //             options: MapOptions(
// //               center: _currentPosition != null
// //                   ? LatLng(_currentPosition!.latitude, _currentPosition!.longitude)
// //                   : defaultCenter,
// //               zoom: 13.0,
// //             ),
// //             children: [
// //               TileLayer(
// //                 urlTemplate: 'https://{s}.basemaps.cartocdn.com/dark_all/{z}/{x}/{y}{r}.png',
// //                 subdomains: ['a', 'b', 'c'],
// //                 retinaMode: true,
// //               ),
// //               if (_currentPosition != null)
// //                 MarkerLayer(
// //                   markers: [
// //                     Marker(
// //                       point: LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
// //                       width: 30,
// //                       height: 30,
// //                       child: Container(
// //                         decoration: BoxDecoration(
// //                           shape: BoxShape.circle,
// //                           color: Colors.blueAccent,
// //                           border: Border.all(color: Colors.white, width: 3),
// //                         ),
// //                       ),
// //                     )
// //                   ],
// //                 )
// //             ],
// //           ),

// //           ElevatedButton(
// //   onPressed: () {
// //     Navigator.push(
// //       context,
// //       MaterialPageRoute(builder: (_) => OfflineBookingsScreen()),
// //     );
// //   },
// //   child: Text("📦 View Offline Bookings"),
// // ),

// //           /// 🔤 Top Input
// //           Positioned(
// //             top: 60,
// //             left: 20,
// //             right: 20,
// //             child: Column(
// //               crossAxisAlignment: CrossAxisAlignment.start,
// //               children: [
// //                 Text(
// //                   "Choose Your Location",
// //                   style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
// //                 ),
// //                 SizedBox(height: 8),
// //                 Text(
// //                   "Please enter your destination or location so we can help you easily!",
// //                   style: TextStyle(color: Colors.white70),
// //                 ),
// //                 SizedBox(height: 12),
// //                 TextField(
// //                   decoration: InputDecoration(
// //                     hintText: "Search here!",
// //                     filled: true,
// //                     fillColor: Colors.white,
// //                     prefixIcon: Icon(Icons.search),
// //                     border: OutlineInputBorder(
// //                       borderRadius: BorderRadius.circular(10),
// //                       borderSide: BorderSide.none,
// //                     ),
// //                   ),
// //                 ),
// //               ],
// //             ),
// //           ),

// //           /// 🔽 Bottom Card
// //           Positioned(
// //             bottom: 0,
// //             left: 0,
// //             right: 0,
// //             child: _glassContainer(
// //               child: Column(
// //                 mainAxisSize: MainAxisSize.min,
// //                 children: [
// //                   ListTile(
// //                     leading: Icon(Icons.my_location, color: Colors.orangeAccent),
// //                     title: Text("Where are you?"),
// //                     subtitle: Text(_locationStatus, style: TextStyle(color: Colors.white)),
// //                   ),
// //                   Divider(),
// //                   ListTile(
// //                     leading: Icon(Icons.location_on, color: Colors.white),
// //                     title: Text("Drop Location"),
// //                     subtitle: TextField(
// //                       controller: _dropController,
// //                       style: TextStyle(color: Colors.white),
// //                       decoration: InputDecoration(
// //                         hintText: "Where you want to go?",
// //                         hintStyle: TextStyle(color: Colors.white54),
// //                         border: InputBorder.none,
// //                       ),
// //                     ),
// //                   ),
// //                   SizedBox(height: 10),
// //                   ElevatedButton(
// //                     onPressed: () async {
// //                       if (_dropController.text.trim().isEmpty || _currentPosition == null) {
// //                         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
// //                           content: Text("Please enter a drop location and allow location access."),
// //                           backgroundColor: Colors.red,
// //                         ));
// //                         return;
// //                       }

// //                       final pickup = "Lat: ${_currentPosition!.latitude.toStringAsFixed(4)}, "
// //                           "Lng: ${_currentPosition!.longitude.toStringAsFixed(4)}";
// //                       final drop = _dropController.text.trim();
// //                       final fare = 120.0;

// //                       bool bookingSuccess = await _handleBooking(pickup, drop, fare);

// //                       if (bookingSuccess) {
// //                         Navigator.push(
// //                           context,
// //                           MaterialPageRoute(
// //                             builder: (context) => SharedRideDashboardScreen(
// //                               dropLocation: drop,
// //                               fare: "₹120",
// //                             ),
// //                           ),
// //                         );
// //                       }
// //                     },
// //                     style: ElevatedButton.styleFrom(
// //                       backgroundColor: Colors.orangeAccent,
// //                       shape: RoundedRectangleBorder(
// //                         borderRadius: BorderRadius.circular(20),
// //                       ),
// //                       padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
// //                     ),
// //                     child: Text("Book Ride in 5 mins"),
// //                   ),
// //                   SizedBox(height: 10),

// //                   /// ✅ Debug: Show offline bookings
// //                   FutureBuilder(
// //                     future: Hive.openBox('offline_bookings'),
// //                     builder: (context, snapshot) {
// //                       if (!snapshot.hasData) return Text("Loading...", style: TextStyle(color: Colors.white));
// //                       final box = snapshot.data!;
// //                       final values = box.values.toList();

// //                       return Column(
// //                         crossAxisAlignment: CrossAxisAlignment.start,
// //                         children: values.map((b) {
// //                           return Text(
// //                             "🟠 ${b['pickup']} → ${b['drop']} | ₹${b['fare']}",
// //                             style: TextStyle(color: Colors.white),
// //                           );
// //                         }).toList(),
// //                       );
// //                     },
// //                   ),
// //                   SizedBox(height: 10),
// //                 ],
// //               ),
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   Widget _glassContainer({required Widget child}) {
// //     return Container(
// //       margin: EdgeInsets.all(16),
// //       padding: EdgeInsets.all(16),
// //       decoration: BoxDecoration(
// //         color: Colors.white.withOpacity(0.15),
// //         borderRadius: BorderRadius.circular(20),
// //       ),
// //       child: ClipRRect(
// //         borderRadius: BorderRadius.circular(20),
// //         child: BackdropFilter(
// //           filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
// //           child: child,
// //         ),
// //       ),
// //     );
// //   }
// // }

// import 'dart:ui';
// import 'package:flutter/foundation.dart' show kIsWeb;
// import 'package:flutter/material.dart';
// import 'package:flutter_map/flutter_map.dart';
// import 'package:latlong2/latlong.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:hive/hive.dart';
// import 'package:rayride/offline_Booking_Screen.dart';
// import 'package:uuid/uuid.dart';
// import 'package:connectivity_plus/connectivity_plus.dart';
// //import 'dart:html' as html;
// import 'shared_ride_dashboard_screen.dart';
// import 'package:rayride/api_services.dart';

// class RideBookingScreen extends StatefulWidget {
//   const RideBookingScreen({super.key});

//   @override
//   _RideBookingScreenState createState() => _RideBookingScreenState();
// }

// class _RideBookingScreenState extends State<RideBookingScreen> {
//   final TextEditingController _dropController = TextEditingController();
//   String _locationStatus = "Detecting current location...";
//   Position? _currentPosition;

//   @override
//   void initState() {
//     super.initState();
//     _determinePosition();
//   }

//   Future<void> _determinePosition() async {
//     bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       setState(() => _locationStatus = 'Location services are disabled.');
//       return;
//     }

//     LocationPermission permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         setState(() => _locationStatus = 'Location permissions are denied');
//         return;
//       }
//     }

//     if (permission == LocationPermission.deniedForever) {
//       setState(() => _locationStatus = 'Location permissions are permanently denied.');
//       return;
//     }

//     Position position = await Geolocator.getCurrentPosition(
//       desiredAccuracy: LocationAccuracy.high,
//     );

//     setState(() {
//       _currentPosition = position;
//       _locationStatus =
//           "Lat: ${position.latitude.toStringAsFixed(4)}, Lng: ${position.longitude.toStringAsFixed(4)}";
//     });
//   }

//  Future<bool> _checkConnection() async {
//   var connectivityResult = await Connectivity().checkConnectivity();
//   return connectivityResult != ConnectivityResult.none;
// }

//   Future<bool> _handleBooking(String pickup, String drop, double fare) async {
//     bool isOnline = await _checkConnection();
//    print("📡 isOnline: $isOnline");
//     final booking = {
//       'id': Uuid().v4(),
//       'pickup': pickup,
//       'drop': drop,
//       'fare': fare,
//       'isSynced': isOnline,
//     };

//     if (isOnline) {
//       try {
//         final response = await ApiService.bookRide(
//           commuterId: "demoUser", // Replace later with real ID
//           pickup: pickup,
//           drop: drop,
//           fare: fare,
//         );

//         if (response.statusCode == 200) {
//           print("✅ Sent booking to server: $pickup → $drop");
//           ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//             content: Text("Ride booked successfully (online)!"),
//             backgroundColor: Colors.green,
//           ));
//           return true;
//         } else {
//           print("❌ Booking failed: ${response.body}");
//           throw Exception("Booking failed");
//         }
//       } catch (e) {
//         print("🔌 Error booking: $e");
//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//           content: Text("Server error, saving offline."),
//           backgroundColor: Colors.orange,
//         ));
//         final box = await Hive.openBox('offline_bookings');
//         await box.put(booking['id'], booking);
//         return false;
//       }
//     } else {
//       final box = await Hive.openBox('offline_bookings');
//       await box.put(booking['id'], booking);
//       print("💾 Saved booking offline: $pickup → $drop");
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         content: Text("No internet! Ride saved offline."),
//         backgroundColor: Colors.orange,
//       ));
//       return false;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     LatLng defaultCenter = LatLng(28.6139, 77.2090);

//     return Scaffold(
//       body: Stack(
//         children: [
//           FlutterMap(
//             options: MapOptions(
//               center: _currentPosition != null
//                   ? LatLng(_currentPosition!.latitude, _currentPosition!.longitude)
//                   : defaultCenter,
//               zoom: 13.0,
//             ),
//             children: [
//               TileLayer(
//                 urlTemplate: 'https://{s}.basemaps.cartocdn.com/dark_all/{z}/{x}/{y}{r}.png',
//                 subdomains: ['a', 'b', 'c'],
//                 retinaMode: true,
//               ),
//               if (_currentPosition != null)
//                 MarkerLayer(
//                   markers: [
//                     Marker(
//                       point: LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
//                       width: 30,
//                       height: 30,
//                       child: Container(
//                         decoration: BoxDecoration(
//                           shape: BoxShape.circle,
//                           color: Colors.blueAccent,
//                           border: Border.all(color: Colors.white, width: 3),
//                         ),
//                       ),
//                     )
//                   ],
//                 )
//             ],
//           ),

//           // Top Location Input
//           Positioned(
//             top: 60,
//             left: 20,
//             right: 20,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   "Choose Your Location",
//                   style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
//                 ),
//                 SizedBox(height: 8),
//                 Text(
//                   "Please enter your destination or location so we can help you easily!",
//                   style: TextStyle(color: Colors.white70),
//                 ),
//                 SizedBox(height: 12),
//                 TextField(
//                   decoration: InputDecoration(
//                     hintText: "Search here!",
//                     filled: true,
//                     fillColor: Colors.white,
//                     prefixIcon: Icon(Icons.search),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                       borderSide: BorderSide.none,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),

//           // Bottom Card with Location + Booking UI
//           Positioned(
//             bottom: 0,
//             left: 0,
//             right: 0,
//             child: _glassContainer(
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   ListTile(
//                     leading: Icon(Icons.my_location, color: Colors.orangeAccent),
//                     title: Text("Where are you?"),
//                     subtitle: Text(_locationStatus, style: TextStyle(color: Colors.white)),
//                   ),
//                   Divider(),
//                   ListTile(
//                     leading: Icon(Icons.location_on, color: Colors.white),
//                     title: Text("Drop Location"),
//                     subtitle: TextField(
//                       controller: _dropController,
//                       style: TextStyle(color: Colors.white),
//                       decoration: InputDecoration(
//                         hintText: "Where you want to go?",
//                         hintStyle: TextStyle(color: Colors.white54),
//                         border: InputBorder.none,
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 10),
//                   ElevatedButton(
//                     onPressed: () async {
//                       if (_dropController.text.trim().isEmpty || _currentPosition == null) {
//                         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//                           content: Text("Please enter a drop location and allow location access."),
//                           backgroundColor: Colors.red,
//                         ));
//                         return;
//                       }

//                       final pickup = "Lat: ${_currentPosition!.latitude.toStringAsFixed(4)}, "
//                           "Lng: ${_currentPosition!.longitude.toStringAsFixed(4)}";
//                       final drop = _dropController.text.trim();
//                       final fare = 120.0;

//                       bool bookingSuccess = await _handleBooking(pickup, drop, fare);

//                       if (bookingSuccess) {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => SharedRideDashboardScreen(
//                               dropLocation: drop,
//                               fare: "₹120",
//                             ),
//                           ),
//                         );
//                       }
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.orangeAccent,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(20),
//                       ),
//                       padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
//                     ),
//                     child: Text("Book Ride in 5 mins"),
//                   ),
//                   SizedBox(height: 10),
//                   ElevatedButton(
//                     onPressed: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (_) => OfflineBookingsScreen()),
//                       );
//                     },
//                     child: Text("📦 View Offline Bookings"),
//                   ),
//                   SizedBox(height: 10),
//                   FutureBuilder(
//                     future: Hive.openBox('offline_bookings'),
//                     builder: (context, snapshot) {
//                       if (!snapshot.hasData) return Text("Loading...", style: TextStyle(color: Colors.white));
//                       final box = snapshot.data!;
//                       final values = box.values.toList();

//                       return Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: values.map((b) {
//                           return Text(
//                             "🟠 ${b['pickup']} → ${b['drop']} | ₹${b['fare']}",
//                             style: TextStyle(color: Colors.white),
//                           );
//                         }).toList(),
//                       );
//                     },
//                   ),
//                   SizedBox(height: 10),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _glassContainer({required Widget child}) {
//     return Container(
//       margin: EdgeInsets.all(16),
//       padding: EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white.withOpacity(0.15),
//         borderRadius: BorderRadius.circular(20),
//       ),
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(20),
//         child: BackdropFilter(
//           filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
//           child: child,
//         ),
//       ),
//     );
//   }
// }/

import 'dart:ui';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hive/hive.dart';
import 'package:rayride/offline_Booking_Screen.dart';
import 'package:uuid/uuid.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:rayride/shared_ride_dashboard_screen.dart';
import 'package:rayride/api_services.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class RideBookingScreen extends StatefulWidget {
  const RideBookingScreen({super.key});

  @override
  _RideBookingScreenState createState() => _RideBookingScreenState();
}

class _RideBookingScreenState extends State<RideBookingScreen> {
  final TextEditingController _dropController = TextEditingController();
  final TextEditingController _fareController = TextEditingController();
  String _locationStatus = "Detecting current location...";
  Position? _currentPosition;

  @override
  void initState() {
    super.initState();
    _determinePosition();
  }

  Future<void> _determinePosition() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() => _locationStatus = 'Location services are disabled.');
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        setState(() => _locationStatus = 'Location permissions are denied');
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      setState(() => _locationStatus = 'Location permissions are permanently denied.');
      return;
    }

    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _currentPosition = position;
      _locationStatus = "Lat: ${position.latitude.toStringAsFixed(4)}, Lng: ${position.longitude.toStringAsFixed(4)}";
    });
  }

  Future<void> matchRide(BuildContext context, String riderId, double lat, double lng) async {
    final url = Uri.parse('http://10.0.2.2:3000/api/match/match-ride');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'riderId': riderId,
        'pickup': {'lat': lat, 'lng': lng},
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final driver = data['driver'];
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("✅ Matched with ${driver['name']} (${driver['distance']})"),
        backgroundColor: Colors.green,
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("❌ Failed: ${jsonDecode(response.body)['message']}"),
        backgroundColor: Colors.red,
      ));
    }
  }

  Future<bool> _checkConnection() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }

  Future<bool> _handleBooking(String pickup, String drop, double fare) async {
    bool isOnline = await _checkConnection();
    final userBox = await Hive.openBox('userBox');
    final commuterId = userBox.get('userId') ?? 'demoUser';
    final booking = {
      'id': Uuid().v4(),
      'pickup': pickup,
      'drop': drop,
      'fare': fare,
      'commuterId': commuterId,
      'isSynced': isOnline,
    };

    if (isOnline) {
      try {
        final response = await ApiService.bookRide(
          commuterId: commuterId,
          pickup: pickup,
          drop: drop,
          fare: fare,
        );

        if (response.statusCode == 200) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Ride booked successfully (online)!"),
            backgroundColor: Colors.green,
          ));
          return true;
        } else {
          final box = await Hive.openBox('offline_bookings');
          await box.put(booking['id'], booking);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Server error. Ride saved offline."),
            backgroundColor: Colors.orange,
          ));
          return false;
        }
      } catch (e) {
        final box = await Hive.openBox('offline_bookings');
        await box.put(booking['id'], booking);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Network/API error. Ride saved offline."),
          backgroundColor: Colors.orange,
        ));
        return false;
      }
    } else {
      final box = await Hive.openBox('offline_bookings');
      await box.put(booking['id'], booking);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("No internet! Ride saved offline."),
        backgroundColor: Colors.orange,
      ));
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    LatLng defaultCenter = LatLng(28.6139, 77.2090);

    return Scaffold(
      body: Stack(
        children: [
          FlutterMap(
            options: MapOptions(
              center: _currentPosition != null
                  ? LatLng(_currentPosition!.latitude, _currentPosition!.longitude)
                  : defaultCenter,
              zoom: 13.0,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://{s}.basemaps.cartocdn.com/dark_all/{z}/{x}/{y}{r}.png',
                subdomains: ['a', 'b', 'c'],
                retinaMode: true,
              ),
              if (_currentPosition != null)
                MarkerLayer(
                  markers: [
                    Marker(
                      point: LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
                      width: 30,
                      height: 30,
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.blueAccent,
                          border: Border.all(color: Colors.white, width: 3),
                        ),
                      ),
                    ),
                  ],
                ),
            ],
          ),
          Positioned(
            top: 60,
            left: 20,
            right: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Choose Your Location", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Text("Please enter your destination", style: TextStyle(color: Colors.white70)),
                SizedBox(height: 12),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: _glassContainer(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    leading: Icon(Icons.my_location, color: Colors.orangeAccent),
                    title: Text("Where are you?"),
                    subtitle: Text(_locationStatus, style: TextStyle(color: Colors.white)),
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.location_on, color: Colors.white),
                    title: Text("Drop Location"),
                    subtitle: TextField(
                      controller: _dropController,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: "Where you want to go?",
                        hintStyle: TextStyle(color: Colors.white54),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: TextField(
                      controller: _fareController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "Enter Fare (₹)",
                        labelStyle: TextStyle(color: Colors.white),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white54),
                        ),
                      ),
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () async {
                      if (_dropController.text.trim().isEmpty || _fareController.text.isEmpty || _currentPosition == null) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("Please enter details and allow location."),
                          backgroundColor: Colors.red,
                        ));
                        return;
                      }

                      final pickup =
                          "Lat: ${_currentPosition!.latitude.toStringAsFixed(4)}, Lng: ${_currentPosition!.longitude.toStringAsFixed(4)}";
                      final drop = _dropController.text.trim();
                      final fare = double.tryParse(_fareController.text) ?? 120.0;

                      bool bookingSuccess = await _handleBooking(pickup, drop, fare);

                      if (bookingSuccess) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SharedRideDashboardScreen(dropLocation: drop, fare: "₹$fare"),
                          ),
                        );
                      }
                    },
                    child: Text("Book Ride in 5 mins"),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => OfflineBookingsScreen()),
                          );
                        },
                        child: Text("📦 View Offline Bookings"),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          matchRide(context, "test-rider-id", 28.61, 77.23);
                        },
                        child: Text('Match Ride'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _glassContainer({required Widget child}) {
    return Container(
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: child,
        ),
      ),
    );
  }
}
