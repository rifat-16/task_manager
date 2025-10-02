class TaskList{

  final String title;
  final String description;
  final String status;
  final String email;
  final String createdDate;

  TaskList({
    required this.title,
    required this.description,
    required this.status,
    required this.email,
    required this.createdDate});

  factory TaskList.fromJson(Map<String, dynamic> json) {
    return TaskList(
      title: json['title'],
      description: json['description'],
      status: json['status'],
      email: json['email'],
      createdDate: json['createdDate'],
    );
  }




}