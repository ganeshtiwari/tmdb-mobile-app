import 'package:emergency/constants/constants.dart';
import 'package:emergency/models/genre.dart';
import 'package:emergency/models/trending.dart';
import 'package:emergency/services/genre_service.dart';
import 'package:emergency/services/trending_service.dart';
import "package:flutter/material.dart";
import "dart:async" show Future;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<GenreList> genreList;
  Future<Trending> trending;

  @override
  void initState() {
    super.initState();
    genreList = fetchGenre();
    trending = fetchTrending();
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
            SizedBox(
              height: 400,
              child: FutureBuilder<Trending>(
                future: trending,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<Movie> trendingMovies = snapshot.data.results;
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: trendingMovies.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            clipBehavior: Clip.antiAlias,
                            child: InkWell(
                              child: Image.network(
                                AIP_IMAGE_ENDPOINT +
                                    trendingMovies[index].posterPath,
                                fit: BoxFit.fill,
                                width: 250,
                              ),
                              onTap: () {},
                            ),
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
            SizedBox(height: 10),
            SizedBox(
              height: 75,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 5, 
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.all(8.0),
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      gradient: LinearGradient(
                        colors: [Colors.blue, Colors.cyanAccent], 
                        begin: Alignment.topLeft, 
                        end: Alignment.bottomRight
                      )
                    ),
                    child: Center(
                      child: Text("Item $index"),
                    ),
                  );
                },
              )
            ),
            Card(
              child: ListTile(
                  title: Text('Motivation $int'),
                  subtitle: Text('this is a description of the motivation')),
            ),
            Card(
              child: ListTile(
                  title: Text('Motivation $int'),
                  subtitle: Text('this is a description of the motivation')),
            ),
            Card(
              child: ListTile(
                  title: Text('Motivation $int'),
                  subtitle: Text('this is a description of the motivation')),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildGenreView(BuildContext context) {
    return ListView(
      scrollDirection: Axis.horizontal,
      children: <Widget>[
        Text("Hello"),
        Text("Hello"),
        Text("Hello"),
        Text("Hello"),
        Text("Hello"),
        Text("Hello"),
        Text("Hello"),
        Text("Hello"),
        Text("Hello"),
        Text("Hello"),
        Text("Hello"),
        Text("Hello"),
        Text("Hello"),
        Text("Hello"),
        Text("Hello"),
        Text("Hello"),
        Text("Hello"),
        Text("Hello"),
        Text("Hello"),
        Text("Hello"),
      ],
    );
  }
}
