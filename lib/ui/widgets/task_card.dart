import 'package:flutter/material.dart';

class TaskCard extends StatelessWidget {
   TaskCard({super.key, required this.status, required this.color});

  final String status;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: ListTile(
        tileColor: Colors.white,
        title: Text('Title of Task',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Description of Task'),
            Text('Date of Task',
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
            Row(
              children: [
                Chip(label: Text(status,
                  style: TextStyle(
                    color: Colors.white,
                  )
                ),
                  padding: EdgeInsets.symmetric(horizontal: 20,vertical: 0),
                  backgroundColor: color,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40)
                  ),
                ),
                Spacer(),
                Icon(Icons.edit,color: Colors.blue,),
                SizedBox(width: 10,),
                Icon(Icons.delete,color: Colors.red,)
              ],
            )
          ],

        ),

      ),
    );
  }
}



