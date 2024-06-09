import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> main() async {
  final d1 = DateTime.now();
  final d2 = d1.subtract(const Duration(days: 2));
  print(d1.toLocal());
  print(d2.toLocal());
  print(d1.difference(d2).inDays);
}
