library hauberk.app;

import 'dart:math';

import 'package:json_annotation/json_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hauberk/secrets.dart';

part 'main.g.dart';
part './firestore.dart';

part './design_system/navbar.dart';

part './views/transactions.dart';
part './views/dashboard.dart';

part './objects/transaction.dart';
part './objects/user.dart';
part './objects/account.dart';

part './utils/utils.dart';

late final String userId = 'testuser';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  app = await Firebase.initializeApp(options: webOptions);
  firestore = FirebaseFirestore.instance
    ..useFirestoreEmulator('127.0.0.1', 8087);
  runApp(const HauberkApp());
}

class HauberkApp extends StatelessWidget {
  const HauberkApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/dashboard',
      routes: {
        '/dashboard': (_) => const DashboardView(),
        '/transactions': (_) => const TransactionsView(),
      },
    );
  }
}
