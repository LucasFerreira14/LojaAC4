import 'package:app_ac4/modules/cart/cart_page.dart';
import 'package:app_ac4/modules/favorite/fav_page.dart';
import 'package:app_ac4/modules/home/home.dart';
import 'package:app_ac4/modules/search_page/search_page.dart';
import 'package:app_ac4/shared/themes/colors/app_colors.dart';
import 'package:flutter/material.dart';

class NavButton extends StatefulWidget {
  final List? item;
  final List active;

  const NavButton({Key? key, this.item, required this.active})
      : super(key: key);
  @override
  State<NavButton> createState() => _NavButtonState();
}

class _NavButtonState extends State<NavButton> {
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
          botao(Icon(Icons.home), 0, widget.active[0], Home()),
          botao(Icon(Icons.search), 1, widget.active[1], SearchPage()),
          botao(Icon(Icons.favorite), 2, widget.active[2],
              FavPage(item: widget.item)),
          botao(Icon(Icons.shopping_cart), 3, widget.active[3], CartPage()),
        ]),
      ),
    );
  }

  Widget botao(icone, index, ativo, page) {
    return ativo
        ? IconButton(onPressed: () {}, icon: icone, color: AppColors.orange)
        : IconButton(
            onPressed: () {
              setState(() {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => page),
                );
              });
            },
            icon: icone,
            color: AppColors.lightGrayishBlue);
  }
}
