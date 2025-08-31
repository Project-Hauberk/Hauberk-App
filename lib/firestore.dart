part of 'package:hauberk/main.dart';

late final FirebaseApp app;
late final FirebaseFirestore firestore;

typedef JSON = Map<String, Object?>;

abstract class Storable {
  Storable.fromJson(JSON json);
  JSON toJson();
}

final DocumentReference<Profile> profileDoc = firestore
    .collection('users')
    .withConverter(
      fromFirestore: (snapshot, _) => Profile.fromJson(
          snapshot.data() ?? (throw Exception('Null profile map'))),
      toFirestore: (obj, _) => obj.toJson(),
    )
    .doc(FirebaseAuth.instance.currentUser!.uid);

final CollectionReference<UserData> usersColl =
    firestore.collection('users').withConverter<UserData>(
          fromFirestore: (snapshot, _) => UserData.fromJson(
              snapshot.data() ?? (throw Exception('Null user map'))),
          toFirestore: (obj, _) => obj.toJson(),
        );

final CollectionReference<Account> accountsColl = firestore
    .collection('users')
    .doc(FirebaseAuth.instance.currentUser!.uid)
    .collection('accounts')
    .withConverter<Account>(
      fromFirestore: (snapshot, _) => Account.fromJson(
          snapshot.data() ?? (throw Exception('Null account map'))),
      toFirestore: (obj, _) => obj.toJson(),
    );
final CollectionReference<Account> externalAccountsColl = firestore
    .collection('users')
    .doc(FirebaseAuth.instance.currentUser!.uid)
    .collection('external_accounts')
    .withConverter<Account>(
      fromFirestore: (snapshot, _) => Account.fromJson(
          snapshot.data() ?? (throw Exception('Null account map'))),
      toFirestore: (obj, _) => obj.toJson(),
    );

final CollectionReference<Tag> tagsColl = firestore
    .collection('users')
    .doc(FirebaseAuth.instance.currentUser!.uid)
    .collection('tags')
    .withConverter<Tag>(
      fromFirestore: (snapshot, _) =>
          Tag.fromJson(snapshot.data() ?? (throw Exception('Null tag map'))),
      toFirestore: (obj, _) => obj.toJson(),
    );

final CollectionReference<Transaction> txnsColl = firestore
    .collection('users')
    .doc(FirebaseAuth.instance.currentUser!.uid)
    .collection('transactions')
    .withConverter<Transaction>(
      fromFirestore: (snapshot, _) => Transaction.fromJson(
          snapshot.data() ?? (throw Exception('Null txn map'))),
      toFirestore: (obj, _) => obj.toJson(),
    );

final CollectionReference<RecurrentCashflow> recurrentCashflowsColl = firestore
    .collection('users')
    .doc(FirebaseAuth.instance.currentUser!.uid)
    .collection('recurrent_cashflows')
    .withConverter<RecurrentCashflow>(
      fromFirestore: (snapshot, _) => RecurrentCashflow.fromJson(
          snapshot.data() ?? (throw Exception('Null recurrent cashflow map'))),
      toFirestore: (obj, _) => obj.toJson(),
    );

final CollectionReference<BudgetedEvent> budgetedEventsColl = firestore
    .collection('users')
    .doc(FirebaseAuth.instance.currentUser!.uid)
    .collection('budgeted_events')
    .withConverter<BudgetedEvent>(
      fromFirestore: (snapshot, _) => BudgetedEvent.fromJson(
          snapshot.data() ?? (throw Exception('Null budgeted event map'))),
      toFirestore: (obj, _) => obj.toJson(),
    );

final CollectionReference<MonthlyBudget> monthlyBudgetsColl = firestore
    .collection('users')
    .doc(FirebaseAuth.instance.currentUser!.uid)
    .collection('budgets')
    .withConverter<MonthlyBudget>(
      fromFirestore: (snapshot, _) => MonthlyBudget.fromJson(
          snapshot.data() ?? (throw Exception('Null monthly budget map'))),
      toFirestore: (obj, _) => obj.toJson(),
    );

final CollectionReference<Goal> goalsColl = firestore
    .collection('users')
    .doc(FirebaseAuth.instance.currentUser!.uid)
    .collection('goals')
    .withConverter<Goal>(
      fromFirestore: (snapshot, _) =>
          Goal.fromJson(snapshot.data() ?? (throw Exception('Null goal map'))),
      toFirestore: (obj, _) => obj.toJson(),
    );
