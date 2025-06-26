# 🚖 RayRide – Driver App UI (Internship Project)

This is a Flutter-based mobile application developed as part of an internship assignment. The app simulates a driver-side interface for a ride-sharing platform named **RayRide**.

---

## 📱 Features

### 1. 🧭 Dashboard UI
Displays key driver metrics:
- 🔋 Battery Percentage  
- 🚗 Daily Kilometers Driven  
- 💰 Earnings  
- ⚠️ System Alerts / Warnings  

### 2. 🤝 Fare Negotiation Interface
A screen to:
- Receive fare offers from users  
- Accept/Reject offers  
> *Basic real-time interaction simulated using mock data.*

### 3. 🗺️ Map Integration
- Shows **nearest charging stations**  
- Highlights **high-demand passenger zones** *(mocked)*  
- Adds **driver location marker** with zoom and pan functionality  

### 4. 💼 Wallet & Earnings Section
Displays:
- Daily / weekly earnings  
- Withdrawable balance  
- Transaction history  

### 5. 🔔 Push Notification Simulation
Displays push alerts for:
- New bookings  
- Battery low alerts  
- Payment updates  

---

## 🧱 Folder Structure

```
lib/
│
├─ dashboard_screen.dart          # Dashboard metrics
├─ fare_offer_screen.dart         # Fare requests list
├─ Ride_offer.dart                # Accept/Reject UI
├─ Map_screen.dart                # Map, zones & marker
├─ wallet_screen.dart             # Wallet & earnings UI
├─ Notification_screen.dart       # Notifications UI
├─ nav_bar.dart                   # Bottom navigation bar
└─ main.dart                      # App entry point
```

---

## 🚀 How to Run

1. Clone the repo  
```bash
git clone https://github.com/jainnaman0019/rayrides-work
cd rayride-work
```

2. Get dependencies  
```bash
flutter pub get
```

3. Run on emulator or device  
```bash
flutter run
```

---

## 📦 Dependencies

This project uses core Flutter and popular packages like:
- `google_maps_flutter`
- `flutter_local_notifications` *(for simulating push alerts)*
- `geolocator` *(for location services)*


---

## 📌 Note

- This app uses **mocked data** (no real backend).
- It focuses on **UI/UX**, **navigation**, and **integration of location, alerts, and state management.**