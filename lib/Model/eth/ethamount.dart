import 'package:cloud_firestore/cloud_firestore.dart';

class Etherums {
  final String metamaskid;
  final double amount;
  const Etherums({
    required this.metamaskid,
    required this.amount,
  });
  Map<String, dynamic> toJson() => {
        'metamaskid': metamaskid,
        'amount': amount,
      };
}
