import 'package:app_ac4/main-page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async' as async;
import 'dart:convert';

class home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<home> {
  List _selecao = [];

  Future<dynamic> _showAll() async {
    http.Response response =
        await http.get("https://aw-loja-api.herokuapp.com/produtos/");
    List<dynamic> retorno = json.decode(response.body);

    return retorno;
  }

  Future<dynamic> _filter(item, filtro) async {
    http.Response response =
        await http.get("https://aw-loja-api.herokuapp.com/produtos/");
    List<dynamic> retorno = json.decode(response.body);

    List _resultado = retorno.where((i) => i[item] == filtro).toList();

    return _resultado;
  }

  void _showAllItens() async {
    List _allItens = await _showAll();

    setState(() {
      _selecao = _allItens;
    });
  }

  void _roupasDeHomem() async {
    List _roupasHomem = await _filter("categoria", "masculino");

    for (var produto in _roupasHomem) {
      print(produto["id"]);
    }

    setState(() {
      _selecao = _roupasHomem;
    });

    Navigator.pop(context);
  }

  void _roupasDeMulher() async {
    List _roupasMulher = await _filter("categoria", "feminino");

    for (var produto in _roupasMulher) {
      print(produto["id"]);
    }

    setState(() {
      _selecao = _roupasMulher;
    });

    Navigator.pop(context);
  }

  void _listaDeJoias() async {
    List _listaJoias = await _filter("categoria", "infantil");

    for (var produto in _listaJoias) {
      print(produto["id"]);
    }

    setState(() {
      _selecao = _listaJoias;
    });

    Navigator.pop(context);
  }

  final _scaffoldKey = new GlobalKey<ScaffoldState>();

  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) => _showAllItens());
  }

  List<Widget> _createChildren() {
    return List<Widget>.generate(_selecao.length, (int index) {
      return Text(_selecao[index].toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                const DrawerHeader(
                  decoration: BoxDecoration(color: Colors.black),
                  padding: EdgeInsets.only(top: 60),
                  child: Text(
                    "Nasa Store",
                    style: TextStyle(color: Colors.white, fontSize: 28),
                    textAlign: TextAlign.center,
                  ),
                ),
                ListTile(
                  title: const Text(
                    "Para Homens",
                    style: TextStyle(color: Colors.black, fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                  onTap: () {
                    _roupasDeHomem();
                  },
                ),
                ListTile(
                  title: const Text(
                    "Para Mulheres",
                    style: TextStyle(color: Colors.black, fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                  onTap: () {
                    _roupasDeMulher();
                  },
                ),
                ListTile(
                  title: const Text(
                    "Para Crianças",
                    style: TextStyle(color: Colors.black, fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                  onTap: () {
                    _listaDeJoias();
                  },
                )
              ],
            ),
          ),
          key: _scaffoldKey,
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.menu, size: 30),
              onPressed: () => _scaffoldKey.currentState!.openDrawer(),
            ),
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            iconTheme: IconThemeData(color: Colors.black, size: 100),
          ),
          body: SingleChildScrollView(
              child: Column(children: <Widget>[
            for (var item in _selecao) Itens(item: item)
          ]))),
    );
  }
}
