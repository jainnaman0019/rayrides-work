import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class LiveRideTrackingScreen extends StatefulWidget {
  const LiveRideTrackingScreen({super.key});

  @override
  _LiveRideTrackingScreenState createState() => _LiveRideTrackingScreenState();
}

class _LiveRideTrackingScreenState extends State<LiveRideTrackingScreen> with SingleTickerProviderStateMixin {
  final PanelController _panelController = PanelController();
  late AnimationController _carController;

  final LatLng pickupLocation = LatLng(28.7050, 77.1000);
  final LatLng dropLocation = LatLng(28.7060, 77.1080);
  LatLng driverLocation = LatLng(28.7041, 77.1025);
  List<LatLng> routePoints = [];

  final int _currentRouteIndex = 0;
  double _carBearing = 0;
  final double _carSize = 40;

  Timer? _etaTimer;
  int _etaSeconds = 240;
  double _distance = 2.8;

  @override
  void initState() {
    super.initState();

    routePoints = _createCurvedRoute(
      start: driverLocation,
      waypoints: [
        LatLng(28.7043, 77.1010),
        LatLng(28.7046, 77.1005),
        pickupLocation,
        LatLng(28.7053, 77.1015),
        LatLng(28.7057, 77.1040),
      ],
      end: dropLocation,
    );

    _carController = AnimationController(vsync: this, duration: Duration(seconds: 25))
      ..addListener(_updateCarPosition)
      ..forward();

    _startEtaTimer();
  }

  List<LatLng> _createCurvedRoute({
    required LatLng start,
    required List<LatLng> waypoints,
    required LatLng end,
  }) {
    final points = [start, ...waypoints, end];
    final curved = <LatLng>[];
    for (int i = 0; i < points.length - 1; i++) {
      final p1 = points[i];
      final p2 = points[i + 1];
      curved.add(p1);
      curved.add(LatLng(
        (p1.latitude + p2.latitude) / 2 + 0.0001,
        (p1.longitude + p2.longitude) / 2 + 0.0001,
      ));
    }
    curved.add(end);
    return curved;
  }

  void _startEtaTimer() {
    _etaTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_etaSeconds > 0) {
        setState(() => _etaSeconds--);
      } else {
        timer.cancel();
      }
    });
  }

  void _updateCarPosition() {
    final progress = _carController.value;
    final double routeLength = routePoints.length.toDouble();
    final double position = progress * (routeLength - 1);
    final int index = position.floor();
    final double ratio = position - index;

    if (index < routePoints.length - 1) {
      final start = routePoints[index];
      final end = routePoints[index + 1];
      setState(() {
        driverLocation = LatLng(
          start.latitude + ratio * (end.latitude - start.latitude),
          start.longitude + ratio * (end.longitude - start.longitude),
        );
        _carBearing = _calculateBearing(start, end);
        _distance = Distance().as(LengthUnit.Kilometer, driverLocation, dropLocation);
      });
    }
  }

  double _calculateBearing(LatLng start, LatLng end) {
    final dLon = (end.longitude - start.longitude) * pi / 180;
    final lat1 = start.latitude * pi / 180;
    final lat2 = end.latitude * pi / 180;
    final y = sin(dLon) * cos(lat2);
    final x = cos(lat1) * sin(lat2) - sin(lat1) * cos(lat2) * cos(dLon);
    return (atan2(y, x) + pi);
  }

  String _formatEta() {
    final min = _etaSeconds ~/ 60;
    final sec = _etaSeconds % 60;
    return "$min min ${sec.toString().padLeft(2, '0')}s";
  }

  void showMissedPickupDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: Colors.black87,
        title: Text("Missed Pickup", style: TextStyle(color: Colors.white)),
        content: Text("Driver missed your pickup. Suggest nearby spot?", style: TextStyle(color: Colors.white70)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Dismiss", style: TextStyle(color: Colors.orange)),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Suggesting new pickup..."), backgroundColor: Colors.green),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
            child: Text("Suggest New", style: TextStyle(color: Colors.black)),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomSheet() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(child: Container(width: 50, height: 4, color: Colors.grey[600])),
          SizedBox(height: 16),
          Row(
            children: [
              CircleAvatar(
                radius: 28,
                backgroundColor: Colors.blueGrey,
                child: Icon(Icons.person, color: Colors.white),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text("Raj (Swift Dzire)", style: TextStyle(color: Colors.white, fontSize: 18)),
                  Row(children: [
                    Icon(Icons.star, size: 16, color: Colors.amber),
                    Text(" 4.9  • 128 rides", style: TextStyle(color: Colors.amber))
                  ])
                ]),
              ),
              IconButton(
                icon: Icon(Icons.call, color: Colors.green),
                onPressed: () => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Calling Driver"))),
              ),
            ],
          ),
          SizedBox(height: 16),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text("ETA", style: TextStyle(color: Colors.grey)),
              Text(_formatEta(), style: TextStyle(color: Colors.white, fontSize: 20)),
            ]),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text("Distance", style: TextStyle(color: Colors.grey)),
              Text("${_distance.toStringAsFixed(1)} km", style: TextStyle(color: Colors.white, fontSize: 20)),
            ]),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(color: Colors.green.withOpacity(0.3), borderRadius: BorderRadius.circular(12)),
              child: Text("On time", style: TextStyle(color: Colors.greenAccent)),
            )
          ]),
          SizedBox(height: 16),
          Row(children: [
            Icon(Icons.location_on, color: Colors.green),
            SizedBox(width: 8),
            Text("Pickup: Hostel Block A", style: TextStyle(color: Colors.white)),
          ]),
          Row(children: [
            Icon(Icons.flag_outlined, color: Colors.redAccent),
            SizedBox(width: 8),
            Text("Drop: DTU Gate 1", style: TextStyle(color: Colors.white)),
          ]),
          SizedBox(height: 16),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton.icon(
              onPressed: showMissedPickupDialog,
              icon: Icon(Icons.route, color: Colors.white),
              label: Text("Reroute", style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _carController.dispose();
    _etaTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(children: [
        FlutterMap(
          options: MapOptions(center: driverLocation, zoom: 15),
          children: [
            TileLayer(
              urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
              subdomains: ['a', 'b', 'c'],
              backgroundColor: Colors.black,
            ),
            PolylineLayer(
              polylines: [
                Polyline(
                  points: routePoints,
                  strokeWidth: 6,
                  color: Colors.blueAccent,
                )
              ],
            ),
            MarkerLayer(
              markers: [
                Marker(
                  point: pickupLocation,
                  child: Icon(Icons.my_location, color: Colors.greenAccent, size: 30),
                ),
                Marker(
                  point: dropLocation,
                  child: Icon(Icons.flag_circle_outlined, color: Colors.redAccent, size: 30),
                ),
                Marker(
                  point: driverLocation,
                  width: _carSize,
                  height: _carSize,
                  child: Transform.rotate(
                    angle: _carBearing,
                    child:  Icon(Icons.directions_car_filled, size: 40, color: Colors.blue)
,
                  ),
                )
              ],
            )
          ],
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: SlidingUpPanel(
            controller: _panelController,
            minHeight: 280,
            maxHeight: 400,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            panel: _buildBottomSheet(),
            color: Colors.transparent,
          ),
        )
      ]),
    );
  }
}
