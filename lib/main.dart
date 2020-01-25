import 'package:flutter/material.dart';
import './widgets/camera_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shake_event/shake_event.dart';

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
  @override
  _QResponseState createState() => _QResponseState();
}

class _QResponseState extends State<QResponse> with ShakeHandler{
  @override
  void dispose() {
    resetShakeListeners();
    super.dispose();
  }
  
  @override
  shakeEventListener() {
    print("Phone is shaking");
    return super.shakeEventListener();
  }

  void showBottomNavigation(context) {
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
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        margin: EdgeInsets.all(10),
        color: Colors.white,
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
