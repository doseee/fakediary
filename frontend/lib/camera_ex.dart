import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class CameraExample extends StatefulWidget {
  const CameraExample({Key? key}) : super(key: key);

  @override
  _CameraExampleState createState() => _CameraExampleState();
}

class _CameraExampleState extends State<CameraExample> {
  File? _image;
  final picker = ImagePicker();

  // 비동기 처리를 통해 카메라와 갤러리에서 이미지를 가져온다.
  Future getImage(ImageSource imageSource) async {
    final image = await picker.pickImage(source: imageSource);

    if (image != null) {
      final imageCropper = ImageCropper();

      final croppedFile = await imageCropper.cropImage(
        sourcePath: image.path,
        aspectRatio: CropAspectRatio(ratioX: 1580, ratioY: 2800),
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: '카드 자르기',
            toolbarColor: Color(0xff1C2A3D),
            toolbarWidgetColor: Color(0xffb4c0d0),
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: true,
          ),
          IOSUiSettings(
            title: '카드 자르기',
          ),
        ],
      );

      if (croppedFile != null) {
        setState(() {
          _image = File(croppedFile.path);
        });
      }
    }

    // setState(() {
    //   _image = File(image!.path); // 가져온 이미지를 _image에 저장
    // });

    Navigator.pop(context, _image);
  }

  // 이미지를 보여주는 위젯
  Widget showImage() {
    return Container(
        color: const Color(0xffd0cece),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.width,
        child: Center(
            child: _image == null
                ? Text('카드로 만들 사진을 업로드하세요!')
                : Image.file(File(_image!.path))));
  }

  @override
  Widget build(BuildContext context) {
    // 화면 세로 고정
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    return Scaffold(
        backgroundColor: const Color(0xfff4f3f9),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 25.0),
            showImage(),
            SizedBox(
              height: 50.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                // 카메라 촬영 버튼
                FloatingActionButton(
                  heroTag: 'camera',
                  tooltip: 'pick Iamge',
                  onPressed: () {
                    getImage(ImageSource.camera);
                  },
                  child: Icon(Icons.add_a_photo),
                ),

                // 갤러리에서 이미지를 가져오는 버튼
                FloatingActionButton(
                  heroTag: 'gallery',
                  tooltip: 'pick Iamge',
                  onPressed: () {
                    getImage(ImageSource.gallery);
                  },
                  child: Icon(Icons.wallpaper),
                ),
              ],
            )
          ],
        ));
  }
}
