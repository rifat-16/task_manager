class TaskModel{

  final String title;
  final String description;
  final String status;
  final String email;
  final String createdDate;
  final String id;

  TaskModel({
    required this.title,
    required this.description,
    required this.status,
    required this.email,
    required this.createdDate,
    required this.id,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['_id'],
      title: json['title']??'',
      description: json['description'],
      status: json['status'],
      email: json['email'],
      createdDate: json['createdDate'],
    );
  }
}