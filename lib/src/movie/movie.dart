class Movie {
  final dynamic movie;
  String title,
      release,
      genre,
      director,
      actors,
      plot,
      awards,
      poster,
      imdbID,
      runtime;
  int year;
  double rating;

  Movie(this.movie) {
    parseJson();
  }

  void parseJson() {
    title = movie['Title'];
    release = movie['Released'];
    genre = movie['Genre'];
    director = movie['Director'];
    actors = movie['Actors'];
    plot = movie['Plot'];
    awards = movie['Awards'];
    poster = movie['Poster'];
    imdbID = movie['imdbID'];
    rating = movie['imdbRating'] == null
        ? null
        : double.tryParse(movie['imdbRating']);
    year = movie['Year'] == null ? null : int.tryParse(movie['Year']);
    if (movie['Runtime'] != null) {
      var time = int.tryParse(movie['Runtime'].replaceAll(' min', ''));
      final duration = Duration(minutes: time);
      var parts = duration.toString().split(':');
      runtime = '${parts[0]}h ${parts[1]}m';
    }
  }
}
