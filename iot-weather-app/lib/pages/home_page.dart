import 'package:flutter/material.dart';
import '../services/firebase_service.dart';
import '../models/weather_data.dart';
import '../widgets/status_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  WeatherData? data;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    final latest = await FirebaseService.getLatestWeather();
    setState(() {
      data = latest;
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("IoT Weather Dashboard")),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : data == null
              ? const Center(child: Text("No data found"))
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    StatusCard(label: "Temperature", value: "${data!.temperature} °C"),
                    StatusCard(label: "Humidity", value: "${data!.humidity} %"),
                    StatusCard(label: "Light", value: "${data!.light}"),
                  ],
                ),
    );
  }
}