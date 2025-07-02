// lib/offline_bookings_screen.dart
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class OfflineBookingsScreen extends StatefulWidget {
  @override
  _OfflineBookingsScreenState createState() => _OfflineBookingsScreenState();
}

class _OfflineBookingsScreenState extends State<OfflineBookingsScreen> {
  late Box bookingsBox;

  @override
  void initState() {
    super.initState();
    _loadBox();
  }

  Future<void> _loadBox() async {
    bookingsBox = await Hive.openBox('offline_bookings');
    setState(() {}); // Rebuild after loading
  }

  @override
  Widget build(BuildContext context) {
    if (!Hive.isBoxOpen('offline_bookings')) {
      return Scaffold(
        appBar: AppBar(title: Text("Offline Bookings")),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final bookings = bookingsBox.values.toList();

    return Scaffold(
      appBar: AppBar(
        title: Text("Offline Bookings"),
        backgroundColor: Colors.deepOrange,
      ),
      body: bookings.isEmpty
          ? Center(child: Text("No offline bookings stored."))
          : ListView.builder(
              itemCount: bookings.length,
              itemBuilder: (context, index) {
                final booking = bookings[index];
                return Card(
                  margin: EdgeInsets.all(8),
                  child: ListTile(
                    leading: Icon(Icons.directions_car),
                    title: Text("${booking['pickup']} → ${booking['drop']}"),
                    subtitle: Text("Fare: ₹${booking['fare']}"),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () async {
                        await bookingsBox.delete(booking['id']);
                        setState(() {});
                      },
                    ),
                  ),
                );
              },
            ),
    );
  }
}
