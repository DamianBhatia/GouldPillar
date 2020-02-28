import 'package:flutter/material.dart';
class Start extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter layout demo',
        theme: ThemeData.dark(),
        home: Scaffold(
            // appBar: AppBar(
            //   title: Text('Flutter layout demo'),
            // ),
            body: Stack(
          fit: StackFit.expand,
          children: [
            Container(
                decoration: new BoxDecoration(
                    image: new DecorationImage(
                        image: AssetImage('assets/img/pipes.png'),
                        repeat: ImageRepeat.repeat))),
            // titleSection,
            // buttonSection,
            Column(
              children: <Widget>[
                Expanded(
                    flex: 3,
                    child: Image(image: AssetImage('assets/img/gp_logo.png'))),
                Expanded(
                    flex: 1,
                    child: Column(children: [
                      MaterialButton(
                        color: Colors.black87,
                        minWidth: 140.0,
                        child: Text('Get Started'),
                        onPressed: () {
                          Navigator.pushNamed(context, '/home');
                        },
                      )
                    ]))
              ],
            ),
          ],
        )));
  }
}