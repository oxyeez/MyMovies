import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:angular_router/angular_router.dart';
import 'src/movie/movie_component.dart';
import 'src/movie/movie_search_component.dart';
import 'src/movie/routes.dart';

// AngularDart info: https://angulardart.dev
// Components info: https://angulardart.dev/components

@Component(
    selector: 'my-app',
    styleUrls: ['app_component.css'],
    templateUrl: 'app_component.html',
    directives: [
      MaterialButtonComponent,
      MovieSearchComponent,
      MovieComponent,
      routerDirectives
    ],
    exports: [RoutePaths, Routes])
class AppComponent {}
