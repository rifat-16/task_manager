

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../utils/asset_paths.dart';

class BackgroundScreen extends StatelessWidget {
  const BackgroundScreen({
    super.key,
    required this.child,
  });

  final child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SvgPicture.asset(AssetPaths.backgroundSvg,
          fit: BoxFit.cover,
          height: double.maxFinite,
          width: double.maxFinite,
        ),
        SafeArea(child: child,)
      ],
    );
  }
}