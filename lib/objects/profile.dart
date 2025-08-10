part of 'package:hauberk/main.dart';

@JsonSerializable()
class Profile {
  final String displayName;
  final String? linkedGoogleSheet;

  const Profile({
    required this.displayName,
    required this.linkedGoogleSheet,
  });

  factory Profile.fromJson(Map<String, dynamic> json) =>
      _$ProfileFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileToJson(this);
}
