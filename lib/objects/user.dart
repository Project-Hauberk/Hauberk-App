part of 'package:hauberk/main.dart';

@JsonSerializable()
class User {
  final String name;
  final List<String> accountIds;

  const User({
    required this.name,
    required this.accountIds,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
