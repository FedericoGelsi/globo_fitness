import 'package:globo_fitness/data/weather.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class HttpHelper{
  final String apikey = '0ca603efe41751df3b408cd13218e35d';
  final String authority = 'api.openweathermap.org';
  final String path = 'data/2.5/weather';

  Future<Weather> getWeather(String location) async {
    Map<String, dynamic> parameters = {'q': location, 'appid': apikey};
    Uri uri = Uri.https(authority, path, parameters);
    http.Response result = await http.get(uri);
    Map<String,dynamic> data = json.decode(result.body);
    Weather weather = Weather.fromJson(data);
    return weather;
  }

}