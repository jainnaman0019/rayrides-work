import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:hive/hive.dart';

class DriverRideHistoryScreen extends StatefulWidget {
  @override
  _DriverRideHistoryScreenState createState() => _DriverRideHistoryScreenState();
}

class _DriverRideHistoryScreenState extends State<DriverRideHistoryScreen> {
  List<dynamic> rideList = [];
  bool isLoading = true;
  String? error;

  @override
  void initState() {
    super.initState();
    fetchRideHistory();
  }

  Future<void> fetchRideHistory() async {
    try {
      var userBox = Hive.box('userBox');
      String userId = userBox.get('userId'); // 🔍 Make sure this key exists
      final url = Uri.parse("http://localhost:3000/api/users/$userId/rides?role=driver");

      final response = await http.get(url);

      if (response.statusCode == 200) {
        setState(() {
          rideList = json.decode(response.body);
          isLoading = false;
        });
      } else {
        setState(() {
          error = 'Failed to load rides';
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        error = e.toString();
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Ride History")),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : error != null
              ? Center(child: Text(error!))
              : rideList.isEmpty
                  ? Center(child: Text("No rides found"))
                  : ListView.builder(
                      itemCount: rideList.length,
                      itemBuilder: (context, index) {
                        final ride = rideList[index];
                        return ListTile(
                          leading: Icon(Icons.local_taxi),
                          title: Text("From ${ride['pickup']} to ${ride['drop']}"),
                          subtitle: Text("Fare: ₹${ride['fare']} • Status: ${ride['status']}"),
                        );
                      },
                    ),
    );
  }
}
