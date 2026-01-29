import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../tracker/providers/water_provider.dart';
import '../widgets/water_progress_indicator.dart';
import '../widgets/intake_controls.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Water Tracker'),
        leading: IconButton(
            icon: const Icon(Icons.settings_outlined, color: AppColors.textPrimary),
            onPressed: () {
                // Future: Settings page
            },
        ),
        actions: [
            IconButton(
                icon: const Icon(Icons.refresh, color: AppColors.textPrimary),
                onPressed: () {
                   context.read<WaterProvider>().resetToday();
                },
                tooltip: "Reset Today",
            )
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.backgroundLight,
              AppColors.backgroundDark,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const Spacer(flex: 1),
              const Center(child: WaterProgressIndicator()),
              const Spacer(flex: 1),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Text(
                  "Stay hydrated and track your daily intake.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.textSecondary.withOpacity(0.8),
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(height: 32),
              const IntakeControls(),
              const Spacer(flex: 2),
            ],
          ),
        ),
      ),
    );
  }
}
