import 'package:flutter/material.dart';

import '../screens/update_profile_screen.dart';

class TmAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TmAppBar({super.key, this.fromUpdateProfile});

  final bool? fromUpdateProfile;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.green,
      title: GestureDetector(
        onTap: (){
          if(fromUpdateProfile == true){
            return;
          }
          Navigator.push(context, MaterialPageRoute(builder: (context)=> UpdateProfileScreen()));
        },
        child: Row(
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
      ),
    );
  }
}