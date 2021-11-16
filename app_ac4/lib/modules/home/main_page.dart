import 'package:app_ac4/shared/themes/colors/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'dart:convert' show utf8;
import 'package:flutter/material.dart';

class Itens extends StatefulWidget {
  final Map item;

  const Itens({Key? key, required this.item}) : super(key: key);

  @override
  _ItensState createState() => _ItensState();

  static String utf8convert(String text) {
    List<int> bytes = text.toString().codeUnits;
    return utf8.decode(bytes);
  }
}

class _ItensState extends State<Itens> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {},
      child: Center(
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
                    onPressed: () {},
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
