import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:rayride/role_selection_screen.dart';
import 'package:rayride/booking_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('offline_bookings');

  Connectivity().onConnectivityChanged.listen((List<ConnectivityResult> results) {
    if (results.any((result) => result != ConnectivityResult.none)) {
      syncOfflineBookings();
    }
  });

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: roleSelection(),
    ),
  );
}
