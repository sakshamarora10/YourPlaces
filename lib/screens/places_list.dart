import 'package:flutter/material.dart';
import 'package:your_places/providers/places.dart';
import 'package:your_places/screens/add_places.dart';
import 'package:your_places/screens/place_detail_screen.dart';
import 'package:provider/provider.dart';

class PlacesListScreen extends StatelessWidget {
  static const String routename = '/product-list';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Places'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.pushNamed(context, AddPlaceScreen.routename);
              })
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<Places>(context, listen: false).fetchAndSetData(),
        builder: (ctx, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Consumer<Places>(
                child: Center(
                  child: Text("Add your favourite places"),
                ),
                builder: (ctx, places, ch) => places.getPlaces.length == 0
                    ? ch
                    : ListView.builder(
                        itemCount: places.getPlaces.length,
                        itemBuilder: (ctx, i) => Card(
                          margin: EdgeInsets.all(8),
                          elevation: 6,
                          child: Container(
                            height: 100,
                            decoration: BoxDecoration(
                                gradient: LinearGradient(colors: [
                              Colors.white.withOpacity(0.2),
                              Colors.white.withOpacity(0.6),
                            ])),
                            child: ListTile(
                              isThreeLine: true,
                              contentPadding: EdgeInsets.all(8),
                              leading: CircleAvatar(
                                radius: 28,
                                foregroundColor: Colors.blue,
                                backgroundImage:
                                    FileImage(places.getPlaces[i].image),
                              ),
                              title:
                                  Text(places.getPlaces[i].title.toUpperCase(),style: TextStyle(fontSize: 18,fontStyle: FontStyle.italic),),
                              subtitle:
                                  Text(places.getPlaces[i].location.address,softWrap: true,),
                              onTap: () {
                                Navigator.of(context).pushNamed(
                                    PlaceDetail.routename,
                                    arguments: places.getPlaces[i].id);
                              },
                              trailing: IconButton(
                                  icon: Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                    size: 30,
                                  ),
                                  onPressed: () {
                                    places.removePlace(places.getPlaces[i].id);
                                  }),
                            ),
                          ),
                        ),
                      ),
              ),
      ),
    );
  }
}
