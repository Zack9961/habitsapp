class Habit {
  final String id; // Identificatore unico per l'abitudine
  final String name; // Nome dell'abitudine
  final String? description; // Descrizione dell'abitudine
  final List<DateTime>
      completionDates; // Date in cui l'abitudine è stata completata

  const Habit({
    required this.id,
    required this.name,
    this.description,
    List<DateTime>? completionDates,
  }) : completionDates = completionDates ?? const [];
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