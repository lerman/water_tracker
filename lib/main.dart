import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/theme/app_theme.dart';
import 'features/tracker/providers/water_provider.dart';
import 'features/home/screens/home_screen.dart';

void main() {
  runApp(const WaterTrackerApp());
}

class WaterTrackerApp extends StatelessWidget {
  const WaterTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => WaterProvider()),
      ],
      child: MaterialApp(
        title: 'Water Tracker',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme, // Apply the Glassmorphism theme
        home: const HomeScreen(),
      ),
    );
  }
}
