import 'package:app_ac4/shared/themes/colors/app_colors.dart';
import 'package:flutter/material.dart';

import '../home/main_page.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);
  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            iconTheme: IconThemeData(color: Colors.black, size: 100),
            title: Text(
              'Detalhes',
              style: TextStyle(
                  color: AppColors.grayishBlue,
                  fontWeight: FontWeight.bold,
                  fontSize: 23),
            )),
        body: Container());
  }
}
