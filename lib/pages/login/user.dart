import 'package:focus_test/pages/home/question.dart'
    show DurationMillisConverter;
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  final String email;
  String? id;
  @DurationMillisConverter()
  final Duration? duration;

  final num streak;
  final num correctAns;
  final num totalAns;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  User(this.email, [this.duration, this.streak = 0, this.correctAns = 0, this.totalAns = 0]);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
