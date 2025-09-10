import 'package:flutter/material.dart';

class TmAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TmAppBar({
    super.key,
  });
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.green,
      title: Row(
          spacing: 8,
          children: [
            CircleAvatar(),
            SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Rifat hasan',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text('mirefat82@gmail.com',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            )
          ]
      ),
    );
  }
}