import 'dart:async';
import 'package:flutter/material.dart';
import 'stock_list.dart';
import 'stock.dart';
import 'stock_service.dart';

void main() => runApp(new MyAppLab4());

class MyAppLab4 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Stock Price Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'Lab4-Stock Price App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _stockList = new List<Stock>();
  String _stockSymbol = "";
  StockService _stockService = StockService();

  @override
  initState() {
    super.initState();
  }

  Future<Null> _inputStock() async {
    await showDialog<String>(
        context: context,
        builder: (BuildContext context) {
          return new AlertDialog(
            title: const Text('Input Stock Ticker Symbol'),
            contentPadding: EdgeInsets.all(5.0),
            content: new TextField(
              decoration: new InputDecoration(hintText: "Ticker Symbol"),
              onChanged: (String value) {
                _stockSymbol = value;
              },
            ),
            actions: <Widget>[
              new FlatButton(
                child: new Text("Ok"),
                onPressed: () async {
                  if (_stockSymbol.isNotEmpty) {
                    //TODO: get the stock data with _stockService.getQuote
                    //then dig out the symbol, companyName, and latestPrice
                    //then rapped in a setState create a new object of Stock
                    //and add it to _stockList
                    var stockData = await _stockService.getQuote(_stockSymbol);

                    var symbol = '';

                    print(stockData);
                    
                    if (stockData == null) {
                      symbol =
                          "Previous call to getQuote failed to return the stock data";
                    } else 
                    {                       
                      symbol = stockData['symbol'];
                      var name = stockData['companyName'];
                      var price = stockData['latestPrice'];
                      Stock stock = Stock(symbol, name, price);

                      _stockList.add(stock);
                    
                    }
                    setState(() {
                      print(symbol);
                    });
                  }
                  _stockSymbol = "";
                  Navigator.pop(context);
                  
                },
              ),
              new FlatButton(
                child: new Text("Cancel"),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new Container(
        child: new Center(
          child: new StockList(stocks: _stockList),
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: () => _inputStock(),
        tooltip: 'Add',
        child: new Icon(Icons.add),
      ),
    );
  }
}
