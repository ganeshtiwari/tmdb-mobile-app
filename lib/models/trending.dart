import "movie.dart";


class MoviePage {
  final int page; 
  final List<Movie> results; 

  MoviePage({
    this.page, 
    this.results
  }); 

  factory MoviePage.fromJson(Map<String, dynamic> json) {
    List movieList = json["results"] as List;

    return MoviePage(
      page: json["page"], 
      results: movieList.map((movie) => Movie.fromJson(movie)).toList(),
    );
  }
}