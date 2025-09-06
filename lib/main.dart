library hauberk.app;

// Responsive Design
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:project_redline/dimensions/dimensions.dart';
import 'package:project_redline/multi_platform/multi_platform.dart';

// Firebase
import 'package:json_annotation/json_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:firebase_ui_auth/firebase_ui_auth.dart';

// Google Sheets API
import 'package:googleapis/sheets/v4.dart' as gsheets;
import 'package:googleapis/drive/v3.dart' as drive;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis_auth/auth_browser.dart';
import 'package:http/http.dart' as http;

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

part './views/auth_guard.dart';
part './views/dashboard.dart';
part './views/transactions.dart';
part './views/budgeting.dart';
part './views/assistant.dart';
part './views/profile.dart';

part './forms/add_transaction_form.dart';
part './forms/add_account_form.dart';
part './forms/recurring_cashflows_form.dart';
part './forms/create_monthly_budget_form.dart';
part './forms/add_budgeted_event_form.dart';
part './forms/split_payment_form.dart';
part './forms/add_goal_form.dart';
part './forms/link_gsheet_form.dart';
part './forms/link_revolut_form.dart';

part './api_endpoints/hauberk_api.dart';

part './objects/transaction.dart';
part './objects/user_data.dart';
part './objects/account.dart';
part './objects/profile.dart';
part './objects/tag.dart';
part './objects/recurrent_cashflow.dart';
part './objects/budgeted_event.dart';
part './objects/monthly_budget.dart';
part './objects/goal.dart';

part './utils/utils.dart';

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
  firestore = kDebugMode
      ? (FirebaseFirestore.instance..useFirestoreEmulator('127.0.0.1', 8080))
      : FirebaseFirestore.instance;
  if (kDebugMode) {
    await FirebaseAuth.instance.useAuthEmulator('127.0.0.1', 8081);
  }
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
