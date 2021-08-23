import 'package:angular_router/angular_router.dart';

const idParam = 'id';
const searchParam = 'search';

class RoutePaths {
  static final movieSearch = RoutePath(path: 'search');
  static final watchlist = RoutePath(path: 'watchlist');
  static final movie = RoutePath(path: 'movie/:$idParam');
  static final searchResults =
      RoutePath(path: '${movieSearch.path}/:$searchParam');
}

String getId(Map<String, String> parameters) {
  final id = parameters[idParam];
  return id;
}

String getSearch(Map<String, String> parameters) {
  final search = parameters[searchParam];
  return search;
}
