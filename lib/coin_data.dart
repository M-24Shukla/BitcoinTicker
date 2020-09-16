import 'dart:convert';
import 'package:http/http.dart' as http;

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

const coinAPIURL = 'https://rest.coinapi.io/v1/exchangerate';
const apiKey = '46D0169F-0475-4DFE-956B-D9104CFA3048';

class CoinData {
  var prices = new Map();
  Future<Map> getCoinData(String selectedCurrency) async {
    for (var crypt in cryptoList) {
      String requestURL = '$coinAPIURL/$crypt/$selectedCurrency?apikey=$apiKey';
      http.Response response = await http.get(requestURL);
      if (response.statusCode == 200) {
        var decodedData = jsonDecode(response.body);
        var lastPrice = decodedData['rate'];
        prices.addAll({crypt: lastPrice});
      } else {
        print(response.statusCode);
        throw 'Problem with the get request';
      }
    }
    return prices;
  }
}