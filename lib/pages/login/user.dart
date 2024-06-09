import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:focus_test/pages/home/question.dart'
    show TimestampDatetimeConverter;
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  final String email;
  String? lastAnsQuesRef;
  @TimestampDatetimeConverter()
  DateTime? duration;

  num streak;

  num correctAns;

  num totalAns;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  User(this.email,
      [this.lastAnsQuesRef,
      this.duration,
      this.streak = 0,
      this.correctAns = 0,
      this.totalAns = 0]);

  Map<String, dynamic> toJson() => _$UserToJson(this);

// User copyWith(
//         {String? lastAnsQuesRef,
//         DateTime? duration,
//         num? streak,
//         num? correctAns,
//         num? totalAns}) =>
//     User(
//         email,
//         lastAnsQuesRef ?? this.lastAnsQuesRef,
//         duration ?? this.duration,
//         streak ?? this.streak,
//         correctAns ?? this.correctAns,
//         totalAns ?? this.totalAns);
}
