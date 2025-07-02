# 🚖 RayRide – Driver + Commuter App UI (Internship Project)

This is a **Flutter-based mobile application** developed as part of an internship assignment. The app simulates both **Driver-side** and **Commuter-side** interfaces for the ride-sharing platform **RayRide**.

---

## 📱 Features

### 👨‍✈️ Driver Module

#### 1. 🧭 Dashboard UI
Displays key driver metrics:
- 🔋 Battery Percentage  
- 🚗 Daily Kilometers Driven  
- 💰 Earnings  
- ⚠️ System Alerts / Warnings  

#### 2. 🤝 Fare Negotiation Interface
A screen to:
- Receive fare offers from users  
- Accept/Reject offers  
> *Real-time interaction simulated using mock data.*

#### 3. 🗺️ Map Integration
- Shows **nearest charging stations**  
- Highlights **high-demand zones** *(mocked)*  
- Displays **driver location marker** with pan/zoom  

#### 4. 💼 Wallet & Earnings Section
- Daily/weekly earnings  
- Withdrawable balance  
- Transaction history  

#### 5. 🔔 Push Notification Simulation
Alerts for:
- New bookings  
- Battery low  
- Payment updates  

---

### 👨‍👩‍👧‍👦 Commuter Module

#### 1. 🚕 Fare Suggestion & Advance Booking
- User inputs drop location  
- Static fare displayed (₹120 mock)  
- Ride can be booked 5 minutes in advance  
- Integrated with Flutter Map for user location  
- Input validation & feedback using SnackBar

#### 2. 📊 Shared Ride Dashboard
- Shows live seat occupancy (e.g. 2/4 occupied)  
- Rotating mock pickup/drop points (Sector, Market etc.)  
- Real-time updates simulated with `Timer.periodic`

#### 3. 🗺️ Live Ride Tracking (🔄 In Progress)
- Map-based ride tracking with mocked driver/user locations  
- Planned reroute logic if pickup missed  
- (Will use `flutter_maps` + markers)

#### 4. 📴 Offline Booking Logic (🔄 In Progress)
- Allow booking even without network  
- Store locally using `hive`  
- Sync request when back online




---

## 🚀 How to Run

```bash
git clone https://github.com/jainnaman0019/rayrides-work
cd rayrides-work
flutter pub get
flutter run
```

---

## 📦 Dependencies

This Flutter project uses the following packages:

- `cupertino_icons: ^1.0.8`
- `persistent_bottom_nav_bar: ^6.2.1`
- `percent_indicator: ^4.2.5`
- `swipe_cards: ^2.0.0+1`
- `google_fonts: ^6.2.1`
- `tcard: ^1.3.5`
- `geolocator: ^14.0.1`
- `provider: ^6.1.5`
- `flutter_map: ^6.1.0`
- `latlong2: ^0.9.1`
- `shared_preferences: ^2.5.3`
- `font_awesome_flutter: ^10.8.0`
- `intl: ^0.20.2`
- `sliding_up_panel: ^2.0.0+1`
- `location: ^8.0.1`
- `hive_flutter: ^1.1.0`
- `hive: ^2.2.3`
- `connectivity_plus: ^6.0.1`
- `uuid: ^4.5.1`

To install all dependencies, run:

```bash
flutter pub get

---


## 📌 Notes

- All logic is mock-based (no backend/API).
- App focuses on UI/UX, modular screen separation, and simulation of real-world ride logic.
- Built as part of the **RayGlides MVP Internship Assignment**.