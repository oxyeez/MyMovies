import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:angular_router/angular_router.dart';

import 'services/search_service.dart';
import 'routes.dart';

@Component(
  selector: 'my-search',
  templateUrl: 'movie_search_component.html',
  styleUrls: ['movie_search_component.css'],
  directives: [
    coreDirectives,
    MaterialFabComponent,
    MaterialIconComponent,
    MaterialButtonComponent,
    MaterialDropdownSelectComponent,
    materialInputDirectives,
    routerDirectives,
  ],
  providers: [ClassProvider(SearchService)],
  exports: [
    RoutePaths,
    Routes,
  ],
)
class MovieSearchComponent {
  final SearchService _searchService;
  final Router _router;

  List results;
  bool filter = false;

  dynamic selected;
  dynamic research;

  MovieSearchComponent(this._searchService, this._router);

  void onKey(dynamic event) async {
    results = await _searchService.getMovies(event.target.value, 1);
  }

  // void toggleFilters() {
  //   filter = !filter;
  // }

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

  void onResearch(String text) {
    research = text;
    gotoSearchResults();
  }

  String _researchResultsUrl(String research) =>
      RoutePaths.searchResults.toUrl(parameters: {searchParam: '$research'});

  // ignore: missing_return
  Future<NavigationResult> gotoSearchResults() {
    _router.navigate(_researchResultsUrl(research));
  }
}
