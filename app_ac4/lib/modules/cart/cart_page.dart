import 'dart:convert';

import 'package:app_ac4/modules/favorite/fav_page.dart';
import 'package:app_ac4/modules/home/home.dart';
import 'package:app_ac4/modules/product_page/product_page.dart';
import 'package:app_ac4/modules/search_page/search_page.dart';
import 'package:app_ac4/shared/model/itens/cart.dart';
import 'package:app_ac4/shared/model/itens/cart_db.dart';
import 'package:app_ac4/shared/themes/colors/app_colors.dart';
import 'package:app_ac4/shared/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' show utf8;
import 'dart:async' as async;

import '../home/main_page.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);
  @override
  State<CartPage> createState() => _CartPageState();

  static String utf8convert(String text) {
    List<int> bytes = text.toString().codeUnits;
    return utf8.decode(bytes);
  }
}

class _CartPageState extends State<CartPage> {
  late List<CartItens> cartItens;
  bool isLoading = true;
  List _selecao = [];
  num total = 0;

  Future<dynamic> _showAll() async {
    http.Response response =
        await http.get("https://aw-loja-api.herokuapp.com/produtos/");
    List<dynamic> retorno = json.decode(response.body);

    return retorno;
  }

  void _showAllItens() async {
    isLoading = true;
    List _allItens = await _showAll();
    List lista = [];

    for (var element in cartItens) {
      for (var item in _allItens) {
        if (element.idProduto == item['id']) {
          lista.add(item);
          setState(() {
            total = total + item['preco'];
          });
        }
      }
    }

    setState(() {
      _selecao = lista;
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) => _showAllItens());
    refreshConfigs();
  }

  Future refreshConfigs() async {
    setState(() => isLoading = true);
    cartItens = await CartItensDB.instance.readAllItens();
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          iconTheme: IconThemeData(color: Colors.black, size: 100),
          title: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.shopping_cart,
                    color: AppColors.grayishBlue, size: 30),
              ),
              Text('Itens no carrinho',
                  style: TextStyle(
                      color: AppColors.grayishBlue,
                      fontWeight: FontWeight.bold,
                      fontSize: 25)),
            ],
          ),
        ),
        body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: isLoading
                ? Center(
                    child: CircularProgressIndicator(color: AppColors.orange))
                : cartItens.isEmpty
                    ? Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Parece que você não tem itens no carrinho!',
                              style: TextStyle(color: AppColors.fontColor),
                            ),
                          ),
                          Text(
                            'Veja os nossos produtos e comece as compras =)',
                            style: TextStyle(color: AppColors.fontColor),
                          )
                        ],
                      )
                    : Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Total: ${total}',
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.grayishBlue)),
                              ElevatedButton(
                                style: ButtonStyle(
                                  padding: MaterialStateProperty.all(
                                      const EdgeInsets.all(15)),
                                  backgroundColor: MaterialStateProperty.all(
                                      AppColors.orange),
                                ),
                                onPressed: () {
                                  _showMyDialog();
                                },
                                child: Text('Pagar'),
                              ),
                            ],
                          ),
                          cards(),
                        ],
                      )),
        bottomNavigationBar: NavButton(active: [false, false, false, true]));
  }

  Widget cards() => Center(
        child: isLoading
            ? CircularProgressIndicator(color: AppColors.orange)
            : SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    for (var item in _selecao)
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProductPage(
                                        item: item,
                                      )));
                        },
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
                                      offset: const Offset(
                                          1, 2), // changes position of shadow
                                    ),
                                  ],
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(18)),
                              height: 150,
                              width: 500,
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                        padding: EdgeInsets.only(bottom: 20)),
                                    Text(
                                      Itens.utf8convert(item["nome"]),
                                      style: TextStyle(
                                          fontSize: 15, color: AppColors.azul),
                                      textAlign: TextAlign.center,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "R\$ " + (item["preco"]).toString(),
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: AppColors.orange,
                                              fontWeight: FontWeight.bold),
                                          textAlign: TextAlign.end,
                                        ),
                                        TextButton(
                                          onPressed: () async {
                                            var id = item['id'];
                                            await CartItensDB.instance
                                                .delete(id);
                                            refreshConfigs();
                                          },
                                          child: Text('Remover',
                                              style: TextStyle(
                                                  color: AppColors.fontColor)),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                  ],
                ),
              ),
      );
  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Isso aê!!!'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  'Agora é só esperar, estamos analisando o seu pedido!',
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Finalizar',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              onPressed: () {
                Navigator.of(context).pop();
                for (var item in _selecao) {
                  CartItensDB.instance.delete(item['id']);
                }
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => Home()));
              },
            ),
          ],
        );
      },
    );
  }
}
