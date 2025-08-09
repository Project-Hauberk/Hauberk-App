part of 'package:hauberk/main.dart';

@JsonSerializable()
class Goal {
  final String name;
  final int deadline;
  final double target;

  const Goal({
    required this.name,
    required this.deadline,
    required this.target,
  });

  factory Goal.fromJson(Map<String, dynamic> json) => _$GoalFromJson(json);

  Map<String, dynamic> toJson() => _$GoalToJson(this);
}
