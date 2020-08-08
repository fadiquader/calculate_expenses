import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

class Transaction {
  final String id = Uuid().v4();
  final String title;
  final double amount;
  final DateTime date;

  Transaction({
    @required this.title,
    @required this.amount,
    @required this.date,
  });
}
