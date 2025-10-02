class TaskStatusCount {
  final String status;
  final int count;

  TaskStatusCount({required this.status, required this.count});

  factory TaskStatusCount.fromJson(Map<String, dynamic> json) {
    return TaskStatusCount(
      status: json['_id'] ?? 'Unknown',  // Null hole default 'Unknown'
      count: json['sum'] ?? 0,          // Null hole 0
    );
  }
}