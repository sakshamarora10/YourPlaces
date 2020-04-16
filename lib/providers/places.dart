import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:your_places/helpers/db_helper.dart';
import 'package:your_places/models/place.dart';

class Places with ChangeNotifier {
  List<Place> _places = [];
  List<Place> get getPlaces {
    return [..._places];
  }

  Place findById(String id){
    return _places.firstWhere((item)=>item.id==id);
  }

  Future<void> addPlace(String title, File image, PlaceLocation loc) async {
    final Place newPlace = Place(
      id: DateTime.now().toString(),
      image: image,
      location: loc,
      title: title,
    );
    _places.add(newPlace);
    notifyListeners();
    DBHelper.insertData('user_places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
      'latitude': newPlace.location.latitude,
      'longitude': newPlace.location.longitude,
      'address': newPlace.location.address,
    });
  }

  void removePlace(String id) {
    _places.removeWhere((item)=>item.id==id);
    notifyListeners();
    DBHelper.deleteData('user_places', id);
  }

  Future<void> fetchAndSetData() async {
    final tableData = await DBHelper.getData('user_places');
    _places = tableData.map((item) => Place(
            id: item['id'],
            title: item['title'],
            image: File(item['image']),
            location: PlaceLocation(
              latitude: item['latitude'],
              longitude: item['longitude'],
              address: item['address'],
            ))).toList();
    notifyListeners();
  }
}
