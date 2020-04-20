import 'package:date_format/date_format.dart';
import 'package:emergency/constants/constants.dart';
import 'package:emergency/models/genre.dart';
import 'package:emergency/models/moviepage.dart';
import 'package:emergency/screens/details_screen.dart';
import 'package:emergency/services/genre_service.dart';
import 'package:emergency/services/trending_service.dart';
import "package:flutter/material.dart";
import "package:emergency/models/movie.dart";
import "dart:async" show Future;

import 'package:flutter_svg/flutter_svg.dart';

// TODO: Refactoring

class HomeScreen extends StatefulWidget {
  static const String id = "home_screen";

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<GenreList> genreList;
  Future<MoviePage> moviePage;
  int selectedGenre;
  int currentPage;
  List<Movie> movieList;
  TextEditingController searchController = TextEditingController();
  ScrollController moviePageScrollController = ScrollController();
  String searchValue;

  final String tmdbLogoSVG = 'assets/images/tmdb.svg';

  @override
  void initState() {
    super.initState();
    genreList = fetchGenre();
    moviePage = fetchMoviePage(28, 1);
    print("Here");
    searchController.addListener(searchListener);
    moviePageScrollController.addListener(moviePageScrollLisener);
  }

  @override
  void dispose() {
    searchController.dispose();
    moviePageScrollController.dispose();
    super.dispose();
  }

  void searchListener() {
    setState(() {
      searchValue = searchController.text;
      // TODO: Search API for the search text and display relevant results.
    });
  }

  void moviePageScrollLisener() {
    if (moviePageScrollController.offset >=
            moviePageScrollController.position.maxScrollExtent &&
        !moviePageScrollController.position.outOfRange) {
      print("Reached the end of page");
      setState(() {
        Future<MoviePage> tempMoviePage =
            fetchMoviePage(selectedGenre, currentPage + 1);
        moviePage = tempMoviePage;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TMDB"),
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
      drawer: Drawer(
        child: Container(
          color: Color.fromRGBO(30, 39, 70, 1),
          child: ListView(
            // padding: EdgeInsets.zero,
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height / 1.7,
                child: DrawerHeader(
                  child: SvgPicture.network(
                    'https://www.themoviedb.org/assets/2/v4/logos/v2/blue_square_2-d537fb228cf3ded904ef09b136fe3fec72548ebc1fea3fbbd1ad9e36364db38b.svg',
                    // semanticsLabel: 'logo',
                    color: Colors.blue[400],
                    // color: Color.fromRGBO(13, 37, 63, 1),
                  ),
                ),
              ),
              ListTile(
                title: Text("Profile"),
                trailing: Icon(Icons.people, size: 20.0),
                onTap: () {},
              ),
              ListTile(
                title: Text("Settings"),
                trailing: Icon(Icons.settings, size: 20.0),
                onTap: () {},
              ),
              ListTile(
                title: Text("Favorites"),
                trailing: Icon(Icons.star, size: 20.0),
                onTap: () {},
              ),
              ListTile(
                title: Text("Logout"),
                trailing: Icon(Icons.all_out),
                onTap: () {},
              )
            ],
          ),
        ),
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
                        itemBuilder: (BuildContext context, int index) {
                          bool isSelected = selectedGenre == genres[index].id;
                          return Padding(
                            padding: EdgeInsets.all(8.0),
                            child: RaisedButton(
                              color: isSelected
                                  ? Colors.purple
                                  : Color.fromRGBO(30, 39, 70, 1),
                              elevation: isSelected ? 0 : 5,
                              padding: const EdgeInsets.all(5.0),
                              child: Text(
                                genres[index].name,
                                style: TextStyle(
                                  fontSize: 13.0,
                                  color:
                                      isSelected ? Colors.white : Colors.grey,
                                ),
                              ),
                              onPressed: () {
                                if (!isSelected) {
                                  setState(() {
                                    moviePage =
                                        fetchMoviePage(genres[index].id, 1);
                                    selectedGenre = genres[index].id;
                                    movieList = [];
                                  });
                                }
                              },
                            ),
                          );
                        });
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
              child: FutureBuilder<MoviePage>(
                future: moviePage,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<Movie> tempMovieList = snapshot.data.results;
                    currentPage = snapshot.data.page;
                    if (movieList != null) {
                      movieList = movieList + tempMovieList;
                    } else {
                      movieList = tempMovieList;
                    }
                    return ListView.builder(
                      // scrollDirection: Axis.horizontal,
                      itemCount: movieList.length,
                      controller: moviePageScrollController,
                      itemBuilder: (context, index) {
                        return Center(
                          child: ReusableMovieCard(
                            movie: movieList[index],
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
    String releaseDate =
        formatDate(DateTime.parse(movie.releaseDate), [yyyy, ' ', M, ' ', dd]);
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
    fontWeight: FontWeight.bold);
