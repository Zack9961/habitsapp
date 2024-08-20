class Habit {
  final int id; // Identificatore unico per l'abitudine
  final String name; // Nome dell'abitudine
  final String description; // Descrizione dell'abitudine
  //final bool isCompleted; // Stato di completamento dell'abitudine
  final List<DateTime>
      completionDates; // Date in cui l'abitudine è stata completata

  Habit({
    required this.id,
    required this.name,
    required this.description,
    //this.isCompleted = false,
    List<DateTime>? completionDates,
  }) : completionDates = completionDates ?? [];
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