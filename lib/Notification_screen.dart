import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class Notificationscreen extends StatefulWidget {
  @override
  State<Notificationscreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<Notificationscreen> {
  List<Map<String, dynamic>> allNotifications = [
    {
      "icon": Icons.local_taxi,
      "title": "You have a new booking!",
      "subtitle": "Pickup at 5:30 PM from Sector 21.",
      "time": DateTime.now().subtract(Duration(minutes: 15)),
      "read": false,
    },
    {
      "icon": Icons.battery_alert,
      "title": "Battery at 20% – charge soon",
      "subtitle": "Low battery may affect ride acceptance.",
      "time": DateTime.now(),
      "read": false,
    },
    {
      "icon": Icons.attach_money,
      "title": "₹200 added to wallet",
      "subtitle": "Payment from completed ride #10234.",
      "time": DateTime.now().subtract(Duration(days: 1, hours: 2)),
      "read": true,
    },
    {
      "icon": Icons.message,
      "title": "New message from admin",
      "subtitle": "Please upload your updated RC.",
      "time": DateTime.now().subtract(Duration(days: 1, hours: 4)),
      "read": true,
    },
  ];

  void markAsRead(Map<String, dynamic> item) {
    setState(() {
      item["read"] = true;
    });
  }

  void removeNotification(Map<String, dynamic> item) {
    setState(() {
      allNotifications.remove(item);
    });
  }

  bool isSameDate(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(Duration(days: 1));

    List<Map<String, dynamic>> todayList = allNotifications.where((n) {
      final t = n["time"] as DateTime;
      return isSameDate(t, today);
    }).toList();

    List<Map<String, dynamic>> yesterdayList = allNotifications.where((n) {
      final t = n["time"] as DateTime;
      return isSameDate(t, yesterday);
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text("Notifications"),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [Colors.deepPurple, Colors.indigo]),
          ),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(12),
        children: [
          if (todayList.isNotEmpty) SectionHeader(title: "Today"),
          ...todayList.map((item) => AnimatedNotificationCard(
                data: item,
                onTap: () => markAsRead(item),
                onDismissed: () => removeNotification(item),
              )),
          if (yesterdayList.isNotEmpty) SectionHeader(title: "Yesterday"),
          ...yesterdayList.map((item) => AnimatedNotificationCard(
                data: item,
                onTap: () => markAsRead(item),
                onDismissed: () => removeNotification(item),
              )),
        ],
      ),
    );
  }
}

class SectionHeader extends StatelessWidget {
  final String title;
  const SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 14),
      child: Text(
        title,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.grey[800]),
      ),
    );
  }
}

class AnimatedNotificationCard extends StatefulWidget {
  final Map<String, dynamic> data;
  final VoidCallback onTap;
  final VoidCallback onDismissed;

  AnimatedNotificationCard({
    required this.data,
    required this.onTap,
    required this.onDismissed,
  });

  @override
  _AnimatedNotificationCardState createState() =>
      _AnimatedNotificationCardState();
}

class _AnimatedNotificationCardState extends State<AnimatedNotificationCard>
    with SingleTickerProviderStateMixin {
  bool isExpanded = false;

  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 600));
    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _slideAnimation =
        Tween<Offset>(begin: Offset(0, 0.1), end: Offset.zero).animate(_controller);

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String getFormattedTime(DateTime time) {
    return DateFormat('hh:mm a').format(time);
  }

  @override
  Widget build(BuildContext context) {
    final data = widget.data;

    return SlideTransition(
      position: _slideAnimation,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: Dismissible(
          key: Key(data["title"] + data["time"].toString()),
          direction: DismissDirection.endToStart,
          background: Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.only(right: 20),
            color: Colors.redAccent,
            child: Icon(Icons.delete, color: Colors.white),
          ),
          onDismissed: (_) {
            widget.onDismissed();
          },
          child: GestureDetector(
            onTap: () {
              setState(() {
                isExpanded = !isExpanded;
              });
              widget.onTap();
            },
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 8),
              padding: EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade300,
                    blurRadius: 10,
                    offset: Offset(2, 4),
                  )
                ],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.indigo.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(data["icon"], size: 26, color: Colors.indigo),
                      ),
                      if (!data["read"])
                        Positioned(
                          right: 0,
                          top: 0,
                          child: Container(
                            height: 10,
                            width: 10,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                    ],
                  ),
                  SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data["title"],
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        if (isExpanded)
                          Padding(
                            padding: const EdgeInsets.only(top: 6.0),
                            child: Text(
                              data["subtitle"],
                              style: TextStyle(color: Colors.grey[700]),
                            ),
                          ),
                      ],
                    ),
                  ),
                  Text(
                    getFormattedTime(data["time"]),
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
