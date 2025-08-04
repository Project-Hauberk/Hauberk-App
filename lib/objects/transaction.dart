part of 'package:hauberk/main.dart';

enum TxnType {
  @JsonValue('inflow')
  inflow,
  @JsonValue('outflow')
  outflow,
  @JsonValue('transfer')
  transfer;
}

@JsonSerializable()
class Transaction {
  final String? description;
  final double timestamp;
  final double amount;
  final String? fromAccountId;
  final String? toAccountId;
  final TxnType txnType;
  final List<String> tags;

  const Transaction({
    required this.description,
    required this.tags,
    required this.amount,
    required this.fromAccountId,
    required this.toAccountId,
    required this.txnType,
    required this.timestamp,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) =>
      _$TransactionFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionToJson(this);
}
