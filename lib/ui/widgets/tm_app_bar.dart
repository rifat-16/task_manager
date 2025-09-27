import 'package:flutter/material.dart';

import '../controller/auth_cotroller.dart';
import '../screens/login_screen.dart';
import '../screens/update_profile_screen.dart';

class TmAppBar extends StatefulWidget implements PreferredSizeWidget {
  const TmAppBar({super.key, this.fromUpdateProfile});

  final bool? fromUpdateProfile;

  @override
  State<TmAppBar> createState() => _TmAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _TmAppBarState extends State<TmAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.green,
      title: GestureDetector(
        onTap: (){
          if(widget.fromUpdateProfile == true){
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
                  Text(AuthController.userModel?.fullName?? '',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(AuthController.userModel?.email?? '',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              )
            ]
        ),
      ),
      actions: [IconButton(onPressed: _onTabLogoutButton, icon: Icon(Icons.logout_outlined))],
    );
  }

  Future<void> _onTabLogoutButton() async {
    await AuthController.clearUserData();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (__) => LoginScreen()),
      (route) => false,
    );

  }
}