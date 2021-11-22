import 'package:app_ac4/shared/model/favorites/favorites.dart';
import 'package:app_ac4/shared/model/favorites/favorites_db.dart';
import 'package:app_ac4/shared/themes/colors/app_colors.dart';
import 'package:flutter/material.dart';

import '../home/main_page.dart';

class FavPage extends StatefulWidget {
  const FavPage({Key? key}) : super(key: key);
  @override
  State<FavPage> createState() => _FavPageState();
}

class _FavPageState extends State<FavPage> {
  late List<Favorites> favorites;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    refreshConfigs();
  }

  @override
  Future refreshConfigs() async {
    favorites = await SavedFavoritesDB.instance.readAllItens();
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
                ? Container(child: Text('Tem item salvo'))
                : Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Text('Nenhum item salvo.',
                            style: TextStyle(color: AppColors.fontColor))
                      ],
                    ),
                  ));
  }
}
