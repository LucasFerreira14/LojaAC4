import 'package:app_ac4/modules/cart/cart_page.dart';
import 'package:app_ac4/modules/favorite/fav_page.dart';
import 'package:app_ac4/modules/home/home_controller.dart';
import 'package:app_ac4/modules/home/main_page.dart';
import 'package:app_ac4/modules/search_page/search_page.dart';
import 'package:app_ac4/shared/model/favorites/favorites.dart';
import 'package:app_ac4/shared/model/favorites/favorites_db.dart';
import 'package:app_ac4/shared/model/itens/cart.dart';
import 'package:app_ac4/shared/model/itens/cart_db.dart';
import 'package:app_ac4/shared/themes/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async' as async;
import 'dart:convert';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late List<Favorites> favorites;
  late List<CartItens> cartItens;
  List _selecao = [];
  bool isLoading = true;

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
      isLoading = false;
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

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  void initState() {
    super.initState();
    refreshConfigs();
    WidgetsBinding.instance!.addPostFrameCallback((_) => _showAllItens());
  }

  Future refreshConfigs() async {
    cartItens = await CartItensDB.instance.readAllItens();

    favorites = await SavedFavoritesDB.instance.readAllItens();
    isLoading = false;
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
                    decoration: BoxDecoration(color: Color(0xFF1C1F28)),
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
              title: Text(
                'Nossos Produtos',
                style: TextStyle(
                    color: AppColors.grayishBlue,
                    fontWeight: FontWeight.bold,
                    fontSize: 23),
              ),
            ),
            body: cards(),
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
                      botao(Icon(Icons.home), 0, true, Home()),
                      botao(Icon(Icons.search), 1, false, SearchPage()),
                      botao(Icon(Icons.favorite), 2, false, FavPage()),
                      botao(Icon(Icons.shopping_cart), 3, false, CartPage()),
                    ]),
              ),
            )));
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
