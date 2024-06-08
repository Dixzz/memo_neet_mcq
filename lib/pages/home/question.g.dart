// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Question _$QuestionFromJson(Map<String, dynamic> json) => Question(
      json['text'] as String,
      Map<String, bool>.from(json['choic'] as Map),
    );

Map<String, dynamic> _$QuestionToJson(Question instance) => <String, dynamic>{
      'text': instance.text,
      'choic': instance.choic,
    };
