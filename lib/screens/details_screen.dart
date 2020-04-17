import 'package:date_format/date_format.dart';
import 'package:emergency/constants/constants.dart';
import "package:flutter/material.dart";
import "package:emergency/models/movie.dart";

class DetailsScreen extends StatelessWidget {
  static const String id = "details_screen";

  @override
  Widget build(BuildContext context) {
    final Movie movie = ModalRoute.of(context).settings.arguments;
    String releaseDate =
        formatDate(DateTime.parse(movie.releaseDate), [M, ' ', dd, ', ', yyyy]);

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            alignment: Alignment.topLeft,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(AIP_IMAGE_LARGE + movie.posterPath),
                fit: BoxFit.fill,
              ),
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.white70, Colors.white38]),
            ),
            foregroundDecoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent, Color.fromRGBO(20, 26, 49, 1)],
                stops: [0.3, 1],
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            child: Padding(
              padding: EdgeInsets.only(top: 40.0),
              child: RaisedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                elevation: 0.0,
                color: Colors.transparent,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Icon(
                    Icons.arrow_back,
                    size: 40.0,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: MediaQuery.of(context).size.height / 1.5,
              // width: 200,
              color: Colors.transparent,
              padding: EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    movie.title,
                    textAlign: TextAlign.left,
                    style: _titleStyle,
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    movie.overview,
                    textAlign: TextAlign.justify,
                  ),
                  Container(
                    // color: Colors.blue,
                    padding: EdgeInsets.symmetric(vertical: 10.0),
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.schedule),
                        SizedBox(width: 15),
                        Text(
                          releaseDate,
                          style: TextStyle(
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.people_outline),
                        SizedBox(
                          width: 15.0,
                        ),
                        Text(
                          movie.popularity.toString(),
                          style: TextStyle(
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      raisedIcon(Icons.star, () {
                        print("Pressed");
                      }),
                      raisedIcon(Icons.cloud_download, () {
                        print("Pressed");
                      }),
                      raisedIcon(Icons.arrow_downward, () {
                        print("Pressed");
                      }),
                      raisedIcon(Icons.call_to_action, () {
                        print("Pressed");
                      }),
                      raisedIcon(Icons.people, () {
                        print("Pressed");
                      }),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget raisedIcon(IconData icon, Function onPressed) {
    return Container(
      width: 60,
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: RaisedButton(
        onPressed: onPressed,
        elevation: 0.0,
        color: Colors.white,
        clipBehavior: Clip.antiAlias,
        splashColor: Colors.grey,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        child: Icon(
          icon,
          color: Colors.grey,
        ),
      ),
    );
  }
}

const TextStyle _titleStyle = TextStyle(
    fontSize: 25, color: Colors.white, wordSpacing: 1.5, letterSpacing: 0.3,);
