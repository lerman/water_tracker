import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/glass_container.dart';
import '../../tracker/providers/water_provider.dart';

class GlassProgressRing extends StatelessWidget {
  const GlassProgressRing({super.key});

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
            // Base Glass Circle
            const GlassContainer(
              width: 300,
              height: 300,
              shape: BoxShape.circle,
              blur: 15,
              borderOpacity: 0.1,
              child: SizedBox(),
            ),

            // Active Progress Indicator with Glow
            SizedBox(
              width: 260,
              height: 260,
              child: TweenAnimationBuilder<double>(
                tween: Tween<double>(begin: 0, end: progress),
                duration: 1200.ms,
                curve: Curves.easeOutCubic,
                builder: (context, value, _) {
                  return CircularProgressIndicator(
                    value: value,
                    strokeWidth: 25,
                    backgroundColor: Colors.white.withOpacity(0.1),
                    valueColor: const AlwaysStoppedAnimation<Color>(AppColors.accentWater),
                    strokeCap: StrokeCap.round,
                  );
                },
              ),
            ),

            // Inner Info
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '$intake',
                  style: GoogleFonts.outfit(
                    fontSize: 64,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                    letterSpacing: -2,
                    height: 1,
                  ),
                ).animate(target: progress == 0 ? 0 : 1).fadeIn().scale(duration: 400.ms),
                Text(
                  'ml',
                  style: GoogleFonts.outfit(
                    fontSize: 24,
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.accentBlue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'Goal: $goal',
                    style: GoogleFonts.outfit(
                      fontSize: 14,
                      color: AppColors.textSecondary,
                      fontWeight: FontWeight.w600,
                    ),
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
