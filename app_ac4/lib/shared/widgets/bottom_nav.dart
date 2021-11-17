import 'package:app_ac4/shared/themes/colors/app_colors.dart';
import 'package:flutter/material.dart';

class BottomNav extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        decoration: BoxDecoration(
            color: AppColors.grayishBlue,
            borderRadius: BorderRadius.circular(15)),
        height: 60,
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          IconButton(
              onPressed: () {},
              icon: Icon(Icons.home),
              color: AppColors.orange),
          IconButton(
              onPressed: () {},
              icon: Icon(Icons.search),
              color: AppColors.lightGrayishBlue),
          IconButton(
              onPressed: () {},
              icon: Icon(Icons.favorite),
              color: AppColors.lightGrayishBlue),
          IconButton(
              onPressed: () {},
              icon: Icon(Icons.shopping_cart),
              color: AppColors.lightGrayishBlue),
        ]),
      ),
    );
  }
}
