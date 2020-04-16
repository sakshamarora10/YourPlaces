import 'package:flutter/material.dart';
import 'package:your_places/screens/mapscreen.dart';
import 'package:latlong/latlong.dart';
import 'package:location/location.dart';
import '../helpers/location_helper.dart';

class LocationInput extends StatefulWidget {
  final Function getLocation;
  LocationInput(this.getLocation);
  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  LocationData _locationData;
  Widget map;
  String _imageUrl = '';
  bool isLoading=false;
  Future<void> currentLoc() async {
    Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
  try{
    _locationData = await location.getLocation();
    widget.getLocation(LatLng(_locationData.latitude,_locationData.longitude));
    setState(() {
      _imageUrl = LocHelper.staticMapurl(_locationData.longitude, _locationData.latitude);
  
    });
  }catch(err){
    Scaffold.of(context).showSnackBar(SnackBar(content: Text("ERROR OCCURED,TRY AGAIN LATER"),));
  }
  }
  Future<void> _showMap() async{
       Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
     setState(() {
      isLoading=true;
    });

   try{ _locationData = await location.getLocation();
      setState(() {
       isLoading=false;
     });
      LatLng _selectedLocation=  await Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>MapScreen(LatLng(_locationData.latitude, _locationData.longitude),false)));
     if(_selectedLocation!=null){
       widget.getLocation(LatLng(_selectedLocation.latitude,_selectedLocation.longitude));
       setState(() {
         _imageUrl = LocHelper.staticMapurl(_selectedLocation.longitude, _selectedLocation.latitude);
       });
     }
   }catch(err){
     setState(() {
       isLoading=false;
     });
   }
   
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 200,
          width: 300,
          child: _imageUrl.isEmpty
              ? Center(
                  child: Text("NO LOCATION CHOSEN"),
                )
              : Image.network(
                  _imageUrl,
                ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.location_on),
              label: Text('Current Location'),
              onPressed: currentLoc,
            ),
            FlatButton.icon(
              icon: isLoading?CircularProgressIndicator() :Icon(Icons.map),
              label: Text('Select Location'),
              onPressed: _showMap,
            )
          ],
        ),
      ],
    );
  }
}
