import 'package:angular_router/angular_router.dart';

import 'movie_search_component.template.dart' as movie_search_template;
import 'movie_component.template.dart' as movie_template;
import 'search_results_component.template.dart' as search_results_template;
import 'watchlist_component.template.dart' as watchlist_template;

import 'route_paths.dart';

export 'route_paths.dart';

class Routes {
  static final search = RouteDefinition(
    routePath: RoutePaths.movieSearch,
    component: movie_search_template.MovieSearchComponentNgFactory,
  );

  static final movie = RouteDefinition(
    routePath: RoutePaths.movie,
    component: movie_template.MovieComponentNgFactory,
  );

  static final searchResults = RouteDefinition(
    routePath: RoutePaths.searchResults,
    component: search_results_template.SearchResultsComponentNgFactory,
  );

  static final watchlist = RouteDefinition(
    routePath: RoutePaths.watchlist,
    component: watchlist_template.WatchlistComponentNgFactory,
  );

  static final all = <RouteDefinition>[
    search,
    movie,
    searchResults,
    watchlist,
  ];
}
