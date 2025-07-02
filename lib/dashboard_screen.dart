import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[350],
        title: Container(
          padding: EdgeInsets.all(7),
          child: Row(
            children: [
              Text('Rayrides dashboard',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Spacer(),
              CircleAvatar(
                radius: 25,
                backgroundColor: Colors.grey[300],
                child: Icon(
                  Icons.person,
                  size: 30,
                  color: Colors.black,
                ),
              ),
              SizedBox(width: 7),
              Icon(Icons.settings, size: 25, color: Colors.black),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Battery status
            Container(
              height: MediaQuery.of(context).size.height * 0.27,
              width: double.infinity,
              margin: EdgeInsets.fromLTRB(4, 0, 4, 0),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.lightBlue.shade50,
                    Colors.lightBlue.shade100
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color:
                        const Color.fromARGB(255, 93, 90, 90).withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 10,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.battery_charging_full,
                          size: 25, color: Colors.green),
                      SizedBox(width: 10),
                      Text(
                        'Battery Status: ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      SizedBox(width: 7),
                      Text(
                        '76%',
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                  SizedBox(height: 19),
                  CircularPercentIndicator(
                    radius: 50.0,
                    lineWidth: 15,
                    animation: true,
                    percent: 0.76,
                    center: Text(
                      '76%',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    footer: Text(
                      'Battery Status:Good',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    circularStrokeCap: CircularStrokeCap.round,
                    progressColor: Colors.green,
                    backgroundColor: Colors.grey[300]!,
                  )
                ],
              ),
            ),

            
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.25,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      shadowColor:
                          const Color.fromARGB(255, 62, 61, 61).withOpacity(0.5),
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  'images/1.jpeg',
                                  width: 60,
                                  height: 60,
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    '₹520 Earned today',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Text(
                              '5 Rides Completed',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Card(
                      margin: EdgeInsets.all(10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      shadowColor:
                          const Color.fromARGB(255, 62, 61, 61).withOpacity(0.5),
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  'images/2.png',
                                  width: 60,
                                  height: 60,
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    '23.4 km Driven today',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Today\'s Distance',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            
            Container(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Text(
                    'Alerts!',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 15),
                  buildAlertTile('Check Tire pressure'),
                  SizedBox(height: 15),
                  buildAlertTile('Battery Below 25%'),
                ],
              ),
            ),

            
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
              child: SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    
                    print("View Full Report Pressed");
                  },
                  child: Text(
                    'View Full Report',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildAlertTile(String title) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.amber),
        gradient: LinearGradient(
          colors: [Colors.amber.shade100, Colors.amber.shade200],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.all(10),
      child: Row(
        children: [
          Icon(Icons.warning_amber_outlined, color: Colors.amber),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              title,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          ElevatedButton(onPressed: () {}, child: Text('View')),
          SizedBox(width: 5),
          Icon(Icons.cancel_outlined, color: Colors.white),
        ],
      ),
    );
  }
}
