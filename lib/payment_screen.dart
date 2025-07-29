import 'package:flutter/material.dart';

class PaymentScreen extends StatefulWidget {
  final int amount;
  final String rideId;

  const PaymentScreen({super.key, required this.amount, required this.rideId});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  bool isPaid = false;

  void _simulatePayment() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Razorpay"),
        content: Text("Simulating payment..."),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              setState(() {
                isPaid = true;
              });
            },
            child: Text("OK"),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment'),
      ),
      body: Center(
        child: isPaid
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.check_circle, color: Colors.green, size: 100),
                  SizedBox(height: 20),
                  Text("✅ Payment Successful!", style: TextStyle(fontSize: 20)),
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Amount to Pay: ₹${widget.amount}", style: TextStyle(fontSize: 22)),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _simulatePayment,
                    child: Text("Pay Now"),
                  ),
                ],
              ),
      ),
    );
  }
}
