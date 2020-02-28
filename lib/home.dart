import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
//import 'package:cloud_firestore/cloud_firestore.dart';

Future<List<Location>> fetchLocations() async {
  var response = await http.get(
      'https://us-central1-gp-service-4aaa8.cloudfunctions.net/getLocations');
  debugPrint(response.body);
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response, then parse the JSON.
    Iterable l = json.decode(response.body);
    List<Location> locations =
        l.map((location) => Location.fromJson(location)).toList();
    return locations;
  } else {
    // If the server did not return a 200 OK response, then throw an exception.
    throw Exception('Failed to load album');
  }
}

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<List<Location>> futureLocations;
  @override
  void initState() {
    super.initState();
    futureLocations = fetchLocations();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Second Screen"),
      ),
      body: Center(
        child: FutureBuilder<List<Location>>(
          future: futureLocations,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              debugPrint("123");
              debugPrint(snapshot.data[0].longitude.toString());
              var locationList = snapshot.data;
              return ListView.builder(
                itemCount: locationList.length,
                physics: BouncingScrollPhysics(),
                padding: EdgeInsets.all(0),
                itemBuilder: (context, index) {
                  return new Text(locationList[index].longitude.toString());
                },
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}

class Location {
  final double longitude;

  Location({this.longitude});

  factory Location.fromJson(Map<String, dynamic> json) {
    debugPrint(json.toString());
    return Location(
      longitude: json['location']['_longitude'],
    );
  }
}
