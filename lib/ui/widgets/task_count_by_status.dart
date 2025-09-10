
import 'package:flutter/material.dart';

class TaskCoundByStatus extends StatelessWidget {
  const TaskCoundByStatus({super.key,
    required this.title,
    required this.count,
  });

  final String title;
  final String count;

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 0,
        color: Colors.white,
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Column(
                children: [
                  Text('$count',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Text('$title',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ]
            )
        )
    );
  }
}