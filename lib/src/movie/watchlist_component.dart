import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';

import 'route_paths.dart';
import 'services/watchlist_service.dart';
import 'services/movie_service.dart';

@Component(
  selector: 'my-watchlist',
  templateUrl: 'watchlist_component.html',
  styleUrls: ['watchlist_component.css'],
  directives: [coreDirectives],
  providers: [
    ClassProvider(WatchlistService),
    ClassProvider(MovieService),
  ],
)
class WatchlistComponent implements OnInit {
  final WatchlistService _watchlistService;
  final MovieService _movieService;
  final Router _router;

  List watchlist;
  dynamic selected;

  WatchlistComponent(this._watchlistService, this._movieService, this._router);

  @override
  void ngOnInit() async {
    getWatchlist();
  }

  void getWatchlist() async {
    watchlist = await _watchlistService.getAllMovies();
    for (var map in watchlist) {
      map['title'] = (await _movieService.getMovie(map['imdbID']))['Title'];
    }
  }

  void onSelect(dynamic movie) {
    selected = movie;
    gotoMovie();
  }

  String _movieUrl(String imdbID) =>
      RoutePaths.movie.toUrl(parameters: {idParam: '$imdbID'});

  // ignore: missing_return
  Future<NavigationResult> gotoMovie() {
    _router.navigate(_movieUrl(selected['imdbID']));
  }
}
