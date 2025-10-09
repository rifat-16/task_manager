class Urls{
  static const String _baseUrl = 'http://35.73.30.144:2005/api/v1';
  static const String registrationUrl = '$_baseUrl/Registration';
  static const String loginUrl = '$_baseUrl/Login';
  static const String addTaskUrl = '$_baseUrl/createTask';
  static const String taskStatusCountUrl = '$_baseUrl/TaskStatusCount';
  static const String newTaskUrl = '$_baseUrl/listTaskByStatus/New';
  static const String inProgressTaskUrl = '$_baseUrl/listTaskByStatus/In Progress';
  static const String completedTaskUrl = '$_baseUrl/listTaskByStatus/Completed';
  static const String cancelledTaskUrl = '$_baseUrl/listTaskByStatus/Cancelled';


  static String updateTaskStatusUrl(String id, String status) =>
      '$_baseUrl/updateTaskStatus/$id/$status';
  static String deleteTaskUrl(String id) => '$_baseUrl/deleteTask/$id';
}