// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// class WalletScreen extends StatelessWidget {
//   final List<Map<String, String>> transactions = [
//     {'desc': '₹45 received from Trip ID #1234', 'time': '10:30 AM'},
//     {'desc': '₹100 received from Trip ID #1235', 'time': '11:15 AM'},
//     {'desc': '₹75 received from Trip ID #1236', 'time': '01:45 PM'},
//     {'desc': '₹50 received from Trip ID #1237', 'time': '03:00 PM'},
//     {'desc': '₹85 received from Trip ID #1238', 'time': '05:10 PM'},
//   ];

//    WalletScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xFFF4F6FA),
//       body: SafeArea(
//         child: Column(
//           children: [
//             _buildHeader(context),
//             _buildSummaryCards(),
//             _buildTransactionTitle(),
//             _buildTransactionList(),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         backgroundColor: Colors.pinkAccent,
//         child: Icon(Icons.add),
//         onPressed: () {
          
//         },
//       ),
//     );
//   }

//   Widget _buildHeader(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       padding: EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           colors: [Colors.pinkAccent, Colors.orangeAccent],
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//         ),
//         borderRadius: BorderRadius.only(
//           bottomLeft: Radius.circular(30),
//           bottomRight: Radius.circular(30),
//         ),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.pinkAccent.withOpacity(0.4),
//             blurRadius: 20,
//             offset: Offset(0, 8),
//           )
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text('Hi Naman 👋',
//                   style: GoogleFonts.poppins(
//                       fontSize: 20, color: Colors.white)),
//               Icon(Icons.settings, color: Colors.white),
//             ],
//           ),
//           SizedBox(height: 20),
//           Text('₹1,445',
//               style: GoogleFonts.poppins(
//                 fontSize: 32,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.white,
//               )),
//           Text('Total Net Worth',
//               style: GoogleFonts.poppins(
//                 fontSize: 14,
//                 color: Colors.white70,
//               )),
//         ],
//       ),
//     );
//   }

//   Widget _buildSummaryCards() {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           _buildGlassCard(Icons.calendar_today, 'Today', '₹320'),
//           _buildGlassCard(Icons.bar_chart, 'Weekly', '₹1,050'),
//           _buildGlassCard(Icons.download, 'Withdraw', '₹500'),
//         ],
//       ),
//     );
//   }

//   Widget _buildGlassCard(IconData icon, String title, String value) {
//     return Expanded(
//       child: Container(
//         margin: EdgeInsets.symmetric(horizontal: 6),
//         padding: EdgeInsets.all(14),
//         decoration: BoxDecoration(
//           color: Colors.white.withOpacity(0.8),
//           borderRadius: BorderRadius.circular(16),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.grey.withOpacity(0.2),
//               blurRadius: 10,
//               offset: Offset(0, 5),
//             )
//           ],
//         ),
//         child: Column(
//           children: [
//             Icon(icon, size: 28, color: Colors.pinkAccent),
//             SizedBox(height: 8),
//             Text(title,
//                 style: GoogleFonts.poppins(
//                     fontSize: 14, color: Colors.black87)),
//             Text(value,
//                 style: GoogleFonts.poppins(
//                     fontSize: 16, fontWeight: FontWeight.bold)),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildTransactionTitle() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text('Recent Transactions',
//               style: GoogleFonts.poppins(
//                   fontSize: 16, fontWeight: FontWeight.w600)),
//           Icon(Icons.filter_list, color: Colors.pinkAccent),
//         ],
//       ),
//     );
//   }

//   Widget _buildTransactionList() {
//     return Expanded(
//       child: ListView.builder(
//         itemCount: transactions.length,
//         padding: EdgeInsets.symmetric(horizontal: 16),
//         itemBuilder: (context, index) {
//           return Container(
//             margin: EdgeInsets.symmetric(vertical: 8),
//             padding: EdgeInsets.all(16),
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(16),
//               color: Colors.white,
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black12,
//                   blurRadius: 6,
//                   offset: Offset(0, 3),
//                 )
//               ],
//             ),
//             child: Row(
//               children: [
//                 CircleAvatar(
//                   backgroundColor: Colors.greenAccent,
//                   child: Icon(FontAwesomeIcons.indianRupeeSign, size: 16, color: Colors.white),
//                 ),
//                 SizedBox(width: 12),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(transactions[index]['desc'] ?? '',
//                           style: GoogleFonts.poppins(
//                             fontSize: 14,
//                             fontWeight: FontWeight.w500,
//                           )),
//                       SizedBox(height: 4),
//                       Row(
//                         children: [
//                           Icon(Icons.access_time, size: 14, color: Colors.grey),
//                           SizedBox(width: 4),
//                           Text(transactions[index]['time'] ?? '',
//                               style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey)),
//                         ],
//                       ),
//                     ],
//                   ),
//                 )
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:hive/hive.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  double balance = 0.0;
  double todayEarnings = 0.0;
  double weeklyEarnings = 0.0;
  List transactions = [];

  @override
  void initState() {
    super.initState();
    loadWalletData();
  }

  Future<void> loadWalletData() async {
    final userBox = await Hive.openBox('userBox');
    final userId = userBox.get('userId') ?? 'demoDriver';

    try {
      final walletRes = await http.get(Uri.parse('http://localhost:3000/api/wallet/$userId'));
      final logRes = await http.get(Uri.parse('http://localhost:3000/api/wallet/$userId/logs'));

      if (walletRes.statusCode == 200) {
        final data = jsonDecode(walletRes.body);
        setState(() {
          balance = data['balance'] ?? 0.0;
          todayEarnings = data['todayEarnings'] ?? 0.0;
          weeklyEarnings = data['weeklyEarnings'] ?? 0.0;
        });
      }

      if (logRes.statusCode == 200) {
        final data = jsonDecode(logRes.body);
        setState(() {
          transactions = data;
        });
      }
    } catch (e) {
      print("❌ Wallet load error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF4F6FA),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            _buildSummaryCards(),
            _buildTransactionTitle(),
            _buildTransactionList(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.pinkAccent,
        child: Icon(Icons.add),
        onPressed: () {},
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.pinkAccent, Colors.orangeAccent],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.pinkAccent.withOpacity(0.4),
            blurRadius: 20,
            offset: Offset(0, 8),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Hi Naman 👋',
                  style: GoogleFonts.poppins(fontSize: 20, color: Colors.white)),
              Icon(Icons.settings, color: Colors.white),
            ],
          ),
          SizedBox(height: 20),
          Text('₹${balance.toStringAsFixed(2)}',
              style: GoogleFonts.poppins(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              )),
          Text('Total Net Worth',
              style: GoogleFonts.poppins(fontSize: 14, color: Colors.white70)),
        ],
      ),
    );
  }

  Widget _buildSummaryCards() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildGlassCard(Icons.calendar_today, 'Today', '₹${todayEarnings.toStringAsFixed(2)}'),
          _buildGlassCard(Icons.bar_chart, 'Weekly', '₹${weeklyEarnings.toStringAsFixed(2)}'),
          _buildGlassCard(Icons.download, 'Withdraw', '₹500'),
        ],
      ),
    );
  }

  Widget _buildGlassCard(IconData icon, String title, String value) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 6),
        padding: EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.8),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 10,
              offset: Offset(0, 5),
            )
          ],
        ),
        child: Column(
          children: [
            Icon(icon, size: 28, color: Colors.pinkAccent),
            SizedBox(height: 8),
            Text(title, style: GoogleFonts.poppins(fontSize: 14, color: Colors.black87)),
            Text(value, style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget _buildTransactionTitle() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Recent Transactions',
              style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600)),
          Icon(Icons.filter_list, color: Colors.pinkAccent),
        ],
      ),
    );
  }

  Widget _buildTransactionList() {
    return Expanded(
      child: ListView.builder(
        itemCount: transactions.length,
        padding: EdgeInsets.symmetric(horizontal: 16),
        itemBuilder: (context, index) {
          final log = transactions[index];
          final desc = log['note'] ?? 'No note';
          final amount = log['amount'] ?? 0;
          final type = log['type'] ?? 'ride';
          final date = DateTime.fromMillisecondsSinceEpoch(log['date'] ?? 0)
              .toLocal()
              .toString()
              .split(' ')[0];

          return Container(
            margin: EdgeInsets.symmetric(vertical: 8),
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 6,
                  offset: Offset(0, 3),
                )
              ],
            ),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: type == 'ride' ? Colors.greenAccent : Colors.redAccent,
                  child: Icon(FontAwesomeIcons.indianRupeeSign, size: 16, color: Colors.white),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("₹$amount - ${type.toUpperCase()}",
                          style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500)),
                      SizedBox(height: 4),
                      Text(desc, style: GoogleFonts.poppins(fontSize: 13, color: Colors.grey[700])),
                      SizedBox(height: 2),
                      Row(
                        children: [
                          Icon(Icons.calendar_today, size: 12, color: Colors.grey),
                          SizedBox(width: 4),
                          Text(date, style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey)),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
