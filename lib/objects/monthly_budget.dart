part of 'package:hauberk/main.dart';

@JsonSerializable()
class MonthlyBudget {
  final String name;
  final List<String> recurrentCashflowIds;
  final Map<String, double> savingsContributions;
  final List<String> budgetedEventIds;

  const MonthlyBudget({
    required this.name,
    required this.recurrentCashflowIds,
    required this.savingsContributions,
    required this.budgetedEventIds,
  });

  factory MonthlyBudget.fromJson(Map<String, dynamic> json) =>
      _$MonthlyBudgetFromJson(json);

  Map<String, dynamic> toJson() => _$MonthlyBudgetToJson(this);
}
