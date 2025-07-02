import 'dart:async';
import 'package:flutter/material.dart';
import 'live_ride_tracking_screen.dart'; // Import the live tracking screen

class SharedRideDashboardScreen extends StatefulWidget {
  final String dropLocation;
  final String fare;

  const SharedRideDashboardScreen({super.key, required this.dropLocation, required this.fare});

  @override
  _SharedRideDashboardScreenState createState() =>
      _SharedRideDashboardScreenState();
}

class _SharedRideDashboardScreenState extends State<SharedRideDashboardScreen> {
  int totalSeats = 4;
  int currentOccupancy = 1;
  List<String> pickups = ["Sector 10", "Mall Gate", "School"];
  List<String> drops = ["Metro", "Market", "Park"];
  int index = 0;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 5), (timer) {
      setState(() {
        currentOccupancy = (currentOccupancy + 1) % (totalSeats + 1);
        index = (index + 1) % pickups.length;
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  Widget buildInfoTile(String label, String value, IconData icon, Color color) {
    return Card(
      child: ListTile(
        leading: Icon(icon, color: color),
        title: Text(label),
        subtitle: Text(value, style: TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double progress = currentOccupancy / totalSeats;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text('Ride Dashboard'),
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(16),
          children: [
            Text("Live Ride Status",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text("Seats Occupied", style: TextStyle(fontSize: 18)),
                    SizedBox(height: 10),
                    LinearProgressIndicator(
                      value: progress,
                      minHeight: 10,
                      backgroundColor: Colors.grey[300],
                      color: Colors.deepPurple,
                    ),
                    SizedBox(height: 10),
                    Text("$currentOccupancy / $totalSeats Occupied"),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            buildInfoTile("Next Pickup", pickups[index], Icons.location_on, Colors.green),
            buildInfoTile("Next Drop-off", drops[index], Icons.flag, Colors.red),
            buildInfoTile("Drop Location", widget.dropLocation, Icons.location_pin, Colors.blue),
            buildInfoTile("Estimated Fare", widget.fare, Icons.attach_money, Colors.orange),
            SizedBox(height: 20),
            // Button to start live ride tracking
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LiveRideTrackingScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 16),
                textStyle: TextStyle(fontSize: 18),
              ),
              child: Text('Start Ride Tracking'),
            )
          ],
        ),
      ),
    );
  }
}
