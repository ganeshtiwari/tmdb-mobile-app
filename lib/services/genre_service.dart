import "dart:async" show Future;
import "dart:convert"; 
import 'package:emergency/constants/constants.dart';
import "package:http/http.dart" as http; 
import 'package:emergency/models/genre.dart'; 



Future<GenreList> fetchGenre() async {
  String genreUrl = AIP_ENDPOINT + "/genre/movie/list?api_key=" + API_KEY + "&language=" + API_LANGUAGE;
  print(genreUrl);
  final response = await http.get(genreUrl);
  if (response.statusCode == 200) {
    return GenreList.fromJson(json.decode(response.body));
  } else {
    throw Exception("Failed to fetch Genre");
  }
}