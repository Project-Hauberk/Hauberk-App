part of 'package:hauberk/main.dart';

@JsonSerializable()
class Profile {
  final String displayName;

  const Profile({
    required this.displayName,
  });

  factory Profile.fromJson(Map<String, dynamic> json) =>
      _$ProfileFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileToJson(this);
}
