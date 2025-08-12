part of 'package:hauberk/main.dart';

@JsonSerializable()
class BudgetedEvent {
  final String name;
  final double amount;
  final int date;
  final List<String> tags;

  const BudgetedEvent({
    required this.name,
    required this.amount,
    required this.date,
    required this.tags,
  });

  factory BudgetedEvent.fromJson(Map<String, dynamic> json) =>
      _$BudgetedEventFromJson(json);

  Map<String, dynamic> toJson() => _$BudgetedEventToJson(this);

  @override
  bool operator ==(Object other) =>
      other is BudgetedEvent &&
      other.name == name &&
      other.amount == amount &&
      other.date == date &&
      other.tags == tags;

  @override
  int get hashCode => "$name$amount$date$tags".hashCode;
}
