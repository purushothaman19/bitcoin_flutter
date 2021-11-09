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
const apiKey = '8BB602D9-DA55-4212-B9D7-D49022427262';

class CoinData {

  Future getCoinData(String selectedCurrency) async {
    //TODO 4: Use a for loop here to loop through the cryptoList and request the data for each of them in turn.
    Map<String, String> results = {};

    for (String crypto in cryptoList) {
      String requestURL = '$coinAPIURL/$crypto/$selectedCurrency?apikey=$apiKey';

      Uri uri = Uri.parse(requestURL);
      print("Url: $uri");

      http.Response response = await http.get(uri);
      if (response.statusCode == 200) {
        print("StatusCode: ${response.statusCode}");
        var decodedData = jsonDecode(response.body);

        var lastPrice = decodedData['rate'];

        results['$crypto'] = lastPrice.toStringAsFixed(0);

      } else {
        print(response.statusCode);
        throw 'Problem with the get request';
      }
    }
    //TODO 5: Return a Map of the results instead of a single value.
    return results;
  }

}
