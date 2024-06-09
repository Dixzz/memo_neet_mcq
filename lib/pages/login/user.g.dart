// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      json['email'] as String,
      json['lastAnsQuesRef'] as String?,
      _$JsonConverterFromJson<Timestamp, DateTime>(
          json['duration'], const TimestampDatetimeConverter().fromJson),
      json['streak'] as num? ?? 0,
      json['correctAns'] as num? ?? 0,
      json['totalAns'] as num? ?? 0,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'email': instance.email,
      'lastAnsQuesRef': instance.lastAnsQuesRef,
      'duration': _$JsonConverterToJson<Timestamp, DateTime>(
          instance.duration, const TimestampDatetimeConverter().toJson),
      'streak': instance.streak,
      'correctAns': instance.correctAns,
      'totalAns': instance.totalAns,
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);
