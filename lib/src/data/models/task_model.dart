class TaskModel {
  final String id;
  final String title;
  final String description;
  final DateTime date;
  final String category;
  final bool isCompleted;
  final String startTime;
  final String endTime;

  TaskModel({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.category,
    required this.isCompleted,
    required this.startTime,
    required this.endTime,
  });

  TaskModel copyWith({bool? isCompleted}) {
    return TaskModel(
      id: id,
      title: title,
      description: description,
      date: date,
      category: category,
      isCompleted: isCompleted ?? this.isCompleted,
      startTime: startTime,
      endTime: endTime,
    );
  }
}
