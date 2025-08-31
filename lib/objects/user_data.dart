part of 'package:hauberk/main.dart';

@JsonSerializable()
class UserData {
  final String name;
  final List<String> accountIds;

  const UserData({
    required this.name,
    required this.accountIds,
  });

  factory UserData.fromJson(Map<String, dynamic> json) =>
      _$UserDataFromJson(json);

  Map<String, dynamic> toJson() => _$UserDataToJson(this);
}
