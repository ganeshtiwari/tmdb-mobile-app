import "dart:async" show Future;
import "dart:convert";
import "package:http/http.dart" as http;

import 'package:emergency/constants/constants.dart';
import 'package:emergency/models/trending.dart';

Future<MoviePage> fetchMoviePage(int genreId, int pageNO) async {
  final String url = AIP_ENDPOINT +
      "/discover/movie?api_key=" +
      API_KEY +
      "&with_genres=" +
      genreId.toString() +
      "&page="+pageNO.toString() +
      "&language=" +
      API_LANGUAGE;
  print(url);

  final response = await http.get(url);
  if (response.statusCode == 200) {
    return MoviePage.fromJson(json.decode(response.body));
  } else {
    throw Exception("Could not fetch MoviePage Movies");
  }
}
