import 'package:flutter/material.dart';

Widget navegation() => BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.home)),
        BottomNavigationBarItem(icon: Icon(Icons.favorite)),
        BottomNavigationBarItem(icon: Icon(Icons.manage_accounts)),
      ],
    );
