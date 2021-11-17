import 'package:app_ac4/shared/themes/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 1,
        child: Container(
          color: AppColors.grayishBlue,
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Container(child: Image.asset('assets/nasaLogo.png')),
          ),
        ));
  }
}
