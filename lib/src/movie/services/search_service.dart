import 'dart:convert';

import 'package:angular/angular.dart';
import 'package:http/http.dart' as http;

@Injectable()
class SearchService {
  static final api_key = 'my-omdb-key';
  List<dynamic> results = [];

  // ignore: missing_return
  Future<List<dynamic>> getMovies(String search, int page) async {
    var apiUrl = Uri(scheme: 'http', host: 'www.omdbapi.com', queryParameters: {
      'apikey': api_key,
      'r': 'json',
      's': search,
      'page': page.toString(),
    });

    try {
      final response = await http.get(apiUrl);
      final extracted = json.decode(response.body);
      results = extracted['Search'];
      return results;
    } catch (e) {
      print(e);
    }
  }
}
