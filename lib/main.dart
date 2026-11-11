import 'package:flutter/material.dart';

import 'map_screen.dart';

void main() {
  runApp(const MapsApp());
}

class MapsApp extends StatelessWidget {
  const MapsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Maps and Geolocation',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF2F8D46)),
        useMaterial3: true,
      ),
      home: const MapScreen(),
    );
  }
}
