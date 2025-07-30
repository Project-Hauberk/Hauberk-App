part of 'package:hauberk/main.dart';

@JsonSerializable()
class Tag {
  final String label;

  const Tag({
    required this.label,
  });

  factory Tag.fromJson(Map<String, dynamic> json) => _$TagFromJson(json);

  Map<String, dynamic> toJson() => _$TagToJson(this);
}
