import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

class MapScreen extends StatefulWidget {
  static const routename = '/mapscreen';
  final LatLng _locData;
  final bool readOnly;
  MapScreen(this._locData, this.readOnly);
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng _pickedLocation;
  @override
  void initState() {
    _pickedLocation = widget._locData;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: widget.readOnly
            ? Text("Your Location")
            : Text("Choose Your Location"),
        centerTitle: true,
        actions: widget.readOnly
            ? null
            : <Widget>[
                IconButton(
                  icon: Icon(Icons.check),
                  onPressed: () {
                    Navigator.of(context).pop(_pickedLocation);
                  },
                )
              ],
      ),
      body: FlutterMap(
        options: MapOptions(
            center: _pickedLocation,
            interactive: true,
            minZoom: 10,
            maxZoom: 18,
            onTap: widget.readOnly
                ? null
                : (newLocation) {
                    setState(() {
                      _pickedLocation = newLocation;
                    });
                  }),
        layers: [
          TileLayerOptions(
            urlTemplate:
                'https://api.mapbox.com/styles/v1/sakshamarora/ck8z2bcqw08nv1in127q8sw98/tiles/256/{z}/{x}/{y}@2x?access_token=YOUR_TOKEN_KEY',
            additionalOptions: {
              'accessToken':
                  'YOUR_TOKEN_KEY',
              'id': 'mapbox.mapbox-streets-v8'
            },
          ),
          MarkerLayerOptions(markers: [
            Marker(
                point: _pickedLocation,
                builder: (ctx) => IconButton(
                    padding: EdgeInsets.all(0),
                    icon: Icon(
                      Icons.location_on,
                      size: 40,
                    ),
                    onPressed: () {}))
          ])
        ],
      ),
    );
  }
}
