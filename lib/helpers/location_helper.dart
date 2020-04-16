import 'dart:convert';

import 'package:http/http.dart' as http;


const TOKEN_KEY='[Token Key]';

 class LocHelper{
   static String staticMapurl(double longitude,double latitude){
     return 'https://api.mapbox.com/styles/v1/mapbox/light-v10/static/pin-s($longitude,$latitude)/$longitude,$latitude,13,0/300x200@2x?access_token=$TOKEN_KEY';
   }
   static Future<String> getAddress(double longitude,double latitude)async{
     final response=await http.get('https://api.mapbox.com/geocoding/v5/mapbox.places/$longitude,$latitude.json?access_token=$TOKEN_KEY');
     final locData=jsonDecode(response.body);
     final String address= locData['features'][2]['place_name'];
     return address;
   }
 }




 