import 'dart:io';
import 'package:OpenCam/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  File _image;

  getImage(ImageSource source) async {
    // ignore: deprecated_member_use
    var image = await ImagePicker.pickImage(source: source);
    File croppedFile = await ImageCropper.cropImage(
        sourcePath: image.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ],
        androidUiSettings: AndroidUiSettings(
          toolbarTitle: 'Cropper',
          toolbarColor: Colors.blue,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false,
        ),
        iosUiSettings: IOSUiSettings(
          minimumAspectRatio: 1.0,
        ));
    print(croppedFile.lengthSync());
    setState(() {
      _image = croppedFile;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
            child: (_image == null)
                ? Container(
                    height: 300.0,
                    color: Colors.grey[400],
                    child: Center(
                      child: Text(
                        "Open Camera or\n Pick an image",
                        style: TextStyle(
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                  )
                : Image.file(
                    _image,
                    height: 300.0,
                  ),
          ),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    getImage(ImageSource.camera);
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 20.0),
                    height: 60.0,
                    decoration: BoxDecoration(
                      color: Colors.red[400],
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Center(
                      child: Text(
                        "Open Camera",
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    getImage(ImageSource.gallery);
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 20.0),
                    height: 60.0,
                    decoration: BoxDecoration(
                      color: Colors.green[400],
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Center(
                      child: Text(
                        "Open Gallery",
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
