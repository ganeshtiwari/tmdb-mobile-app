import 'package:date_format/date_format.dart';
import 'package:emergency/constants/constants.dart';
import 'package:emergency/models/genre.dart';
import 'package:emergency/models/trending.dart';
import 'package:emergency/screens/details_screen.dart';
import 'package:emergency/services/genre_service.dart';
import 'package:emergency/services/trending_service.dart';
import "package:flutter/material.dart";
import "dart:async" show Future;

class HomeScreen extends StatefulWidget {
  static const String id = "home_screen";

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<GenreList> genreList;
  Future<Trending> trending;

  final TextEditingController searchController = TextEditingController();
  String searchValue; 

  @override
  void initState() {
    super.initState();
    genreList = fetchGenre();
    trending = fetchTrending();

    searchController.addListener(searchListener);
  }

  @override 
  void dispose() {
    searchController.dispose(); 
    super.dispose();
  }

  void searchListener() {
    setState(() {
      searchValue = searchController.text;
      // TODO: Search API for the search text and display relevant results. 
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Movies"),
        elevation: 0.0,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Card(
              color: Colors.transparent,
              // elevation: 5.0,
              child: Container(
                padding: EdgeInsets.only(left: 10, right: 10),
                width: 250,
                child: TextFormField(
                  controller: searchController,
                  autofocus: false,
                  decoration: InputDecoration(
                    hintText: "Search",
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(
              height: 45.0,
              child: FutureBuilder<GenreList>(
                future: genreList,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var genres = snapshot.data.genres;
                    return ListView.builder(
                      physics: ClampingScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: genres.length,
                      itemBuilder: (BuildContext context, int index) => Padding(
                        padding: EdgeInsets.all(8.0),
                        child: RaisedButton(
                          color: Color.fromRGBO(30, 39, 70, 1),
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                            genres[index].name,
                            style: TextStyle(
                              fontSize: 13.0,
                              color: Colors.grey,
                            ),
                          ),
                          onPressed: () {
                            print(genres[index].name);
                          },
                        ),
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return SizedBox(
                      height: 45,
                      child: InkWell(
                        child: Text("${snapshot.error}"),
                      ),
                    );
                  } else {
                    return SizedBox();
                  }
                },
              ),
            ),
            SizedBox(height: 10),
            SizedBox(
              height: MediaQuery.of(context).size.height / 1.2,
              child: FutureBuilder<Trending>(
                future: trending,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<Movie> trendingMovies = snapshot.data.results;
                    return ListView.builder(
                      // scrollDirection: Axis.horizontal,
                      itemCount: trendingMovies.length,
                      itemBuilder: (context, index) {
                        return Center(
                          child: ReusableMovieCard(
                            movie: trendingMovies[index],
                          ),
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Card(
                      child: Center(
                        child: Text("${snapshot.error}"),
                      ),
                    );
                  } else {
                    return SizedBox();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ReusableMovieCard extends StatelessWidget {
  final Movie movie;

  ReusableMovieCard({this.movie});

  @override
  Widget build(BuildContext context) {
    String releaseDate = formatDate(DateTime.parse(movie.releaseDate), [yyyy, ' ', M, ' ', dd]);
    // String releaseDate = 
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30.0),
      child: Stack(
        // fit: StackFit.passthrough,
        overflow: Overflow.visible,
        children: <Widget>[
          RaisedButton(
            elevation: 10.0,
            color: Color.fromRGBO(30, 39, 70, 1),
            child: Container(
              width: MediaQuery.of(context).size.width / 1.2,
              height: 150,
              padding: EdgeInsets.only(
                top: 10,
                bottom: 10,
                left: 40,
              ),
            ),
            onPressed: () {
              print(movie.title);
              Navigator.pushNamed(
                context,
                DetailsScreen.id,
                arguments: movie,
              );
            },
          ),
          Positioned(
            bottom: 25.0,
            left: 15.0,
            child: Image.network(
              AIP_IMAGE_MEDIUM + movie.posterPath,
              height: 200,
              width: 100,
            ),
          ),
          Positioned(
            left: 75,
            top: 15,
            bottom: 0.0,
            right: 10,
            child: Container(
              width: 400,
              height: 200,
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(
                      "Language: ${movie.originalLanguage.toUpperCase()}",
                      textAlign: TextAlign.start,
                      style: _subTitleStyle,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(
                      "Popularity: ${movie.popularity.toString()}",
                      style: _subTitleStyle,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(
                      "Release Date: $releaseDate",
                      style: _subTitleStyle,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 10.0,
            left: 15.0,
            child: Container(
              width: 300,
              height: 100,
              alignment: Alignment.bottomLeft,
              padding: EdgeInsets.only(top: 5.0),
              child: Text(
                movie.title,
                style: _titleStyle,
              ),
            ),
          )
        ],
      ),
    );
  }
}

const TextStyle _subTitleStyle = TextStyle(
  fontSize: 13.0,
  wordSpacing: 0.5,
  letterSpacing: 0.1,
  color: Colors.grey,
);


const TextStyle _titleStyle = TextStyle(
  fontSize: 14.0,
  wordSpacing: 0.5,
  letterSpacing: 0.1,
  color: Colors.white,
  fontWeight: FontWeight.bold
);

