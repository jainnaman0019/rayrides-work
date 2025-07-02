import 'package:flutter/material.dart' ;
import 'package:hive/hive.dart';
import 'package:rayride/booking_model.dart'; // adjust path
 // if separated

Future<void> syncOfflineBookings({BuildContext? context}) async {
  var box = Hive.box('offline_bookings');
  
  var keys = box.keys.toList();

  for (var key in keys) {
    var bookingMap = box.get(key);
    var booking = Booking.fromMap(Map<String, dynamic>.from(bookingMap));

    if (!booking.isSynced) {
      bool success = await sendToServer(booking);
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

Future<bool> sendToServer(Booking booking) async {
  await Future.delayed(Duration(seconds: 1));
  print("📡 Sent booking to server: ${booking.pickup} → ${booking.drop}");
  return true;
}
