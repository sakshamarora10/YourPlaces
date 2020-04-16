import 'dart:io';

import 'package:flutter/material.dart';
import 'package:your_places/helpers/location_helper.dart';
import 'package:your_places/models/place.dart';
import 'package:your_places/providers/places.dart';
import 'package:your_places/widgets/container_image.dart';
import 'package:your_places/widgets/place_input.dart';
import 'package:latlong/latlong.dart';
import 'package:provider/provider.dart';

class AddPlaceScreen extends StatefulWidget {
  static const routename='/add-place';
  @override
  _AddPlaceScreenState createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final _titleController = TextEditingController();
  File _pickedImage;
  LatLng _location;
  void _getImage(File pickedImage){
    _pickedImage=pickedImage;
  }

  void _getLocation(LatLng loc){
    _location=loc;
  }

  Future<void> _onSave() async{
    if(_titleController.text.isEmpty||_pickedImage==null||_location==null) {
      return;
    }
    else {Provider.of<Places>(context,listen: false).addPlace(
      _titleController.text,
      _pickedImage,
      PlaceLocation(
        latitude: _location.latitude,
        longitude:_location.longitude,
        address: await LocHelper.getAddress(_location.longitude, _location.latitude)));
    Navigator.of(context).pop();}
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Your Place"),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Column(
                  children: <Widget>[
                    TextField(
                      controller: _titleController,
                      decoration: InputDecoration(
                        labelText: 'Title',
                      ),
                    ),SizedBox(height: 40,),
                    ImageContainer(_getImage),
                    SizedBox(height: 40,),
                    LocationInput(_getLocation),
                  ],
                ),
              ),
            ),
          ),
          RaisedButton.icon(
            color: Theme.of(context).accentColor,
            icon: Icon(Icons.add),
            label: Text("Add"),
            elevation: 0,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            onPressed: _onSave,
          )
        ],
      ),
    );
  }
}
