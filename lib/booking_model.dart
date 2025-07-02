class Booking {
  final String id;
  final String pickup;
  final String drop;
  final double fare;
  final bool isSynced;

  Booking({
    required this.id,
    required this.pickup,
    required this.drop,
    required this.fare,
    required this.isSynced,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'pickup': pickup,
      'drop': drop,
      'fare': fare,
      'isSynced': isSynced,
    };
  }

  factory Booking.fromMap(Map<String, dynamic> map) {
    return Booking(
      id: map['id'],
      pickup: map['pickup'],
      drop: map['drop'],
      fare: map['fare'],
      isSynced: map['isSynced'],
    );
  }
}
