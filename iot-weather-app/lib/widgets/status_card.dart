import 'package:flutter/material.dart';

class StatusCard extends StatelessWidget {
  final String label;
  final String value;

  const StatusCard({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: ListTile(
        title: Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(value, style: const TextStyle(fontSize: 20)),
      ),
    );
  }
}