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

  Future<dynamic> _filter(item, filtro) async {
    http.Response response =
        await http.get("https://fakestoreapi.com/products");
    List<dynamic> retorno = json.decode(response.body);

    List _resultado = retorno.where((i) => i[item] == filtro).toList();

    return _resultado;
  }

  void _roupasDeHomem() async {
    List _roupasHomem = await _filter("category", "men's clothing");

    for (var produto in _roupasHomem) {
      print(produto["id"]);
    }

    setState(() {
      _selecao = _roupasHomem;
    });

    Navigator.pop(context);
  }

  void _roupasDeMulher() async {
    List _roupasMulher = await _filter("category", "women's clothing");

    for (var produto in _roupasMulher) {
      print(produto["id"]);
    }

    setState(() {
      _selecao = _roupasMulher;
    });

    Navigator.pop(context);
  }

  void _listaDeJoias() async {
    List _listaJoias = await _filter("category", "jewelery");

    for (var produto in _listaJoias) {
      print(produto["id"]);
    }

    setState(() {
      _selecao = _listaJoias;
    });

    Navigator.pop(context);
  }

  final _scaffoldKey = new GlobalKey<ScaffoldState>();

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
                    "Joias",
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
              child: Stack(children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Image.network(_selecao[1]["image"])
                // for (var item in _selecao)
                //   Padding(
                //     padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                //     child: Text(item["title"]),
                //   ),
                // for (var item in _selecao)
                //   Padding(
                //     padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                //     // child: Image.network(item["image"]),
                //   )
              ],
            )
          ]))),
    );
  }
}
