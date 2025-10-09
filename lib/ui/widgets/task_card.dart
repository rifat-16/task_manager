import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:task_manger/ui/widgets/snack_bar_message.dart';
import '../../data/models/task_model.dart';
import '../../data/services/api_caller.dart';
import '../../data/utils/urls.dart';

class TaskCard extends StatefulWidget {
  TaskCard({
    super.key,
    required this.status,
    required this.color,
    required this.title,
    required this.description,
    required this.createDate,
    required this.taskModel,
    required this.refreshParent,
  });

  String status;
  final Color color;
  final String title;
  final String description;
  final String createDate;
  final TaskModel taskModel;
  final VoidCallback refreshParent;

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  late final String formattedDate;
  late String currentStatus;
  bool _changeStatusInProgress = false;

  @override
  void initState() {
    super.initState();
    formattedDate = DateFormat('dd MMM yyyy, hh:mm a')
        .format(DateTime.parse(widget.createDate));
    currentStatus = widget.status;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: ListTile(
        tileColor: Colors.white,
        title: Text(
          widget.title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.description),
            Text(
              'Created Date: $formattedDate',
              style: const TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
            Row(
              children: [
                Chip(
                  label: Text(
                    currentStatus,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                  backgroundColor: widget.color,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40),
                  ),
                ),
                const Spacer(),
                _changeStatusInProgress
                    ? const SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
                    : IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: _showChangeStatusDialog,
                  color: Colors.blue,
                ),
                IconButton(
                  onPressed: _deleteTask,
                  icon: const Icon(Icons.delete),
                  color: Colors.red,
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  void _showChangeStatusDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Change Status'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: ['New', 'In Progress', 'Completed', 'Cancelled']
                .map(
                  (status) => ListTile(
                title: Text(status),
                trailing: currentStatus == status
                    ? const Icon(Icons.check, color: Colors.green)
                    : null,
                onTap: () {
                  if (!_changeStatusInProgress &&
                      status != widget.taskModel.status) {
                    _changeStatus(status);
                  }
                  Navigator.pop(context);
                },
              ),
            )
                .toList(),
          ),
        );
      },
    );
  }

  Future<void> _changeStatus(String status) async {
    _changeStatusInProgress = true;
    setState(() {});

    final ApiResponse response = await ApiCaller.getRequest(
      url: Urls.updateTaskStatusUrl(widget.taskModel.id, status),
    );

    _changeStatusInProgress = false;
    setState(() {});

    if (response.isSuccess) {
      currentStatus = status; // update UI instantly
      widget.refreshParent();
    } else {
      showSnackBarMessage(context, response.errorMessage!, true);
    }
  }

  Future<void> _deleteTask() async {
    _changeStatusInProgress = true;
    setState(() {});
    final ApiResponse response = await ApiCaller.getRequest(
      url: Urls.deleteTaskUrl(widget.taskModel.id),
    );
    _changeStatusInProgress = false;
    setState(() {});
    if (response.isSuccess) {
      widget.refreshParent();
    }
    else {
      showSnackBarMessage(context, response.errorMessage!, true);
    }
  }
}