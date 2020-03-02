import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import './organization.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';

Future<List<Organization>> fetchLocations() async {
  var response = await http.get(
      'https://us-central1-gp-service-4aaa8.cloudfunctions.net/getLocations');
  debugPrint(response.body);
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response, then parse the JSON.
    Iterable l = json.decode(response.body);
    List<Organization> organizations =
        l.map((org) => Organization.fromJson(org)).toList();
    return organizations;
  } else {
    // If the server did not return a 200 OK response, then throw an exception.
    throw Exception('Failed to load locations');
  }
}

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<List<Organization>> futureLocations;
  @override
  void initState() {
    super.initState();
    futureLocations = fetchLocations();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Scaffold(
          appBar: AppBar(
            title: Text("Second Screen"),
          ),
          body: Center(
            child: FutureBuilder<List<Organization>>(
              future: futureLocations,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  debugPrint("123");
                  debugPrint(snapshot.data[0].name);
                  var locationList = snapshot.data;
                  return Locations(locationList);
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }
                return CircularProgressIndicator();
              },
            ),
          ),
        )
      ],
    );
  }
}



class Locations extends StatelessWidget {
  List<Organization> locations;
  Locations(this.locations);

  Widget _buildLocationItem(Organization location) {
//     return Container(
//    padding: EdgeInsets.fromLTRB(10,10,10,0),
//    height: MediaQuery.of(context).size.height * 0.3,
//    width: double.maxFinite,
//    child: Card(
//      elevation: 3,
//            child: ListTile(
//           leading: Icon(Icons.album, size: 50),
//           title: Text('Heart Shaker'),
//           subtitle: Text('TWICE'),
//         ),
//    ),
//  );
    // return ListTile(
    //       leading: Icon(Icons.album, size: 50),
    //       title: Text('Heart Shaker'),
    //       subtitle: Text('TWICE'),
    //     );
    final imageWidget = Image.network(
      'https://picsum.photos/250?image=9',
      fit: BoxFit.cover,
    );
    return ListItem(location);
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Wrap(
            alignment: WrapAlignment.center,
            children: locations
                .map((item) => _buildLocationItem(item))
                .toList()
                .cast<Widget>())
      ],
    );

    // return ListView.builder(
    //   itemBuilder: _buildLocationItem,
    //   itemCount: locations.length,
    // );
  }
}

class ListItem extends StatelessWidget {
  final Organization organization;
  // final Organization organization = Organization(
  //       title: "Introduction to Driving",
  //       level: "Beginner",
  //       indicatorValue: 0.33,
  //       price: 20,
  //       content:
  //           "Start by taking a couple of minutes to read the info in this section. Launch your app and click on the Settings menu.  While on the settings page, click the Save button.  You should see a circular progress indicator display in the middle of the page and the user interface elements cannot be clicked due to the modal barrier that is constructed.");
  ListItem(this.organization);
  Widget build(BuildContext context) {
    final imageUrl = organization.profileUrl == null
        ? 'https://picsum.photos/250?image=9'
        : organization.profileUrl;
    return SizedBox(
        height: 300,
        width: 300,
        child: Card(
          child: InkWell(
            onTap: () {
              Navigator.push(
                context, MaterialPageRoute(builder: (context) => DetailPage(organization: organization)));
              // Navigator.pushNamed(context, '/service',
              //     arguments: ScreenArguments(location.name, 'hay'));
            },
            highlightColor: Colors.black12,
            splashColor: Colors.white10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 200,
                  child: Stack(
                    children: [
                      Positioned.fill(
                        // In order to have the ink splash appear above the image, you
                        // must use Ink.image. This allows the image to be painted as
                        // part of the Material and display ink effects above it. Using
                        // a standard Image will obscure the ink splash.
                        child: Ink.image(
                          image: NetworkImage(imageUrl),
                          fit: BoxFit.contain,
                          child: Container(),
                        ),
                      ),
                      // Positioned(
                      //   bottom: 16,
                      //   left: 16,
                      //   right: 16,
                      //   child: FittedBox(
                      //     fit: BoxFit.scaleDown,
                      //     alignment: Alignment.centerLeft,
                      //     child: Text('title'),
                      //   ),
                      // ),
                    ],
                  ),
                ),
                // Description and share/explore buttons.
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // This array contains the three line description on each card
                      // demo.
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Text(
                          organization.name,
                        ),
                      ),
                      Text('city'),
                      Text('location'),
                    ],
                  ),
                ),
                // share, explore buttons
              ],
            ),
          ),
        ));
  }
}




