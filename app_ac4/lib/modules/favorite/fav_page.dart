import 'dart:convert';

import 'package:app_ac4/modules/cart/cart_page.dart';
import 'package:app_ac4/modules/home/home.dart';
import 'package:app_ac4/modules/search_page/search_page.dart';
import 'package:app_ac4/shared/model/favorites/favorites.dart';
import 'package:app_ac4/shared/model/favorites/favorites_db.dart';
import 'package:app_ac4/shared/themes/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async' as async;

import '../home/main_page.dart';

class FavPage extends StatefulWidget {
  const FavPage({Key? key}) : super(key: key);
  @override
  State<FavPage> createState() => _FavPageState();
}

class _FavPageState extends State<FavPage> {
  late List<Favorites> favorites;
  bool isLoading = false;
  List _selecao = [];

  Future<dynamic> _showAll() async {
    http.Response response =
        await http.get("https://aw-loja-api.herokuapp.com/produtos/");
    List<dynamic> retorno = json.decode(response.body);

    return retorno;
  }

  void _showAllItens() async {
    List _allItens = await _showAll();
    List lista = [];

    for (var element in favorites) {
      for (var item in _allItens) {
        if (element.idProduto == item['id']) {
          lista.add(item);
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
    favorites = await SavedFavoritesDB.instance.readAllItens();
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
                child: Icon(Icons.favorite,
                    color: AppColors.grayishBlue, size: 30),
              ),
              Text('Favoritos',
                  style: TextStyle(
                      color: AppColors.grayishBlue,
                      fontWeight: FontWeight.bold,
                      fontSize: 25)),
            ],
          ),
        ),
        body: isLoading
            ? Center(child: CircularProgressIndicator(color: AppColors.orange))
            : favorites.isEmpty
                ? Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Text('Nenhum item salvo.',
                            style: TextStyle(color: AppColors.fontColor))
                      ],
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Text('Tem item salvo',
                              style: TextStyle(color: AppColors.fontColor)),
                          cards()
                        ],
                      ),
                    )),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            decoration: BoxDecoration(
                color: AppColors.grayishBlue,
                borderRadius: BorderRadius.circular(15)),
            height: 60,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  botao(Icon(Icons.home), 0, false, Home()),
                  botao(Icon(Icons.search), 1, false, SearchPage()),
                  botao(Icon(Icons.favorite), 2, true, FavPage()),
                  botao(Icon(Icons.shopping_cart), 3, false, CartPage()),
                ]),
          ),
        ));
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

  Widget cards() => Center(
        child: isLoading
            ? CircularProgressIndicator(color: AppColors.orange)
            : SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    for (var item in _selecao) Itens(item: item),
                  ],
                ),
              ),
      );
}
