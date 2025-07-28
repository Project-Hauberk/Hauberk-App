part of 'package:hauberk/main.dart';

@JsonSerializable()
class Account {
  final String name;

  const Account({required this.name});

  factory Account.fromJson(Map<String, dynamic> json) =>
      _$AccountFromJson(json);

  Map<String, dynamic> toJson() => _$AccountToJson(this);
}
