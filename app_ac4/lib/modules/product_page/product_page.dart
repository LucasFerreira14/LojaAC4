import 'package:app_ac4/shared/themes/colors/app_colors.dart';
import 'package:app_ac4/shared/widgets/bottom_nav.dart';
import 'package:flutter/material.dart';

import '../home/main_page.dart';

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
            title: Text(
              'Detalhes',
              style: TextStyle(
                  color: AppColors.grayishBlue,
                  fontWeight: FontWeight.bold,
                  fontSize: 23),
            )),
        body: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Stack(
                    children: [
                      Container(
                          height: 280, width: 400, color: AppColors.background),
                      Center(
                        child: Container(
                          height: 280,
                          width: 230,
                          child: Image.network(
                            widget.item["imagem"],
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(Itens.utf8convert(widget.item["nome"]),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                  Text(Itens.utf8convert(widget.item["descricao"]),
                      textAlign: TextAlign.center,
                      style: TextStyle(color: AppColors.fontColor)),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    style: ButtonStyle(
                      padding:
                          MaterialStateProperty.all(const EdgeInsets.all(15)),
                      backgroundColor:
                          MaterialStateProperty.all(AppColors.orange),
                    ),
                    onPressed: () {},
                    child: Text(
                        'Adicionar ao carrinho: ' +
                            "R\$ " +
                            (widget.item["preco"]).toString(),
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side:
                          BorderSide(color: AppColors.grayishBlue, width: 2.0),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                    ),
                    child: Icon(Icons.favorite, color: AppColors.grayishBlue),
                    onPressed: () {},
                  ),
                ],
              )
            ],
          ),
        ),
        bottomNavigationBar: BottomNav());
  }
}
