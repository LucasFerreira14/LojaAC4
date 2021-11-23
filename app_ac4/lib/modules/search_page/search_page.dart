import 'dart:convert';

import 'package:app_ac4/modules/home/main_page.dart';
import 'package:app_ac4/shared/themes/colors/app_colors.dart';
import 'package:app_ac4/shared/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async' as async;
import 'dart:convert' show utf8;

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);
  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  bool isLoading = true;
  List _selecao = [];
  num total = 0;
  late String? lookingFor;
  List lista = [];

  Future<dynamic> _showAll() async {
    http.Response response =
        await http.get("https://aw-loja-api.herokuapp.com/produtos/");
    List<dynamic> retorno = json.decode(response.body);

    return retorno;
  }

  void _showAllItens() async {
    List _allItens = await _showAll();
  }

  @override
  void initState() {
    isLoading = true;
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) => _showAllItens());
    isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            iconTheme: IconThemeData(color: Colors.black, size: 100),
            title: Text(
              'Pesquisar itens',
              style: TextStyle(
                  color: AppColors.grayishBlue,
                  fontWeight: FontWeight.bold,
                  fontSize: 23),
            )),
        body: Column(
          children: [
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                        width: size.width * 0.7,
                        child: TextField(
                            onChanged: (lookingFor) =>
                                setState(() => this.lookingFor = lookingFor))),
                  ),
                  IconButton(
                    onPressed: () {
                      for (var item in _selecao) {
                        if (Itens.utf8convert(item["nome"])
                            .contains(lookingFor!)) {
                          lista.add(item);
                        }
                      }
                      print(lista);
                    },
                    icon: Icon((Icons.search), color: AppColors.orange),
                  ),
                ],
              ),
            )
          ],
        ),
        bottomNavigationBar: NavButton(
          active: [false, true, false, false],
        ));
  }
}
