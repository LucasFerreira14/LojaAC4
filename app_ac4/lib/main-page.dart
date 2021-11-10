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
            height: size.height * 0.6,
            width: size.width * 0.75,
            color: Colors.grey,
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
                  style: TextStyle(fontSize: 20),
                  textAlign: TextAlign.center,
                ),
                Padding(padding: EdgeInsets.only(bottom: 20)),
                Text(
                  "R\$ " + (widget.item["preco"]).toString(),
                  style: TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
