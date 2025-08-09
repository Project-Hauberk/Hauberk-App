part of 'package:hauberk/main.dart';

@JsonSerializable()
class Account {
  final String name;
  final double balance;
  final String ownerId;

  const Account({
    required this.name,
    required this.balance,
    required this.ownerId,
  });

  factory Account.fromJson(Map<String, dynamic> json) =>
      _$AccountFromJson(json);

  Map<String, dynamic> toJson() => _$AccountToJson(this);

  @override
  bool operator ==(Object other) =>
      other is Account &&
      other.name == name &&
      other.balance == balance &&
      other.ownerId == ownerId;

  @override
  int get hashCode => "$name$balance$ownerId".hashCode;
}
