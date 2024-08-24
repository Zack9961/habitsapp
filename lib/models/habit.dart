import 'package:json_annotation/json_annotation.dart';
part 'habit.g.dart';

@JsonSerializable()
class Habit {
  @JsonKey(required: true)
  final String id; // Identificatore unico per l'abitudine
  @JsonKey(required: true)
  final String name; // Nome dell'abitudine
  final String description; // Descrizione dell'abitudine
  final List<DateTime>
      completionDates; // Date in cui l'abitudine è stata completata

  const Habit({
    required this.id,
    required this.name,
    this.description = '',
    List<DateTime>? completionDates,
  }) : completionDates = completionDates ?? const [];

  factory Habit.fromJson(Map<String, dynamic> json) => _$HabitFromJson(json);

  Map<String, dynamic> toJson() => _$HabitToJson(this);
}

/*
Habit({
    required this.id,
    required this.name,
    required this.description,
    //this.isCompleted = false,
    List<DateTime>? completionDates,
  }) : completionDates = completionDates ?? [];
  */