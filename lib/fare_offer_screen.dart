import 'package:flutter/material.dart';
import 'package:tcard/tcard.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rayride/Ride_offer.dart';

class fareofferscreen extends StatelessWidget {
  final List<Rideoffer> offers = [
    Rideoffer(
      pickup: 'DTU Rohini',
      drop: 'India Gate',
      fare: 520.0,
      distance: 33,
      status: 'pending',
      expirytime: DateTime.now().add(Duration(hours: 1)),
    ),
    Rideoffer(
      pickup: 'Connaught Place',
      drop: 'Rajiv Chowk',
      fare: 150.0,
      distance: 5,
      status: 'accepted',
      expirytime: DateTime.now().add(Duration(hours: 2)),
    ),
    Rideoffer(
      pickup: 'Dwarka Sector 21',
      drop: 'IGI Airport',
      fare: 300.0,
      distance: 15,
      status: 'rejected',
      expirytime: DateTime.now().add(Duration(hours: 1)),
    ),
    Rideoffer(
      pickup: 'Khan Market',
      drop: 'Lodhi Garden',
      fare: 200.0,
      distance: 8,
      status: 'pending',
      expirytime: DateTime.now().add(Duration(hours: 3)),
    ),
    Rideoffer(
      pickup: 'Saket',
      drop: 'Select Citywalk',
      fare: 180.0,
      distance: 6,
      status: 'accepted',
      expirytime: DateTime.now().add(Duration(hours: 2)),
    ),
    Rideoffer(
      pickup: 'Noida Sector 18',
      drop: 'DLF Mall of India',
      fare: 250.0,
      distance: 10,
      status: 'pending',
      expirytime: DateTime.now().add(Duration(hours: 1)),
    ),
    Rideoffer(
      pickup: 'Gurgaon Cyber Hub',
      drop: 'MG Road',
      fare: 220.0,
      distance: 12,
      status: 'rejected',
      expirytime: DateTime.now().add(Duration(hours: 2)),
    ),
    Rideoffer(
      pickup: 'Chandni Chowk',
      drop: 'Red Fort',
      fare: 100.0,
      distance: 4,
      status: 'pending',
      expirytime: DateTime.now().add(Duration(hours: 1)),
    ),
  ];

   fareofferscreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TCardController controller = TCardController();

    List<Widget> cards = offers.map((offer) {
      return Container(
        width: MediaQuery.of(context).size.width * 0.9,
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade100, Colors.white],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade400,
              blurRadius: 10,
              offset: Offset(2, 4),
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header
            Row(
              children: [
                CircleAvatar(
                  radius: 26,
                  backgroundColor: Colors.blue.shade300,
                  child: Text(
                    offer.pickup[0],
                    style: TextStyle(fontSize: 22, color: Colors.white),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'From ${offer.pickup}',
                    style: GoogleFonts.lato(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Chip(
                  label: Text(
                    offer.status.toUpperCase(),
                    style: TextStyle(color: Colors.white),
                  ),
                  backgroundColor: {
                    'accepted': Colors.green,
                    'pending': Colors.orange,
                    'rejected': Colors.red,
                  }[offer.status]!,
                ),
              ],
            ),
            SizedBox(height: 12),

            _infoTile(Icons.flag, 'Drop', offer.drop),
            _infoTile(Icons.currency_rupee, 'Fare',
                '₹${offer.fare.toStringAsFixed(2)}'),
            _infoTile(Icons.route, 'Distance', '${offer.distance} km'),
            _infoTile(Icons.timer, 'Expires at',
                '${offer.expirytime.hour}:${offer.expirytime.minute.toString().padLeft(2, '0')}'),
            SizedBox(height: 16),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    controller.forward(direction: SwipDirection.Right);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("Offer Accepted from ${offer.pickup}")));
                  },
                  icon: Icon(Icons.check),
                  label: Text("Accept"),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    controller.forward(direction: SwipDirection.Left);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("Offer Rejected from ${offer.pickup}")));
                  },
                  icon: Icon(Icons.close),
                  label: Text("Reject"),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                ),
              ],
            ),
          ],
        ),
      );
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text("Ride Offers", style: GoogleFonts.poppins(fontSize: 22)),
        centerTitle: true,
        backgroundColor: Colors.blue.shade600,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return TCard(
            controller: controller,
            size: Size(constraints.maxWidth, constraints.maxHeight * 0.82),
            cards: cards,
            onForward: (index, info) {
              if (index == cards.length) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("No more offers left")),
                );
              }
            },
          );
        },
      ),
    );
  }

  Widget _infoTile(IconData icon, String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.black54),
          SizedBox(width: 8),
          Text('$label: ',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
          Expanded(
            child: Text(value, style: TextStyle(fontSize: 15)),
          ),
        ],
      ),
    );
  }
}
