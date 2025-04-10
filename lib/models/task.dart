class Task {
  final String id;
  final String title;
  final String? description;
  final bool completed;

  Task({
    required this.id,
    required this.title,
    this.description,
    required this.completed
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      title: json['attributes']['title'],
      description: json['attributes']['description'],
      completed: json['attributes']['completed']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'completed': completed
    };
  }
}