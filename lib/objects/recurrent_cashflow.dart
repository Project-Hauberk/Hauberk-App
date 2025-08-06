part of 'package:hauberk/main.dart';

enum CashflowType { inflow, outflow }

enum RecurrenceFrequency { daily, weekly, biweekly, monthly, yearly }

@JsonSerializable()
class RecurrentCashflow {
  final String name;
  final double amount;
  final CashflowType cashflowType;
  final RecurrenceFrequency frequency;
  final int wefDate;
  final String color;

  const RecurrentCashflow({
    required this.name,
    required this.amount,
    required this.cashflowType,
    required this.frequency,
    required this.wefDate,
    required this.color,
  });

  factory RecurrentCashflow.fromJson(Map<String, dynamic> json) =>
      _$RecurrentCashflowFromJson(json);

  Map<String, dynamic> toJson() => _$RecurrentCashflowToJson(this);
}
