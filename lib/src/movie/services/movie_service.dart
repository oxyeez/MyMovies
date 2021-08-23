import 'dart:convert';

import 'package:angular/angular.dart';
import 'package:http/http.dart' as http;

@Injectable()
class MovieService {
  static final api_key = 'my-omdb-key';
  dynamic movie;

  dynamic getMovie(String imdbID) async {
    var apiUrl = Uri(
        scheme: 'http',
        host: 'www.omdbapi.com',
        queryParameters: {'apikey': api_key, 'r': 'json', 'i': imdbID});

    try {
      final response = await http.get(apiUrl);
      movie = json.decode(response.body);
      return movie;
    } catch (e) {
      print(e);
    }
  }
}
