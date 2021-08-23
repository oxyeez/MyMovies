import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:angular_router/angular_router.dart';

import 'route_paths.dart';
import 'services/search_service.dart';

@Component(
  selector: 'search-results',
  templateUrl: 'search_results_component.html',
  styleUrls: ['search_results_component.css'],
  directives: [coreDirectives, MaterialButtonComponent],
  providers: [ClassProvider(SearchService)],
)
class SearchResultsComponent implements OnActivate {
  List allResults = [];
  List resultsForPage = [];
  int page = 1;
  int numberOfPages;
  final SearchService _searchService;
  final Location _location;
  dynamic selected;
  final Router _router;

  SearchResultsComponent(this._searchService, this._location, this._router);

  @override
  void onActivate(_, RouterState current) async {
    final research = getSearch(current.parameters);

    if (research != null) {
      for (var page = 1; page <= 3; page++) {
        var researchResults = await _searchService.getMovies(research, page);
        allResults += researchResults;
      }
      page = 1;
      numberOfPages = allResults.length ~/ 9;
      setResultsForPage();
    }
  }

  void setResultsForPage() {
    resultsForPage = [];
    for (var i = (page - 1) * 9; i < page * 9; i += 3) {
      var subresults = [];
      for (var j = 0; j < 3; j++) {
        if (i + j >= allResults.length) {
          break;
        }
        subresults.add(allResults[i + j]);
      }
      resultsForPage.add(subresults);
    }
  }

  void nextPage() {
    page++;
    setResultsForPage();
  }

  void previousPage() {
    page--;
    setResultsForPage();
  }

  void goBack() => _location.back();

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
