// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'habit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Habit _$HabitFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['id', 'name'],
  );
  return Habit(
    id: json['id'] as String,
    name: json['name'] as String,
    description: json['description'] as String? ?? '',
    completionDates: (json['completionDates'] as List<dynamic>?)
        ?.map((e) => DateTime.parse(e as String))
        .toList(),
  );
}

Map<String, dynamic> _$HabitToJson(Habit instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'completionDates':
          instance.completionDates.map((e) => e.toIso8601String()).toList(),
    };
