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

    setState(() {
      _selecao = _allItens;
      isLoading = false;
    });
  }

  @override
  void initState() {
    isLoading = true;
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) => _showAllItens());
    isLoading = false;
  }

  @override
  TextEditingController _fieldController = TextEditingController();

  void search() async {
    isLoading = true;
    lista = [];
    setState(() {
      lookingFor = _fieldController.text;
    });

    for (var item in _selecao) {
      if (Itens.utf8convert(item["nome"].toUpperCase())
          .contains(lookingFor!.toUpperCase())) {
        lista.add(item);
      }
    }

    if (lookingFor == '') {
      lista = [];
    }

    isLoading = false;
  }

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
        body: SingleChildScrollView(
          child: Column(
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
                            controller: _fieldController,
                            // onChanged: (lookingFor) => setState(
                            //     () => this.lookingFor = lookingFor)
                          )),
                    ),
                    IconButton(
                      onPressed: () async {
                        search();
                      },
                      icon: Icon((Icons.search), color: AppColors.orange),
                    ),
                  ],
                ),
              ),
              SingleChildScrollView(
                child: isLoading
                    ? CircularProgressIndicator(color: AppColors.orange)
                    : lista.isEmpty
                        ? Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Center(
                              child: Text(
                                'Não encontrei nada :/',
                                style: TextStyle(color: AppColors.fontColor),
                              ),
                            ),
                          )
                        : Column(
                            children: [
                              cards(),
                            ],
                          ),
              )
            ],
          ),
        ),
        bottomNavigationBar: NavButton(
          active: [false, true, false, false],
        ));
  }

  Widget cards() => Center(
        child: isLoading
            ? CircularProgressIndicator(color: AppColors.orange)
            : SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    for (var item in lista) Itens(item: item),
                  ],
                ),
              ),
      );
}
