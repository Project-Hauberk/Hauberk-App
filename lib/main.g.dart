// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Transaction _$TransactionFromJson(Map<String, dynamic> json) => Transaction(
      description: json['description'] as String,
      tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
      amount: (json['amount'] as num).toDouble(),
      fromAccount:
          Account.fromJson(json['fromAccount'] as Map<String, dynamic>),
      toAccount: Account.fromJson(json['toAccount'] as Map<String, dynamic>),
      txnType: $enumDecode(_$TxnTypeEnumMap, json['txnType']),
      timestamp: DateTime.parse(json['timestamp'] as String),
    );

Map<String, dynamic> _$TransactionToJson(Transaction instance) =>
    <String, dynamic>{
      'description': instance.description,
      'timestamp': instance.timestamp.toIso8601String(),
      'amount': instance.amount,
      'fromAccount': instance.fromAccount,
      'toAccount': instance.toAccount,
      'txnType': _$TxnTypeEnumMap[instance.txnType]!,
      'tags': instance.tags,
    };

const _$TxnTypeEnumMap = {
  TxnType.inflow: 'inflow',
  TxnType.outflow: 'outflow',
  TxnType.transfer: 'transfer',
};

Account _$AccountFromJson(Map<String, dynamic> json) => Account(
      name: json['name'] as String,
    );

Map<String, dynamic> _$AccountToJson(Account instance) => <String, dynamic>{
      'name': instance.name,
    };
