import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:location/location.dart';

class CameraWidget extends StatefulWidget {
  @override
  _CameraWidgetState createState() => _CameraWidgetState();
}

class _CameraWidgetState extends State<CameraWidget> {
  var _image;

  Future getImage() async {
    var image;
    image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = image;
    });
  }


  // var location = new Location();
  // Map<String, double> userLocation;
  // Future<void> getLocation() async {
  //   setState(() async {
  //     userLocation = (await location.getLocation()) as Map<String, double>;
      
  //   });
  //   print("SPEED: " + userLocation["speed"].toString());
  // }

  @override
  Widget build(BuildContext context) {
    // getLocation();
    return Column(
      children: <Widget>[
        RaisedButton(
          child: Text('Open Gangam Style'),
          onPressed: getImage,
        ),
         _image == null ? Text('Not Working') : Image(image: _image, height: 300.0, width: 300.0,)
      ],
    );
  }
}
