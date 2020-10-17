import 'package:parking_locator/models/place.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class PlacesService {
  final key = 'AIzaSyCHslPkHr-c64FlQkj6C137rqtMhM22W-s';

  Future<List<Place>> getPlaces(double lat, double lng) async {
    var res = await http.get(
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=$lat,$lng&type=parking&rankby=distance&key=$key');
    var json = convert.jsonDecode(res.body);
    print(res.body);
    var jsonResults = json['results'] as List;
    return jsonResults.map((e) => Place.fromJson(e)).toList();
  }
}
