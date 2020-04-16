import 'package:flutter/material.dart';
import 'package:your_places/providers/places.dart';
import 'package:your_places/screens/add_places.dart';
import 'package:your_places/screens/place_detail_screen.dart';
import 'package:your_places/screens/places_list.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx)=>Places(),
          child: MaterialApp(
        title: 'GREAT PLACES',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          accentColor:Colors.amber 
        ),
        home: PlacesListScreen() ,
        routes: {
          PlacesListScreen.routename:(ctx)=>PlacesListScreen(),
          AddPlaceScreen.routename:(ctx)=>AddPlaceScreen(),
          PlaceDetail.routename:(ctx)=>PlaceDetail(),
        },
      ),
    );
  }
}