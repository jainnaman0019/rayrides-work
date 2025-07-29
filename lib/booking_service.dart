import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:rayride/booking_model.dart'; // Ensure this path is correct
import 'dart:convert';
import 'package:http/http.dart' as http;

/// Sync all unsynced offline bookings to the backend.
Future<void> syncOfflineBookings({BuildContext? context}) async {
  final box = Hive.box('offline_bookings');
  final keys = box.keys.toList();

  for (var key in keys) {
    final raw = box.get(key);
    if (raw is! Map) continue; // 💡 Safety check

    final booking = Booking.fromMap(Map<String, dynamic>.from(raw));

    if (!booking.isSynced) {
      final success = await sendToServer(booking);
      if (success) {
        await box.delete(key);
        print("✅ Synced booking: ${booking.pickup} → ${booking.drop}");

        if (context != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("✅ Synced booking: ${booking.pickup} → ${booking.drop}"),
              backgroundColor: Colors.green,
              duration: Duration(seconds: 2),
            ),
          );
        }
      }
    }
  }
}

/// Simulates sending booking data to server.


Future<bool> sendToServer(Booking booking) async {
  try {
    final response = await http.post(
      Uri.parse('http://localhost:3000/api/rides/book'), // ⚠️ Replace 'localhost' with actual IP if testing on device
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'pickup': booking.pickup,
        'drop': booking.drop,
        'fare': booking.fare,
        'commuterId': booking.commuterId,
      }),
    );

    if (response.statusCode == 200) {
      print("✅ Booking synced to server: ${booking.pickup} → ${booking.drop}");
      return true;
    } else {
      print("❌ Server responded with: ${response.statusCode} - ${response.body}");
      return false;
    }
  } catch (e) {
    print("❌ Error sending booking to server: $e");
    return false;
  }
}
