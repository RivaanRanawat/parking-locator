import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:parking_locator/models/place.dart';
import 'package:parking_locator/screens/search_screen.dart';
import 'package:parking_locator/services/geolocator_service.dart';
import 'package:parking_locator/services/places_service.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final locatorService = GeoLocatorService();
  final placesService = PlacesService();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        FutureProvider(create: (context) => locatorService.getLocation()),
        ProxyProvider<Position, Future<List<Place>>>(
          update: (context, position, places) {
            return (position != null)
                ? placesService.getPlaces(position.latitude, position.longitude)
                : null;
          },
        )
      ],
      child: MaterialApp(
        title: 'Parking App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: SearchScreen(),
      ),
    );
  }
}
