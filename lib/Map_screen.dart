// import 'package:flutter/material.dart';
// import 'package:flutter_map/flutter_map.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:latlong2/latlong.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class ChargingStation {
//   final String name;
//   final LatLng location;
//   final int availableSlots;

//   ChargingStation({
//     required this.name,
//     required this.location,
//     required this.availableSlots,
//   });
// }

// class Mapscreen extends StatefulWidget {
//   const Mapscreen({super.key});

//   @override
//   State<Mapscreen> createState() => _MapScreenState();
// }

// class _MapScreenState extends State<Mapscreen> {
//   final MapController _mapController = MapController();
//   final LatLng _defaultCenter = LatLng(28.7041, 77.1025);
//   final double _defaultZoom = 14.0;
//   LatLng? _driverLocation;
//   ChargingStation? selectedStation;
//   bool isDarkMode = false;

//   final List<ChargingStation> stations = [
//     ChargingStation(
//       name: 'EV Hub Sector 21',
//       location: LatLng(28.7041, 77.1025),
//       availableSlots: 3,
//     ),
//     ChargingStation(
//       name: 'ChargePoint Vasant Kunj',
//       location: LatLng(28.7055, 77.1080),
//       availableSlots: 2,
//     ),
//   ];

//   final LatLng highDemandCenter = LatLng(28.7043, 77.1033);
//   final double highDemandRadius = 100; // meters

//   @override
//   void initState() {
//     super.initState();
//     _loadTheme();
//     _getCurrentLocation();
//   }

//   void _loadTheme() async {
//     final prefs = await SharedPreferences.getInstance();
//     setState(() {
//       isDarkMode = prefs.getBool('darkMode') ?? false;
//     });
//   }

//   Future<void> _getCurrentLocation() async {
//     final position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
//     final newLocation = LatLng(position.latitude, position.longitude);
//     setState(() {
//       _driverLocation = newLocation;
//       selectedStation = null;
//     });
//     _mapController.move(newLocation, _defaultZoom);
//   }

//   double _calculateDistance(LatLng destination) {
//     if (_driverLocation == null) return 0.0;
//     final Distance distance = Distance();
//     return distance.as(LengthUnit.Kilometer, _driverLocation!, destination);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('RayRide Map'),
//         backgroundColor: isDarkMode ? Colors.black : Colors.white,
//         foregroundColor: isDarkMode ? Colors.white : Colors.black,
//         actions: [
//           IconButton(
//             icon: Icon(Icons.dark_mode),
//             onPressed: () async {
//               final prefs = await SharedPreferences.getInstance();
//               setState(() {
//                 isDarkMode = !isDarkMode;
//                 prefs.setBool('darkMode', isDarkMode);
//               });
//             },
//           ),
//         ],
//       ),
//       body: Stack(
//         children: [
//           FlutterMap(
//             mapController: _mapController,
//             options: MapOptions(
//               initialCenter: _driverLocation ?? _defaultCenter,
//               initialZoom: _defaultZoom,
//               interactionOptions: InteractionOptions(enableScrollWheel: true),
//             ),
//             children: [
//               TileLayer(
//                 urlTemplate: isDarkMode
//                     ? 'https://{s}.basemaps.cartocdn.com/dark_all/{z}/{x}/{y}{r}.png'
//                     : 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
//                 subdomains: const ['a', 'b', 'c'],
//               ),
//               MarkerLayer(
//                 markers: stations.map((station) {
//                   return Marker(
//                     point: station.location,
//                     width: 40,
//                     height: 40,
//                     child: GestureDetector(
//                       onTap: () {
//                         setState(() => selectedStation = station);
//                         if (_driverLocation != null) {
//                           LatLng center = LatLng(
//                             (_driverLocation!.latitude + station.location.latitude) / 2,
//                             (_driverLocation!.longitude + station.location.longitude) / 2,
//                           );
//                           _mapController.move(center, _defaultZoom);
//                         }
//                       },
//                       child: Icon(Icons.ev_station, color: Colors.green, size: 32),
//                     ),
//                   );
//                 }).toList(),
//               ),
//               if (_driverLocation != null)
//                 MarkerLayer(
//                   markers: [
//                     Marker(
//                       point: _driverLocation!,
//                       width: 40,
//                       height: 40,
//                       child: Icon(Icons.location_on, color: Colors.blueAccent, size: 36),
//                     ),
//                   ],
//                 ),
//               if (_driverLocation != null && selectedStation != null)
//                 PolylineLayer(
//                   key: ValueKey('${_driverLocation}_${selectedStation!.location}'),
//                   polylines: [
//                     Polyline(
//                       points: [_driverLocation!, selectedStation!.location],
//                       strokeWidth: 4.0,
//                       color: Colors.blueAccent,
//                     )
//                   ],
//                 ),
//               CircleLayer(
//                 circles: [
//                   CircleMarker(
//                     point: highDemandCenter,
//                     color: Colors.red.withOpacity(0.3),
//                     borderColor: Colors.red,
//                     borderStrokeWidth: 2,
//                     radius: highDemandRadius,
//                   ),
//                 ],
//               ),
//             ],
//           ),
//           Positioned(
//             right: 10,
//             bottom: 160,
//             child: Column(
//               children: [
//                 FloatingActionButton.small(
//                   heroTag: 'zoom_in',
//                   child: Icon(Icons.add),
//                   onPressed: () {
//                     _mapController.move(
//                       _mapController.camera.center,
//                       _mapController.camera.zoom + 1,
//                     );
//                   },
//                 ),
//                 SizedBox(height: 10),
//                 FloatingActionButton.small(
//                   heroTag: 'zoom_out',
//                   child: Icon(Icons.remove),
//                   onPressed: () {
//                     _mapController.move(
//                       _mapController.camera.center,
//                       _mapController.camera.zoom - 1,
//                     );
//                   },
//                 ),
//               ],
//             ),
//           ),
//           Positioned(
//             right: 10,
//             bottom: 90,
//             child: FloatingActionButton(
//               heroTag: 'locate',
//               onPressed: _getCurrentLocation,
//               child: Icon(Icons.my_location),
//             ),
//           ),
//           Positioned(
//             top: 90,
//             left: 15,
//             right: 15,
//             child: Card(
//               color: Colors.red[50],
//               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//               child: ListTile(
//                 leading: Icon(Icons.warning, color: Colors.red),
//                 title: Text('High Demand Zone Nearby'),
//                 subtitle: Text('Expect more ride requests in this area'),
//               ),
//             ),
//           ),
//           if (selectedStation != null)
//             Positioned(
//               bottom: 0,
//               left: 0,
//               right: 0,
//               child: Card(
//                 margin: EdgeInsets.all(12),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//                 ),
//                 elevation: 12,
//                 child: Padding(
//                   padding: const EdgeInsets.all(16),
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             selectedStation!.name,
//                             style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                           ),
//                           IconButton(
//                             icon: Icon(Icons.close),
//                             onPressed: () => setState(() => selectedStation = null),
//                           ),
//                         ],
//                       ),
//                       SizedBox(height: 8),
//                       Text(
//                         _driverLocation != null
//                             ? 'Distance: ${_calculateDistance(selectedStation!.location).toStringAsFixed(2)} km | Slots: ${selectedStation!.availableSlots}'
//                             : 'Available Slots: ${selectedStation!.availableSlots}',
//                       ),
//                       SizedBox(height: 12),
//                       ElevatedButton.icon(
//                         onPressed: () {},
//                         icon: Icon(Icons.navigation),
//                         label: Text('Navigate'),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }

// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:flutter_map/flutter_map.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:http/http.dart' as http;
// import 'package:latlong2/latlong.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class ChargingStation {
//   final String id;
//   final String name;
//   final LatLng location;

//   ChargingStation({required this.id, required this.name, required this.location});
// }

// class Mapscreen extends StatefulWidget {
//   const Mapscreen({super.key});

//   @override
//   State<Mapscreen> createState() => _MapScreenState();
// }

// class _MapScreenState extends State<Mapscreen> {
//   final MapController _mapController = MapController();
//   final LatLng _defaultCenter = LatLng(28.7041, 77.1025);
//   final double _defaultZoom = 14.0;
//   LatLng? _driverLocation;
//   ChargingStation? selectedStation;
//   bool isDarkMode = false;

//   List<ChargingStation> stations = [];
//   List<CircleMarker> heatmapCircles = [];

//   @override
//   void initState() {
//     super.initState();
//     _loadTheme();
//     _getCurrentLocation();
//     fetchChargingStations();
//     fetchHeatmapData();
//   }

//   void _loadTheme() async {
//     final prefs = await SharedPreferences.getInstance();
//     setState(() {
//       isDarkMode = prefs.getBool('darkMode') ?? false;
//     });
//   }

//   Future<void> _getCurrentLocation() async {
//     final position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
//     final newLocation = LatLng(position.latitude, position.longitude);
//     setState(() {
//       _driverLocation = newLocation;
//       selectedStation = null;
//     });
//     _mapController.move(newLocation, _defaultZoom);
//   }

//   Future<void> fetchChargingStations() async {
//     try {
//       final response = await http.get(Uri.parse('http://localhost:3000/api/maps/charging-stations'));
//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         stations = List<ChargingStation>.from(data.map((s) => ChargingStation(
//           id: s['id'],
//           name: s['name'],
//           location: LatLng(s['lat'], s['lng'])
//         )));
//         setState(() {});
//       }
//     } catch (e) {
//       print('❌ Failed to fetch stations: $e');
//     }
//   }

//   Future<void> fetchHeatmapData() async {
//     try {
//       final response = await http.get(Uri.parse('http://localhost:3000/api/maps/heatmap'));
//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         heatmapCircles = List<CircleMarker>.from(data.map((zone) {
//           Color fillColor;
//           if (zone['demand'] > 0.8) fillColor = Colors.red.withOpacity(0.3);
//           else if (zone['demand'] > 0.6) fillColor = Colors.orange.withOpacity(0.3);
//           else fillColor = Colors.yellow.withOpacity(0.3);

//           return CircleMarker(
//             point: LatLng(zone['lat'], zone['lng']),
//             radius: 100,
//             borderColor: fillColor.withOpacity(1.0),
//             borderStrokeWidth: 2,
//             color: fillColor,
//           );
//         }));
//         setState(() {});
//       }
//     } catch (e) {
//       print('❌ Failed to fetch heatmap: $e');
//     }
//   }

//   double _calculateDistance(LatLng destination) {
//     if (_driverLocation == null) return 0.0;
//     final Distance distance = Distance();
//     return distance.as(LengthUnit.Kilometer, _driverLocation!, destination);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('RayRide Map'),
//         backgroundColor: isDarkMode ? Colors.black : Colors.white,
//         foregroundColor: isDarkMode ? Colors.white : Colors.black,
//         actions: [
//           IconButton(
//             icon: Icon(Icons.dark_mode),
//             onPressed: () async {
//               final prefs = await SharedPreferences.getInstance();
//               setState(() {
//                 isDarkMode = !isDarkMode;
//                 prefs.setBool('darkMode', isDarkMode);
//               });
//             },
//           ),
//         ],
//       ),
//       body: Stack(
//         children: [
//           FlutterMap(
//             mapController: _mapController,
//             options: MapOptions(
//               initialCenter: _driverLocation ?? _defaultCenter,
//               initialZoom: _defaultZoom,
//               interactionOptions: InteractionOptions(enableScrollWheel: true),
//             ),
//             children: [
//               TileLayer(
//                 urlTemplate: isDarkMode
//                     ? 'https://{s}.basemaps.cartocdn.com/dark_all/{z}/{x}/{y}{r}.png'
//                     : 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
//                 subdomains: const ['a', 'b', 'c'],
//               ),
//               MarkerLayer(
//                 markers: stations.map((station) {
//                   return Marker(
//                     point: station.location,
//                     width: 40,
//                     height: 40,
//                     child: GestureDetector(
//                       onTap: () {
//                         setState(() => selectedStation = station);
//                         if (_driverLocation != null) {
//                           LatLng center = LatLng(
//                             (_driverLocation!.latitude + station.location.latitude) / 2,
//                             (_driverLocation!.longitude + station.location.longitude) / 2,
//                           );
//                           _mapController.move(center, _defaultZoom);
//                         }
//                       },
//                       child: Icon(Icons.ev_station, color: Colors.green, size: 32),
//                     ),
//                   );
//                 }).toList(),
//               ),
//               if (_driverLocation != null)
//                 MarkerLayer(
//                   markers: [
//                     Marker(
//                       point: _driverLocation!,
//                       width: 40,
//                       height: 40,
//                       child: Icon(Icons.location_on, color: Colors.blueAccent, size: 36),
//                     ),
//                   ],
//                 ),
//               if (_driverLocation != null && selectedStation != null)
//                 PolylineLayer(
//                   key: ValueKey('${_driverLocation}_${selectedStation!.location}'),
//                   polylines: [
//                     Polyline(
//                       points: [_driverLocation!, selectedStation!.location],
//                       strokeWidth: 4.0,
//                       color: Colors.blueAccent,
//                     )
//                   ],
//                 ),
//               CircleLayer(circles: heatmapCircles),
//             ],
//           ),
//           Positioned(
//             right: 10,
//             bottom: 160,
//             child: Column(
//               children: [
//                 FloatingActionButton.small(
//                   heroTag: 'zoom_in',
//                   child: Icon(Icons.add),
//                   onPressed: () {
//                     _mapController.move(
//                       _mapController.camera.center,
//                       _mapController.camera.zoom + 1,
//                     );
//                   },
//                 ),
//                 SizedBox(height: 10),
//                 FloatingActionButton.small(
//                   heroTag: 'zoom_out',
//                   child: Icon(Icons.remove),
//                   onPressed: () {
//                     _mapController.move(
//                       _mapController.camera.center,
//                       _mapController.camera.zoom - 1,
//                     );
//                   },
//                 ),
//               ],
//             ),
//           ),
//           Positioned(
//             right: 10,
//             bottom: 90,
//             child: FloatingActionButton(
//               heroTag: 'locate',
//               onPressed: _getCurrentLocation,
//               child: Icon(Icons.my_location),
//             ),
//           ),
//           if (selectedStation != null)
//             Positioned(
//               bottom: 0,
//               left: 0,
//               right: 0,
//               child: Card(
//                 margin: EdgeInsets.all(12),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//                 ),
//                 elevation: 12,
//                 child: Padding(
//                   padding: const EdgeInsets.all(16),
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             selectedStation!.name,
//                             style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                           ),
//                           IconButton(
//                             icon: Icon(Icons.close),
//                             onPressed: () => setState(() => selectedStation = null),
//                           ),
//                         ],
//                       ),
//                       SizedBox(height: 8),
//                       Text(
//                         _driverLocation != null
//                             ? 'Distance: ${_calculateDistance(selectedStation!.location).toStringAsFixed(2)} km'
//                             : '',
//                       ),
//                       SizedBox(height: 12),
//                       ElevatedButton.icon(
//                         onPressed: () {},
//                         icon: Icon(Icons.navigation),
//                         label: Text('Navigate'),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }

// Updated Mapscreen with OpenRouteService integration for shortest path
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import 'dart:math';
import 'package:shared_preferences/shared_preferences.dart';

class ChargingStation {
  final String id;
  final String name;
  final LatLng location;

  ChargingStation({required this.id, required this.name, required this.location});
}

class Mapscreen extends StatefulWidget {
  const Mapscreen({super.key});

  @override
  State<Mapscreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<Mapscreen> {
  final MapController _mapController = MapController();
  final LatLng _defaultCenter = LatLng(28.7041, 77.1025);
  final double _defaultZoom = 14.0;
  LatLng? _driverLocation;
  ChargingStation? selectedStation;
  bool isDarkMode = false;

  List<ChargingStation> stations = [];
  List<CircleMarker> heatmapCircles = [];
  List<LatLng> _routePoints = [];

  @override
  void initState() {
    super.initState();
    _loadTheme();
    _getCurrentLocation();
    fetchChargingStations();
    fetchHeatmapData();
  }

  void _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isDarkMode = prefs.getBool('darkMode') ?? false;
    });
  }

Future<void> _getCurrentLocation() async {
  try {
    final position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    final newLocation = LatLng(position.latitude, position.longitude);
    print('📍 Got location: $newLocation');

    setState(() {
      _driverLocation = newLocation;
      selectedStation = null;
    });
    _mapController.move(newLocation, _defaultZoom);
  } catch (e) {
    print('❌ Location error: $e');
  }
}


  Future<void> fetchChargingStations() async {
    try {
      final response = await http.get(Uri.parse('http://localhost:3000/api/maps/charging-stations'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        stations = List<ChargingStation>.from(data.map((s) => ChargingStation(
          id: s['id'],
          name: s['name'],
          location: LatLng(s['lat'], s['lng'])
        )));
        setState(() {});
      }
    } catch (e) {
      print('❌ Failed to fetch stations: $e');
    }
  }

  Future<void> fetchHeatmapData() async {
    try {
      final response = await http.get(Uri.parse('http://localhost:3000/api/maps/heatmap'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        heatmapCircles = List<CircleMarker>.from(data.map((zone) {
          Color fillColor;
          if (zone['demand'] > 0.8) fillColor = Colors.red.withOpacity(0.3);
          else if (zone['demand'] > 0.6) fillColor = Colors.orange.withOpacity(0.3);
          else fillColor = Colors.yellow.withOpacity(0.3);

          return CircleMarker(
            point: LatLng(zone['lat'], zone['lng']),
            radius: 100,
            borderColor: fillColor.withOpacity(1.0),
            borderStrokeWidth: 2,
            color: fillColor,
          );
        }));
        setState(() {});
      }
    } catch (e) {
      print('❌ Failed to fetch heatmap: $e');
    }
  }

  Future<void> fetchRouteToStation(LatLng destination) async {
    if (_driverLocation == null) return;
    final apiKey = 'ey***YmMx***0='; // Use your full key
    final url = Uri.parse(
        'https://api.openrouteservice.org/v2/directions/driving-car?api_key=$apiKey&start=${_driverLocation!.longitude},${_driverLocation!.latitude}&end=${destination.longitude},${destination.latitude}');

    try {
      final response = await http.get(url);
      print('🌐 Response status: ${response.statusCode}');
      print('🌐 Response body: ${response.body.substring(0, min(500, response.body.length))}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final coords = data['features'][0]['geometry']['coordinates'] as List;

        final List<LatLng> points = coords.map((c) => LatLng(c[1], c[0])).toList();

        print('📍 Route Points Count: ${points.length}');
        if (points.isNotEmpty) {
          print('📍 First Point: ${points.first}');
        }

        setState(() {
          _routePoints = points;
        });

        _mapController.fitCamera(CameraFit.bounds(
          bounds: LatLngBounds.fromPoints(points),
        ));
      } else {
        print('❌ Route API failed');
      }
    } catch (e) {
      print('❌ Route error: $e');
    }
  }

  double _calculateDistance(LatLng destination) {
    if (_driverLocation == null) return 0.0;
    final Distance distance = Distance();
    return distance.as(LengthUnit.Kilometer, _driverLocation!, destination);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('RayRide Map'),
        backgroundColor: isDarkMode ? Colors.black : Colors.white,
        foregroundColor: isDarkMode ? Colors.white : Colors.black,
        actions: [
          IconButton(
            icon: Icon(Icons.dark_mode),
            onPressed: () async {
              final prefs = await SharedPreferences.getInstance();
              setState(() {
                isDarkMode = !isDarkMode;
                prefs.setBool('darkMode', isDarkMode);
              });
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: _driverLocation ?? _defaultCenter,
              initialZoom: _defaultZoom,
              interactionOptions: InteractionOptions(enableScrollWheel: true),
            ),
            children: [
              TileLayer(
                urlTemplate: isDarkMode
                    ? 'https://{s}.basemaps.cartocdn.com/dark_all/{z}/{x}/{y}{r}.png'
                    : 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                subdomains: const ['a', 'b', 'c'],
              ),
              MarkerLayer(
                markers: stations.map((station) {
                  return Marker(
                    point: station.location,
                    width: 40,
                    height: 40,
                    child: GestureDetector(
                      onTap: () {
                        setState(() => selectedStation = station);
                        fetchRouteToStation(station.location);
                      },
                      child: Icon(Icons.ev_station, color: Colors.green, size: 32),
                    ),
                  );
                }).toList(),
              ),
              if (_driverLocation != null)
                MarkerLayer(
                  markers: [
                    Marker(
                      point: _driverLocation!,
                      width: 40,
                      height: 40,
                      child: Icon(Icons.location_on, color: Colors.blueAccent, size: 36),
                    ),
                  ],
                ),
              if (_routePoints.isNotEmpty)
                PolylineLayer(
                  polylines: [
                    Polyline(
                      points: _routePoints,
                      strokeWidth: 5,
                      color: Colors.purple,
                    )
                  ],
                ),
              CircleLayer(circles: heatmapCircles),
            ],
          ),
          Positioned(
            right: 10,
            bottom: 160,
            child: Column(
              children: [
                FloatingActionButton.small(
                  heroTag: 'zoom_in',
                  child: Icon(Icons.add),
                  onPressed: () {
                    _mapController.move(
                      _mapController.camera.center,
                      _mapController.camera.zoom + 1,
                    );
                  },
                ),
                SizedBox(height: 10),
                FloatingActionButton.small(
                  heroTag: 'zoom_out',
                  child: Icon(Icons.remove),
                  onPressed: () {
                    _mapController.move(
                      _mapController.camera.center,
                      _mapController.camera.zoom - 1,
                    );
                  },
                ),
              ],
            ),
          ),
          Positioned(
            right: 10,
            bottom: 90,
            child: FloatingActionButton(
              heroTag: 'locate',
              onPressed: _getCurrentLocation,
              child: Icon(Icons.my_location),
            ),
          ),
          if (selectedStation != null)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Card(
                margin: EdgeInsets.all(12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                elevation: 12,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            selectedStation!.name,
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          IconButton(
                            icon: Icon(Icons.close),
                            onPressed: () => setState(() => selectedStation = null),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Text(
                        _driverLocation != null
                            ? 'Distance: ${_calculateDistance(selectedStation!.location).toStringAsFixed(2)} km'
                            : '',
                      ),
                      SizedBox(height: 12),
                      ElevatedButton.icon(
                        onPressed: () {},
                        icon: Icon(Icons.navigation),
                        label: Text('Navigate'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
