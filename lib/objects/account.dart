part of 'package:hauberk/main.dart';

@JsonSerializable()
class Account {
  final String name;
  final double balance;

  const Account({
    required this.name,
    required this.balance,
  });

  factory Account.fromJson(Map<String, dynamic> json) =>
      _$AccountFromJson(json);

  Map<String, dynamic> toJson() => _$AccountToJson(this);
}
