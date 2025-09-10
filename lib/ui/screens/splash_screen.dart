import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../utils/asset_paths.dart';
import '../widgets/screen_background.dart';
import 'login_screen.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _movetoNextScreen();
  }


  Future<void> _movetoNextScreen() async{
    await Future.delayed(const Duration(seconds: 3));
    Navigator.pushReplacement(context,
      MaterialPageRoute(builder: (__) =>  LoginScreen(),),);
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundScreen(
      child: Center(
        child: SvgPicture.asset(AssetPaths.logoSvg,),
      ),
    );
  }
}


