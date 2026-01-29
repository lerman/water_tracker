import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/glass_container.dart';
import '../../tracker/providers/water_provider.dart';
import '../widgets/glass_progress_ring.dart';
import '../widgets/history_list_view.dart';
import 'package:flutter_animate/flutter_animate.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          // Dynamic Background Gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFFEBF4FA),
                  Color(0xFFD5E8F7),
                  Color(0xFFC2DDF4),
                ],
              ),
            ),
          ),
          
          // Content
          SafeArea(
            child: Column(
              children: [
                // Custom App Bar
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Row(
                    children: [
                      Text(
                        'Water Tracker',
                        style: GoogleFonts.outfit(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(Icons.refresh, color: AppColors.textPrimary),
                        onPressed: () => context.read<WaterProvider>().resetToday(),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 20),
                
                // Central Ring
                const GlassProgressRing(),
                
                const SizedBox(height: 40),
                
                // Info Card
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Consumer<WaterProvider>(
                    builder: (context, provider, _) {
                      return GlassContainer(
                        height: 80,
                        borderRadius: 24,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _buildInfoItem(
                              '${provider.glassCount}', 
                              'Glasses', 
                              Icons.local_drink
                            ),
                            Container(width: 1, height: 40, color: Colors.white.withOpacity(0.3)),
                            _buildInfoItem(
                              '${provider.currentIntake.toInt()} / ${provider.dailyGoal.toInt()}', 
                              'ml Consumed', 
                              Icons.water_drop
                            ),
                          ],
                        ),
                      ).animate().fadeIn().slideY(begin: 0.2, end: 0);
                    },
                  ),
                ),
                
                const SizedBox(height: 30),
                
                // History Header
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Today\'s History',
                      style: GoogleFonts.outfit(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                ),
                
                const SizedBox(height: 10),
                
                // List
                const Expanded(child: HistoryListView()),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: SizedBox(
          width: 70,
          height: 70,
          child: FloatingActionButton(
            backgroundColor: Colors.transparent, // Using container for custom look
            elevation: 0,
            onPressed: () => _showAddWaterSheet(context),
            shape: const CircleBorder(),
            child: Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                   begin: Alignment.topLeft,
                   end: Alignment.bottomRight,
                   colors: [AppColors.accentBlue, AppColors.accentWater],
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.accentBlue.withOpacity(0.4),
                    blurRadius: 20,
                    spreadRadius: 4,
                    offset: const Offset(0, 8),
                  )
                ],
              ),
              child: const Icon(Icons.add, size: 32, color: Colors.white),
            ),
          ).animate(onPlay: (c) => c.repeat(reverse: true))
           .scale(begin: const Offset(1, 1), end: const Offset(1.05, 1.05), duration: 1500.ms),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _buildInfoItem(String value, String label, IconData icon) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
           children: [
             Icon(icon, size: 16, color: AppColors.accentBlue),
             const SizedBox(width: 4),
             Text(
               value,
               style: GoogleFonts.outfit(
                 fontSize: 18,
                 fontWeight: FontWeight.bold,
                 color: AppColors.textPrimary,
               ),
             ),
           ],
        ),
        Text(
          label,
          style: GoogleFonts.outfit(
            fontSize: 12,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }

  void _showAddWaterSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: 300,
        decoration: BoxDecoration(
          color: AppColors.backgroundLight.withOpacity(0.95),
          borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
        ),
        child: ClipRRect(
           borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
           child: BackdropFilter(
             filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
             child: Column(
               mainAxisAlignment: MainAxisAlignment.center,
               children: [
                 Text("Add Water", style: GoogleFonts.outfit(fontSize: 24, fontWeight: FontWeight.bold)),
                 const SizedBox(height: 30),
                 Row(
                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                   children: [
                     _buildAddButton(context, 150),
                     _buildAddButton(context, 250),
                     _buildAddButton(context, 500),
                   ],
                 )
               ],
             ),
           ),
        ),
      ),
    );
  }

  Widget _buildAddButton(BuildContext context, double amount) {
    return GestureDetector(
      onTap: () {
        context.read<WaterProvider>().addWater(amount);
        Navigator.pop(context);
      },
      child: Column(
        children: [
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.5),
              shape: BoxShape.circle,
              boxShadow: [
                 BoxShadow(
                   color: Colors.black.withOpacity(0.05),
                   blurRadius: 10,
                 )
              ]
            ),
            child: const Icon(Icons.water_drop_rounded, color: AppColors.accentBlue, size: 30),
          ),
          const SizedBox(height: 8),
          Text("+${amount.toInt()}ml", style: GoogleFonts.outfit(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
