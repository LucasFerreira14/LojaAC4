import 'package:app_ac4/shared/themes/colors/app_colors.dart';
import 'package:flutter/material.dart';

import 'main_page.dart';

class ProductPage extends StatefulWidget {
  final Map item;

  const ProductPage({Key? key, required this.item}) : super(key: key);
  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.black, size: 100),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    spreadRadius: 1,
                    blurRadius: 1,
                    offset: const Offset(1, 2), // changes position of shadow
                  ),
                ],
                color: AppColors.background,
                borderRadius: BorderRadius.circular(18)),
            height: size.height * 0.6,
            width: size.width * 0.85,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  IconButton(
                    padding: EdgeInsets.fromLTRB(10, 10, 0, 10),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ProductPage(item: widget.item)));
                    },
                    icon: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      height: 250,
                      width: 200,
                      child: Image.network(
                        widget.item["imagem"],
                        fit: BoxFit.fill,
                      ),
                    ),
                    iconSize: 250,
                  ),
                  Padding(padding: EdgeInsets.only(bottom: 20)),
                  Text(
                    Itens.utf8convert(widget.item["nome"]),
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  Padding(padding: EdgeInsets.only(bottom: 20)),
                  Text(
                    "R\$ " + (widget.item["preco"]).toString(),
                    style: TextStyle(
                        fontSize: 18,
                        color: AppColors.orange,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
