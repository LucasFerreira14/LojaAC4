import 'package:app_ac4/shared/themes/colors/app_colors.dart';
import 'package:flutter/material.dart';

class Credits extends StatelessWidget {
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
                child:
                    Icon(Icons.person, color: AppColors.grayishBlue, size: 30),
              ),
              Text('Equipe',
                  style: TextStyle(
                      color: AppColors.grayishBlue,
                      fontWeight: FontWeight.bold,
                      fontSize: 25)),
            ],
          ),
        ),
        body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Daniel Branco de Oliveira Mendes',
                    style: TextStyle(color: AppColors.fontColor, fontSize: 25),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Juan da Silva Damasceno',
                    style: TextStyle(color: AppColors.fontColor, fontSize: 25),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Lucas Almeida Fernandes de Morais',
                    style: TextStyle(color: AppColors.fontColor, fontSize: 25),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Lucas Ferreira da Silva',
                    style: TextStyle(color: AppColors.fontColor, fontSize: 25),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Mateus da Silva Lima',
                    style: TextStyle(color: AppColors.fontColor, fontSize: 25),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Rafael da Cruz Quatis',
                    style: TextStyle(color: AppColors.fontColor, fontSize: 25),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Vinicius de Souza Moraes',
                    style: TextStyle(color: AppColors.fontColor, fontSize: 25),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            )));
  }
}
