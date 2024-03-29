import 'package:emergency/screens/details_screen.dart';
import 'package:emergency/screens/home_screen.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Movies",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        // primaryColor: Colors.blue
        primaryColor: Color.fromRGBO(20, 26, 49, 1),
        scaffoldBackgroundColor: Color.fromRGBO(20, 26, 49, 1),
        cardColor:  Color.fromRGBO(20, 26, 49, 1),
      ),
      initialRoute: HomeScreen.id,
      routes: {
        HomeScreen.id: (context) => HomeScreen(),
        DetailsScreen.id: (context) => DetailsScreen(),
      },
    );
  }
}
