import 'package:angular/angular.dart';
import 'package:angular_components/material_button/material_button.dart';
import 'package:angular_components/material_icon/material_icon.dart';
import 'package:angular_router/angular_router.dart';

import 'services/watchlist_service.dart';
import 'movie.dart';
import 'services/movie_service.dart';
import 'route_paths.dart';

@Component(
  selector: 'my-movie',
  templateUrl: 'movie_component.html',
  styleUrls: ['movie_component.css'],
  directives: [
    coreDirectives,
    MaterialIconComponent,
    MaterialButtonComponent,
  ],
  providers: [
    ClassProvider(MovieService),
    ClassProvider(WatchlistService),
  ],
)
class MovieComponent implements OnActivate {
  final MovieService _movieService;
  final Location _location;
  final WatchlistService _watchlistService;

  Movie movie;
  List watchlist;
  bool movieInWatchlist;

  MovieComponent(this._movieService, this._location, this._watchlistService);

  @override
  void onActivate(_, RouterState current) async {
    final imdbID = getId(current.parameters);

    if (imdbID != null) movie = Movie(await _movieService.getMovie(imdbID));
    watchlist = await _watchlistService.getAllMovies();
    movieInWatchlist = isInWatchlist(movie.imdbID);
  }

  void onAddMovie() async {
    await _watchlistService.addMovie(movie.imdbID);
    movieInWatchlist = !movieInWatchlist;
  }

  void onRemoveMovie() async {
    await _watchlistService.deleteMovie(movie.imdbID);
    movieInWatchlist = !movieInWatchlist;
  }

  bool isInWatchlist(String imdbID) {
    for (Map map in watchlist) {
      if (map['imdbID'] == imdbID) {
        return true;
      }
    }
    return false;
  }

  void goBack() => _location.back();
}
