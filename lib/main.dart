library hauberk.app;

import 'dart:math';
import 'dart:ui';

import 'package:project_redline/dimensions/dimensions.dart';
import 'package:project_redline/multi_platform/multi_platform.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hauberk/secrets.dart';

part 'main.g.dart';
part './firestore.dart';

part './design_system/colors.dart';
part './design_system/navbar.dart';
part './design_system/type_system.dart';
part './design_system/view_scaffold.dart';
part './design_system/table.dart';
part './design_system/limited_list.dart';
part './design_system/buttons/wide_button.dart';
part './design_system/buttons/navbar_button.dart';
part './design_system/buttons/chip_button.dart';
part './design_system/cards/txn_card.dart';

part './views/dashboard.dart';
part './views/transactions.dart';
part './views/budgeting.dart';
part './views/assistant.dart';
part './views/profile.dart';

part './forms/add_transaction_form.dart';
part './forms/add_account_form.dart';
part './forms/recurring_cashflows_form.dart';
part './forms/split_payment_form.dart';

part './objects/transaction.dart';
part './objects/user.dart';
part './objects/account.dart';
part './objects/profile.dart';
part './objects/tag.dart';
part './objects/recurrent_cashflow.dart';

part './utils/utils.dart';

late final String userId = 'testuser';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();

  Multiplatform.init(
    platformSelector: (width, height) {
      if (360 < width && width < 550 && 600 < height && height < 990) {
        return const MobilePlatform();
      } else {
        throw UnimplementedError(
            'Non-mobile screens ($width, $height) are not supported yet.');
      }
    },
    baseStyle: const TextStyle(),
  );

  app = await Firebase.initializeApp(options: webOptions);
  firestore = FirebaseFirestore.instance
    ..useFirestoreEmulator('127.0.0.1', 8080);
  runApp(const HauberkApp());
}

class HauberkApp extends StatelessWidget {
  const HauberkApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/dashboard',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        bottomSheetTheme: const BottomSheetThemeData(
          surfaceTintColor: Colors.transparent,
          backgroundColor: Colors.transparent,
        ),
      ),
      routes: {
        '/dashboard': (_) => const DashboardView(),
        '/transactions': (_) => const TransactionsView(),
        '/budgeting': (_) => const BudgetingView(),
        '/assistant': (_) => const AssistantView(),
        '/profile': (_) => const ProfileView(),
      },
    );
  }
}
