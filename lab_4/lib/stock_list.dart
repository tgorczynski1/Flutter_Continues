import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'stock.dart';

class StockList extends StatefulWidget {
  StockList({Key key, this.stocks}) : super(key: key);

  final List<Stock> stocks;

  @override
  State<StatefulWidget> createState() {
    return new _StockListState();
  }
}

class _StockListState extends State<StockList> {
  @override
  Widget build(BuildContext context) {
    return _buildStockList(context, widget.stocks);
  }

  ListView _buildStockList(context, List<Stock> stocks) {
    return new ListView.builder(
      itemCount: stocks.length,
      itemBuilder: (context, index) {
        return ListTile(
          //TODO:  use title, subtitle, and trailing to display the stock symbol
          // companyName and latestPrice
          title: Text('Symbol: ${stocks[index].symbol}'),
          subtitle: Text('Name ${stocks[index].name}'),
          trailing: Text('Price ${stocks[index].price}'),          
        );
      },
    );
  }
}
