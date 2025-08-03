// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Transaction _$TransactionFromJson(Map<String, dynamic> json) => Transaction(
      description: json['description'] as String,
      tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
      amount: (json['amount'] as num).toDouble(),
      fromAccountId: json['fromAccountId'] as String,
      toAccountId: json['toAccountId'] as String,
      txnType: $enumDecode(_$TxnTypeEnumMap, json['txnType']),
      timestamp: DateTime.parse(json['timestamp'] as String),
    );

Map<String, dynamic> _$TransactionToJson(Transaction instance) =>
    <String, dynamic>{
      'description': instance.description,
      'timestamp': instance.timestamp.toIso8601String(),
      'amount': instance.amount,
      'fromAccountId': instance.fromAccountId,
      'toAccountId': instance.toAccountId,
      'txnType': _$TxnTypeEnumMap[instance.txnType]!,
      'tags': instance.tags,
    };

const _$TxnTypeEnumMap = {
  TxnType.inflow: 'inflow',
  TxnType.outflow: 'outflow',
  TxnType.transfer: 'transfer',
};

User _$UserFromJson(Map<String, dynamic> json) => User(
      name: json['name'] as String,
      accountIds: (json['accountIds'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'name': instance.name,
      'accountIds': instance.accountIds,
    };

Account _$AccountFromJson(Map<String, dynamic> json) => Account(
      name: json['name'] as String,
      balance: (json['balance'] as num).toDouble(),
      ownerId: json['ownerId'] as String,
    );

Map<String, dynamic> _$AccountToJson(Account instance) => <String, dynamic>{
      'name': instance.name,
      'balance': instance.balance,
      'ownerId': instance.ownerId,
    };

Profile _$ProfileFromJson(Map<String, dynamic> json) => Profile(
      displayName: json['displayName'] as String,
    );

Map<String, dynamic> _$ProfileToJson(Profile instance) => <String, dynamic>{
      'displayName': instance.displayName,
    };

Tag _$TagFromJson(Map<String, dynamic> json) => Tag(
      label: json['label'] as String,
    );

Map<String, dynamic> _$TagToJson(Tag instance) => <String, dynamic>{
      'label': instance.label,
    };
