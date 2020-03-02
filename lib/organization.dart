import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  final Organization organization;
  DetailPage({Key key, this.organization}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final bottomContentText = Text(
      'organization.content',
      style: TextStyle(fontSize: 18.0),
    );
    final readButton = Padding(
        padding: EdgeInsets.symmetric(vertical: 16.0),
        child: RaisedButton(
          onPressed: () => {},
          color: Color.fromRGBO(58, 66, 86, 1.0),
          child: Text("BUTTON", style: TextStyle(color: Colors.white)),
        ));
    final bottomContent = Container(
      // height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      // color: Theme.of(context).primaryColor,
      padding: EdgeInsets.all(40.0),
      child: Center(
        child: Column(
          children: <Widget>[bottomContentText, readButton],
        ),
      ),
    );
    final levelIndicator = Container(
      child: Container(
        child: LinearProgressIndicator(
            backgroundColor: Color.fromRGBO(209, 224, 224, 0.2),
            // value: organization.indicatorValue,
            valueColor: AlwaysStoppedAnimation(Colors.green)),
      ),
    );

    // final coursePrice = Container(
    //   padding: const EdgeInsets.all(7.0),
    //   decoration: new BoxDecoration(
    //       border: new Border.all(color: Colors.white),
    //       borderRadius: BorderRadius.circular(5.0)),
    //   child: new Text(
    //     // "\$20",
    //     "\$" + 'organization.price.toString()',
    //     style: TextStyle(color: Colors.white),
    //   ),
    // );
    final topContentText = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 75.0),
        Icon(
          Icons.home,
          color: Colors.white,
          size: 40.0,
        ),
        Container(
          width: 90.0,
          child: new Divider(color: Colors.green),
        ),
        SizedBox(height: 10.0),
        FittedBox(
          fit: BoxFit.fitWidth,
          child: Text(
            organization.name,
            style: TextStyle(color: Colors.white, fontSize: 45.0),
          ),
        ),
        SizedBox(height: 30.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(flex: 1, child: levelIndicator),
            Expanded(
                flex: 6,
                child: Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text(
                      'organization.level',
                      style: TextStyle(color: Colors.white),
                    ))),
            // Expanded(flex: 1, child: coursePrice)
          ],
        ),
      ],
    );
    final topContent = Stack(
      children: <Widget>[
        Container(
            padding: EdgeInsets.only(left: 10.0),
            height: MediaQuery.of(context).size.height * 0.5,
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image: NetworkImage(organization.profileUrl != null
                    ? organization.profileUrl
                    : 'https://picsum.photos/250?image=9'),
                fit: BoxFit.contain,
              ),
            )),
        Container(
          height: MediaQuery.of(context).size.height * 0.5,
          padding: EdgeInsets.all(40.0),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(color: Color.fromRGBO(58, 66, 86, .9)),
          child: Center(
            child: topContentText,
          ),
        ),
        Positioned(
          left: 8.0,
          top: 60.0,
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back, color: Colors.white),
          ),
        )
      ],
    );
    return Scaffold(
      body: Column(
        children: <Widget>[topContent, bottomContent],
      ),
    );
  }
}

class ScreenArguments {
  final String name;
  final String message;

  ScreenArguments(this.name, this.message);
}

// class Organization {
//   String name;
//   String level;
//   double indicatorValue;
//   int price;
//   String content;

//   Organization(
//       {this.name, this.level, this.indicatorValue, this.price, this.content});
// }

class Organization {
  final String name;
  final String profileUrl;

  Organization({this.name, this.profileUrl});

  factory Organization.fromJson(Map<String, dynamic> json) {
    debugPrint(json.toString());
    return Organization(name: json['name'], profileUrl: json['profileUrl']);
  }
}
