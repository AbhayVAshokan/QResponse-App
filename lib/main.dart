import 'package:flutter/material.dart';
import './widgets/camera_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shake_event/shake_event.dart';
import 'package:geolocator/geolocator.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_sms/flutter_sms.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QResponse',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        accentColor: Colors.red,
        bottomAppBarColor: Colors.white60,
        // fontFamily: 'lato',
        textTheme: TextTheme(
            // headline: TextStyle(fontSize: 172.0, fontWeight: FontWeight.bold),
            ),
      ),
      home: QResponse(),
    );
  }
}

class QResponse extends StatefulWidget {
  final DatabaseReference database = FirebaseDatabase.instance.reference().child('location');

  sendData(double lat, double long) {
    database.child('lat').set(lat);
    database.child('lng').set(long);
  }

  @override
  _QResponseState createState() => _QResponseState();
}

class _QResponseState extends State<QResponse> with ShakeHandler {
  var count = 0;
  @override
  void dispose() {
    resetShakeListeners();
    super.dispose();
  }

  @override
  shakeEventListener() async {
    print("Accident Occured!!");
    _sendSMS(message, recipents);
    _showDialog(context);
    Position position = await Geolocator()
        .getLastKnownPosition(desiredAccuracy: LocationAccuracy.high);
    widget.sendData(
        position.latitude.toDouble(), position.longitude.toDouble());
        print("Speed: " + position.speed.toString());
    return super.shakeEventListener();
  }

  String message = "I met with an accident!! Help!!";
  List<String> recipents = ["+919562655170"];

  void _sendSMS(String message, List<String> recipents) async {
    String _result =
        await FlutterSms.sendSMS(message: message, recipients: recipents)
            .catchError((onError) {
      print(onError);
    });
    print(_result);
  }

  void showBottomNavigation(context) {
    if (count == 0) {
      widget.sendData(10, 20);
    }

    setState(() {
      count++;
    });
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return Container(
            color: Colors.black26,
            child: Card(
              color: Colors.black12,
              elevation: 10,
              child: Text("Hello World"),
            ),
          );
        });
  }

  void _showDialog(BuildContext context) {
    // Navigator.of(context).pop();
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          backgroundColor: Colors.red,
          title: Text("ACCIDENT OCCURED!!",
              style: GoogleFonts.lato(
                  textStyle: TextStyle(fontWeight: FontWeight.bold))),
          content: Text("EMERGENCY SERVICES ON THE WAY!!!",
              style: GoogleFonts.lato()),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    startListeningShake(75);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'QResponse',
          style: GoogleFonts.raleway(
              textStyle: TextStyle(
            fontWeight: FontWeight.bold,
          )),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.trending_up),
            onPressed: () => showBottomNavigation(context),
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        margin: EdgeInsets.all(10),
        color: Colors.black54,
        child: Stack(
          children: <Widget>[
            CameraWidget(),
          ],
        ),
      ),
      floatingActionButton: Container(
        height: 70.0,
        width: 70.0,
        child: FittedBox(
          child: FloatingActionButton(
            child: Icon(Icons.trending_up),
            onPressed: () => showBottomNavigation(context),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
