// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Transaction _$TransactionFromJson(Map<String, dynamic> json) => Transaction(
      description: json['description'] as String?,
      tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
      amount: (json['amount'] as num).toDouble(),
      fromAccountId: json['fromAccountId'] as String?,
      toAccountId: json['toAccountId'] as String?,
      txnType: $enumDecode(_$TxnTypeEnumMap, json['txnType']),
      timestamp: (json['timestamp'] as num).toDouble(),
      budgetedEventId: json['budgetedEventId'] as String?,
    );

Map<String, dynamic> _$TransactionToJson(Transaction instance) =>
    <String, dynamic>{
      'description': instance.description,
      'timestamp': instance.timestamp,
      'amount': instance.amount,
      'fromAccountId': instance.fromAccountId,
      'toAccountId': instance.toAccountId,
      'txnType': _$TxnTypeEnumMap[instance.txnType]!,
      'tags': instance.tags,
      'budgetedEventId': instance.budgetedEventId,
    };

const _$TxnTypeEnumMap = {
  TxnType.inflow: 'inflow',
  TxnType.outflow: 'outflow',
  TxnType.transfer: 'transfer',
};

UserData _$UserDataFromJson(Map<String, dynamic> json) => UserData(
      name: json['name'] as String,
      accountIds: (json['accountIds'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$UserDataToJson(UserData instance) => <String, dynamic>{
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
      linkedGoogleSheet: json['linkedGoogleSheet'] as String?,
      savingsAccountIds: (json['savingsAccountIds'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$ProfileToJson(Profile instance) => <String, dynamic>{
      'displayName': instance.displayName,
      'linkedGoogleSheet': instance.linkedGoogleSheet,
      'savingsAccountIds': instance.savingsAccountIds,
    };

Tag _$TagFromJson(Map<String, dynamic> json) => Tag(
      label: json['label'] as String,
    );

Map<String, dynamic> _$TagToJson(Tag instance) => <String, dynamic>{
      'label': instance.label,
    };

RecurrentCashflow _$RecurrentCashflowFromJson(Map<String, dynamic> json) =>
    RecurrentCashflow(
      name: json['name'] as String,
      amount: (json['amount'] as num).toDouble(),
      cashflowType: $enumDecode(_$CashflowTypeEnumMap, json['cashflowType']),
      frequency: $enumDecode(_$RecurrenceFrequencyEnumMap, json['frequency']),
      wefDate: (json['wefDate'] as num).toInt(),
      color: json['color'] as String,
    );

Map<String, dynamic> _$RecurrentCashflowToJson(RecurrentCashflow instance) =>
    <String, dynamic>{
      'name': instance.name,
      'amount': instance.amount,
      'cashflowType': _$CashflowTypeEnumMap[instance.cashflowType]!,
      'frequency': _$RecurrenceFrequencyEnumMap[instance.frequency]!,
      'wefDate': instance.wefDate,
      'color': instance.color,
    };

const _$CashflowTypeEnumMap = {
  CashflowType.inflow: 'inflow',
  CashflowType.outflow: 'outflow',
};

const _$RecurrenceFrequencyEnumMap = {
  RecurrenceFrequency.daily: 'daily',
  RecurrenceFrequency.weekly: 'weekly',
  RecurrenceFrequency.biweekly: 'biweekly',
  RecurrenceFrequency.monthly: 'monthly',
  RecurrenceFrequency.yearly: 'yearly',
};

BudgetedEvent _$BudgetedEventFromJson(Map<String, dynamic> json) =>
    BudgetedEvent(
      name: json['name'] as String,
      amount: (json['amount'] as num).toDouble(),
      date: (json['date'] as num).toInt(),
      tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$BudgetedEventToJson(BudgetedEvent instance) =>
    <String, dynamic>{
      'name': instance.name,
      'amount': instance.amount,
      'date': instance.date,
      'tags': instance.tags,
    };

MonthlyBudget _$MonthlyBudgetFromJson(Map<String, dynamic> json) =>
    MonthlyBudget(
      name: json['name'] as String,
      recurrentCashflowIds: (json['recurrentCashflowIds'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      savingsContributions:
          (json['savingsContributions'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, (e as num).toDouble()),
      ),
      budgetedEventIds: (json['budgetedEventIds'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      start: (json['start'] as num).toInt(),
      end: (json['end'] as num).toInt(),
    );

Map<String, dynamic> _$MonthlyBudgetToJson(MonthlyBudget instance) =>
    <String, dynamic>{
      'name': instance.name,
      'recurrentCashflowIds': instance.recurrentCashflowIds,
      'savingsContributions': instance.savingsContributions,
      'budgetedEventIds': instance.budgetedEventIds,
      'start': instance.start,
      'end': instance.end,
    };

Goal _$GoalFromJson(Map<String, dynamic> json) => Goal(
      name: json['name'] as String,
      deadline: (json['deadline'] as num).toInt(),
      target: (json['target'] as num).toDouble(),
    );

Map<String, dynamic> _$GoalToJson(Goal instance) => <String, dynamic>{
      'name': instance.name,
      'deadline': instance.deadline,
      'target': instance.target,
    };
