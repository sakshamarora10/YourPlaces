import 'package:flutter/material.dart';
import 'package:your_places/models/place.dart';
import 'package:your_places/providers/places.dart';
import 'package:your_places/screens/mapscreen.dart';
import 'package:latlong/latlong.dart';
import 'package:provider/provider.dart';

class PlaceDetail extends StatelessWidget {
  static const routename = '/place-detail';
  @override
  Widget build(BuildContext context) {
    final String id = ModalRoute.of(context).settings.arguments;
    Place place = Provider.of<Places>(context, listen: false).findById(id);
    return Scaffold(
      appBar: AppBar(
        title: Text(place.title.toUpperCase()),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            children: <Widget>[
              Container(
                height: 250,
                width: double.infinity,
                child: Image.file(
                  place.image,
                  fit: BoxFit.contain
                  //width: double.infinity,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                place.title.toUpperCase(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                place.location.address,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              SizedBox(
                height: 50,
              ),
              RaisedButton(
                elevation: 5,
                padding: EdgeInsets.all(15),
                shape: RoundedRectangleBorder(borderRadius:BorderRadius.all(Radius.elliptical(40, 20))),
                color: Colors.purple,
                child: Text(
                  "Show on Map",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (ctx) => MapScreen(
                          LatLng(place.location.latitude,
                              place.location.longitude),
                          true)));
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
