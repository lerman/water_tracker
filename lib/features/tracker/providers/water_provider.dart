import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/water_log.dart';

class WaterProvider with ChangeNotifier {
  double _dailyGoal = 2500; // ml
  List<WaterLog> _logs = [];

  double get dailyGoal => _dailyGoal;
  List<WaterLog> get logs => _logs;

  List<WaterLog> get todaysLogs {
    final now = DateTime.now();
    return _logs.where((log) =>
        log.timestamp.year == now.year &&
        log.timestamp.month == now.month &&
        log.timestamp.day == now.day).toList();
  }

  double get currentIntake {
    return todaysLogs.fold(0, (sum, log) => sum + log.amount);
  }

  int get glassCount => (currentIntake / 250).ceil();

  double get progress => (currentIntake / _dailyGoal).clamp(0.0, 1.0);

  WaterProvider() {
    _loadFromPrefs();
  }

  void addWater(double amount) {
    _logs.add(WaterLog(amount: amount, timestamp: DateTime.now()));
    _saveToPrefs();
    notifyListeners();
  }

  void setGoal(double newGoal) {
    _dailyGoal = newGoal;
    _saveToPrefs();
    notifyListeners();
  }

  void resetToday() {
     // For demo/debug purposes mainly, or if user wants to clear today's logs
     final now = DateTime.now();
     _logs.removeWhere((log) => 
        log.timestamp.year == now.year &&
        log.timestamp.month == now.month &&
        log.timestamp.day == now.day
     );
     _saveToPrefs();
     notifyListeners();
  }

  Future<void> _loadFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    _dailyGoal = prefs.getDouble('dailyGoal') ?? 2500;
    
    final logsJson = prefs.getStringList('logs') ?? [];
    _logs = logsJson.map((str) => WaterLog.fromJson(jsonDecode(str))).toList();
    
    notifyListeners();
  }

  Future<void> _saveToPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('dailyGoal', _dailyGoal);
    
    final logsJson = _logs.map((log) => jsonEncode(log.toJson())).toList();
    await prefs.setStringList('logs', logsJson);
  }
}
