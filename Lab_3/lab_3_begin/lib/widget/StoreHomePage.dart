import 'package:coffee_store_app/widget/DrinksCarousel.dart';
import 'package:coffee_store_app/widget/DrinksList.dart';
import 'package:flutter/material.dart';

class MyAppLab3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lab3 App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: StoreHomePage(title: 'Store Home'),
    );
  }
}

class StoreHomePage extends StatelessWidget {
  final String title;

  const StoreHomePage({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue,
      appBar: AppBar(
        title: Text(title),
      ),
      body: Column(
        children: <Widget>[
          DrinksCarousel(),
          DrinksList(),
        ],
      ),
    );
  }
}
