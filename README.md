# IoT Weather Station – Real-Time Sensor Dashboard

This project is a real-world IoT + Cloud + Mobile solution that collects environmental data (temperature, humidity, and light) using an ESP8266 and displays it live in a Flutter mobile app using Firebase as the backend.

##  Tech Stack
- ESP8266 (NodeMCU)
- Sensors: DHT11 (Temp/Humidity), LDR (Light)
- Firebase Realtime Database
- Firebase Auth (email/password)
- Flutter (Android/iOS app)
- FirebaseESP8266 Arduino library

##  Folder Structure
```
/IoT_Weather_Station
│
├── iot-weather-firmware
│   ├── main.ino
│   └── FirebaseConfig.h
│
└── iot-weather-app
    ├── lib/
    │   ├── main.dart
    │   ├── pages/home_page.dart
    │   ├── services/firebase_service.dart
    │   ├── models/weather_data.dart
    │   └── widgets/status_card.dart
```

##  How to Run

### ESP8266 Firmware
1. Open `main.ino` in Arduino IDE.
2. Install required libraries:
   - FirebaseESP8266
   - DHT sensor library
   - EEPROM
3. Update `FirebaseConfig.h` with your WiFi + Firebase details.
4. Upload to ESP8266 and open serial monitor.

### Flutter App
1. Run `flutter pub get` in `iot-weather-app`.
2. Set up Firebase project and configure Android/iOS builds.
3. Run with `flutter run`.

##  Example Firebase Entry
```json
{
  "timestamp": "2025-08-07T19:32:45Z",
  "temperature": 28.6,
  "humidity": 62,
  "light": 413
}
```

##  Future Improvements
- Offline data buffering with EEPROM
- Add BME280 for pressure readings
- Historical graphs
- CSV export
- Notifications (e.g., high humidity warning)

## Firebase Setup
Realtime Database Rules:
```json
{
  "rules": {
    "weather_data": {
      "$uid": {
        ".read": "$uid === auth.uid",
        ".write": "$uid === auth.uid"
      }
    }
  }
}
```