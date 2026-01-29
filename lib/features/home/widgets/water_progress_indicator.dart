import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/theme/app_colors.dart';
import '../../tracker/providers/water_provider.dart';

class WaterProgressIndicator extends StatelessWidget {
  const WaterProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<WaterProvider>(
      builder: (context, provider, child) {
        final progress = provider.progress;
        final intake = provider.currentIntake.toInt();
        final goal = provider.dailyGoal.toInt();

        return Stack(
          alignment: Alignment.center,
          children: [
            // Background Circle with Shadow
            Container(
              width: 280,
              height: 280,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.glassWhiteLow,
                boxShadow: [
                   BoxShadow(
                    color: AppColors.accentBlue.withOpacity(0.1),
                    blurRadius: 30,
                    spreadRadius: 5,
                  ),
                ],
              ),
            ),
            
            // Progress Arc
            SizedBox(
              width: 250,
              height: 250,
              child: CircularProgressIndicator(
                value: progress,
                strokeWidth: 20,
                backgroundColor: Colors.white.withOpacity(0.2),
                valueColor: const AlwaysStoppedAnimation<Color>(AppColors.accentBlue),
                strokeCap: StrokeCap.round,
              ).animate().custom(
                duration: 1000.ms,
                builder: (context, value, child) => CircularProgressIndicator(
                   value: value * progress, // Animate from 0 to current progress usually needs state awareness, but for simple reload this works
                   strokeWidth: 20,
                   backgroundColor: Colors.white.withOpacity(0.2),
                   valueColor: const AlwaysStoppedAnimation<Color>(AppColors.accentBlue),
                   strokeCap: StrokeCap.round,
                ),
              ),
            ),

            // Text Info
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.water_drop_rounded, size: 40, color: AppColors.accentBlue)
                    .animate().scale(duration: 600.ms, curve: Curves.elasticOut),
                const SizedBox(height: 8),
                Text(
                  '$intake',
                  style: GoogleFonts.outfit(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ).animate().fadeIn().moveY(begin: 10, end: 0),
                Text(
                  '/ $goal ml',
                  style: GoogleFonts.outfit(
                    fontSize: 18,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
