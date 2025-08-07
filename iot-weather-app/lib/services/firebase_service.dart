import 'package:firebase_database/firebase_database.dart';
import '../models/weather_data.dart';

class FirebaseService {
  static Future<WeatherData?> getLatestWeather() async {
    try {
      final dbRef = FirebaseDatabase.instance.ref("weather_data/user1");
      final snapshot = await dbRef.limitToLast(1).get();
      if (snapshot.exists) {
        final dataMap = Map<String, dynamic>.from(snapshot.children.first.value as Map);
        return WeatherData.fromMap(dataMap);
      }
    } catch (e) {
      print("Error fetching data: \$e");
    }
    return null;
  }
}