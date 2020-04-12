import "dart:async" show Future; 
import "dart:convert";
import "package:http/http.dart" as http;

import 'package:emergency/constants/constants.dart';
import 'package:emergency/models/trending.dart'; 


Future<Trending> fetchTrending() async {
  final String url = AIP_ENDPOINT + "/trending/movie/week?api_key=" + API_KEY + "&language=" + API_LANGUAGE; 
  print(url); 

  final response = await http.get(url);
  if (response.statusCode == 200) {
    return Trending.fromJson(json.decode(response.body));  
  } else {
    throw Exception("Could not fetch Trending Movies");
  }
}