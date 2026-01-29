class WaterLog {
  final double amount; // in ml
  final DateTime timestamp;

  WaterLog({required this.amount, required this.timestamp});

  Map<String, dynamic> toJson() => {
        'amount': amount,
        'timestamp': timestamp.toIso8601String(),
      };

  factory WaterLog.fromJson(Map<String, dynamic> json) {
    return WaterLog(
      amount: json['amount'],
      timestamp: DateTime.parse(json['timestamp']),
    );
  }
}
