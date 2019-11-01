import 'package:flutter/material.dart';

class MyTabbedApp1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tabbed Demo 1',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyFirstTabbedPage(),
    );
  }
}

class MyFirstTabbedPage extends StatefulWidget {
  @override
  _MyFirstTabbedPageState createState() => _MyFirstTabbedPageState();
}

class _MyFirstTabbedPageState extends State<MyFirstTabbedPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.directions_car)),
              Tab(icon: Icon(Icons.directions_transit)),
              Tab(icon: Icon(Icons.directions_bike)),
            ],
          ),
          title: Text('Tabs Demo'),
        ),
        body: TabBarView(
          children: [
            Icon(Icons.directions_car),
            Icon(Icons.directions_transit),
            Icon(Icons.directions_bike),
          ],
        ),
      ),
    );
  }
}
