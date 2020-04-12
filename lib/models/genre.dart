class Genre {
  final int id; 
  final String name;

  Genre({this.id, this.name}); 

  factory Genre.fromJson(Map<String, dynamic> json) {
    return Genre(
      id: json["id"] , 
      name: json["name"],
    );
  }
}

class GenreList {
  final List<Genre> genres; 

  GenreList({this.genres}); 

  factory GenreList.fromJson(Map<String, dynamic> json) {
    List genres = json['genres'] as List;
    return GenreList(
      genres: genres.map((genre) => Genre.fromJson(genre)).toList(),
    );
  }
}