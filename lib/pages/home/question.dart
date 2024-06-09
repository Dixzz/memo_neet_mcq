import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'question.g.dart';

class TimestampDatetimeConverter implements JsonConverter<DateTime, Timestamp> {
  const TimestampDatetimeConverter();

  @override
  DateTime fromJson(json) => json.toDate();

  @override
  Timestamp toJson(DateTime date) => Timestamp.fromDate(date);
}

class DurationMillisConverter implements JsonConverter<Duration, int> {
  const DurationMillisConverter();

  @override
  Duration fromJson(json) => Duration(milliseconds: json);

  @override
  int toJson(Duration object) => object.inMilliseconds;
}

@JsonSerializable()
class Question {
  /// doc ref
  @JsonKey(includeFromJson: true, includeToJson: false)
  final String id;

  /// meeting duration, to be showed as 1h or 30m
  /// [AddEventController.duration]
  // @DurationMillisConverter()
  // final Duration duration;

  /// [AddEventController.meeting]
  // @TimestampDatetimeConverter()
  // final DateTime meeting;

  final String text;
  final Map<String, bool> choic;
  factory Question.fromJson(Map<String, dynamic> json) => _$QuestionFromJson(json);

  Question(this.text, this.choic, this.id);

  Map<String, dynamic> toJson() => _$QuestionToJson(this);

}
