part of 'package:hauberk/main.dart';

@JsonSerializable()
class Profile {
  final String displayName;
  final String? linkedGoogleSheet;
  final List<String> savingsAccountIds;

  const Profile({
    required this.displayName,
    required this.linkedGoogleSheet,
    required this.savingsAccountIds,
  });

  factory Profile.fromJson(Map<String, dynamic> json) =>
      _$ProfileFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileToJson(this);
}
