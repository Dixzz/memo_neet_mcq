import 'package:focus_test/pages/home/question.dart'
    show DurationMillisConverter;
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  // final String email;
  final String? lastAnsQuesRef;
  @DurationMillisConverter()
  final Duration? duration;

  @JsonKey(defaultValue: 0)
  final num streak;

  @JsonKey(defaultValue: 0)
  final num correctAns;

  @JsonKey(defaultValue: 0)
  final num totalAns;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  User(
      [this.lastAnsQuesRef,
      this.duration,
      this.streak = 0,
      this.correctAns = 0,
      this.totalAns = 0]);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
