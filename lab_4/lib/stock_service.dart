import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

const apiToken = 'Tpk_27e2aa9354b742e4aac4092f8d2b7f59';

class StockService {
  Future getQuote(String symbol) async {
    String url =
        "https://sandbox.iexapis.com/stable/stock/${symbol}/quote/?token=$apiToken";
    http.Response response = await http.get(url);
    if(response.statusCode == 200)
    {
      String data = response.body;
      return jsonDecode(data);
    }
    else
    {
        print(response.statusCode);
        print(response.body);
    }
    
    //TODO: use jsonDecode to decode the response.body that is returned from http.get
    //TODO: then return the decoded json to the calling method as a Future
  }
}
