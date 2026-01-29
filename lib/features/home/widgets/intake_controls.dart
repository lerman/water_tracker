import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/glass_container.dart';
import '../../tracker/providers/water_provider.dart';
import 'package:flutter_animate/flutter_animate.dart';

class IntakeControls extends StatelessWidget {
  const IntakeControls({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildIntakeButton(context, 150, Icons.local_drink_rounded),
        _buildIntakeButton(context, 250, Icons.water_drop_rounded),
        _buildIntakeButton(context, 500, Icons.local_cafe_rounded),
      ],
    );
  }

  Widget _buildIntakeButton(BuildContext context, double amount, IconData icon) {
    return GestureDetector(
      onTap: () {
        context.read<WaterProvider>().addWater(amount);
      },
      child: GlassContainer(
        width: 80,
        height: 100,
        borderRadius: 20,
        padding: EdgeInsets.zero,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 32, color: AppColors.accentBlue),
            const SizedBox(height: 8),
            Text(
              '+${amount.toInt()}',
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ),
      ).animate().scale(duration: 300.ms, curve: Curves.easeOutBack),
    );
  }
}
