
import 'package:flutter/material.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:flutter/services.dart';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    ));

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() {
    return new HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  String result='hi';

  Future _scanQR() async {
    try {
      String cameraScanResult = await scanner.scan();
      setState(() {
        result = cameraScanResult;
      });
    } on PlatformException catch (ex) {
      if (ex.code == scanner.CameraAccessDenied) {
        setState(() {
          result = "Camera permission was denied";
        });
      } else {
        setState(() {
          result = "Unknown Error $ex";
        });
      }
    } on FormatException {
      setState(() {
        result = "You pressed the back button before scanning anything";
      });
    } catch (ex) {
      setState(() {
        result = "Unknown Error $ex";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: 
      Image(image: AssetImage('images/download.png'),
      height:25,
      width:500,
        ),
         
      Column(children: <Widget>[
         FloatingActionButton.extended(
        icon: Icon(Icons.camera_alt),
        heroTag: Null,
        label: Text("Scan"),
        onPressed: _scanQR,
        ),
         FloatingActionButton.extended(
        icon: Icon(Icons.people),
        heroTag: Null,
        label: Text("Participants"),
        //onPressed: _scanQR,
        ),

      ],
      ),
      );
      //floatingActionButtonLocation: FloatingActionButtonLocation.endFloat
       
      
    
  } 
}