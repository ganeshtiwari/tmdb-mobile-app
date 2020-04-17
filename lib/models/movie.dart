class Movie {
  final int id; 
  final bool video; 
  final int voteCount; 
  final double voteAverage; 
  final String title; 
  final String releaseDate; 
  final String originalLanguage; 
  final String originalTitle; 
  final List<int> genreIds; 
  final String backdropPath; 
  final bool adult; 
  final String overview; 
  final String posterPath; 
  final double popularity;
  final String mediaType; 

  Movie({
    this.id,
    this.voteCount, 
    this.voteAverage, 
    this.title, 
    this.releaseDate, 
    this.originalLanguage, 
    this.originalTitle, 
    this.genreIds, 
    this.backdropPath, 
    this.adult, 
    this.overview, 
    this.posterPath, 
    this.popularity, 
    this.mediaType, 
    this.video,
    });

    factory Movie.fromJson(Map<String, dynamic> json) {
      List<int> genreList = List<int>.from(json["genre_ids"]);

      return Movie(
        id: json["id"],
        video: json["video"], 
        voteCount: json["vote_count"], 
        voteAverage: json["vote_average"].toDouble(),
        title: json["title"], 
        releaseDate: json["release_date"], 
        originalLanguage: json["original_language"], 
        originalTitle: json["original_title"], 
        genreIds: genreList, 
        backdropPath: json["backdrop_path"], 
        adult: json["adult"], 
        overview: json["overview"],
        posterPath: json["poster_path"], 
        popularity: json["popularity"], 
        mediaType: json["media_type"],
      );
    }
}
