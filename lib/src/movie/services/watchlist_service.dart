import 'dart:convert';

import 'package:angular/angular.dart';

import 'package:http/http.dart' as http;

@Injectable()
class WatchlistService {
  final apiUrl = 'my-firebase-url';
  final _header = {'Content-type': 'application/json; charset=UTF-8'};

  List allMovies = [];

  // ignore: missing_return
  Future<List<dynamic>> getAllMovies() async {
    try {
      final response = await http.get(apiUrl + '/watchlist.json');
      final extractedData = json.decode(response.body) as Map<String, dynamic>;

      if (extractedData != null) {
        extractedData.forEach((key, value) {
          var values = value as Map<String, dynamic>;
          values['id'] = key;
          allMovies.add({'id': values['id'], 'imdbID': values['imdbID']});
        });
      }
      return allMovies;
    } catch (e) {
      print(e);
    }
  }

  String getApiId(String imdbID) {
    if (isInWatchlist(imdbID)) {
      for (Map map in allMovies) {
        if (map['imdbID'] == imdbID) {
          return map['id'];
        }
      }
    }
    return null;
  }

  Future<void> deleteMovie(String imdbID) async {
    var id = getApiId(imdbID);
    final url =
        '$apiUrl/watchlist/$id.json';

    try {
      await http.delete(url).then((response) {
        print(response);
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> addMovie(String imdbID) async {
    try {
      await http.post(apiUrl,
          headers: _header, body: json.encode({'imdbID': imdbID}));
    } catch (e) {
      print(e);
    }
  }

  bool isInWatchlist(String imdbID) {
    for (Map map in allMovies) {
      if (map['imdbID'] == imdbID) {
        return true;
      }
    }
    return false;
  }
}
