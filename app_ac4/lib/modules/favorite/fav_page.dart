import 'dart:convert';
import 'package:app_ac4/shared/model/favorites/favorites.dart';
import 'package:app_ac4/shared/model/favorites/favorites_db.dart';
import 'package:app_ac4/shared/themes/colors/app_colors.dart';
import 'package:app_ac4/shared/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async' as async;

import '../home/main_page.dart';

class FavPage extends StatefulWidget {
  final List? item;
  const FavPage({Key? key, this.item}) : super(key: key);
  @override
  State<FavPage> createState() => _FavPageState();
}

class _FavPageState extends State<FavPage> {
  late List<Favorites> favorites;
  bool isLoading = false;
  List _selecao = [];

  void showAllItens() async {
    List? _allItens = widget.item;
    List lista = [];

    for (var element in favorites) {
      for (var item in _allItens!) {
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
    refreshConfigs();
  }

  Future refreshConfigs() async {
    setState(() => isLoading = true);
    favorites = await SavedFavoritesDB.instance.readAllItens();
    showAllItens();
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
        bottomNavigationBar: NavButton(active: [false, false, true, false]));
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
