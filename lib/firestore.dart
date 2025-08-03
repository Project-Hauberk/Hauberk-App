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
    .doc(userId);

final CollectionReference<User> usersColl = firestore
    .collection('users')
    .withConverter<User>(
      fromFirestore: (snapshot, _) =>
          User.fromJson(snapshot.data() ?? (throw Exception('Null user map'))),
      toFirestore: (obj, _) => obj.toJson(),
    );

final CollectionReference<Account> accountsColl = firestore
    .collection('users')
    .doc(userId)
    .collection('accounts')
    .withConverter<Account>(
      fromFirestore: (snapshot, _) => Account.fromJson(
          snapshot.data() ?? (throw Exception('Null account map'))),
      toFirestore: (obj, _) => obj.toJson(),
    );

final CollectionReference<Tag> tagsColl = firestore
    .collection('users')
    .doc(userId)
    .collection('tags')
    .withConverter<Tag>(
      fromFirestore: (snapshot, _) =>
          Tag.fromJson(snapshot.data() ?? (throw Exception('Null tag map'))),
      toFirestore: (obj, _) => obj.toJson(),
    );

final CollectionReference<Transaction> txnsColl = firestore
    .collection('users')
    .doc(userId)
    .collection('transactions')
    .withConverter<Transaction>(
      fromFirestore: (snapshot, _) => Transaction.fromJson(
          snapshot.data() ?? (throw Exception('Null txn map'))),
      toFirestore: (obj, _) => obj.toJson(),
    );
