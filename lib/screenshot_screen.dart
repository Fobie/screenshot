import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';

class ScreenShot extends StatefulWidget {
  const ScreenShot({super.key});

  @override
  State<ScreenShot> createState() => _ScreenShotState();
}

class _ScreenShotState extends State<ScreenShot> {
  final ScreenshotController screenshotController = ScreenshotController();

  saveToGallery(){

    screenshotController.capture().then((Uint8List? image){
      saveScreenshot(image!);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Image saved to gallery'))
    );
    
  }

  saveScreenshot(Uint8List bytes) async {
    final time = DateTime.now()
    .toIso8601String()
    .replaceAll('.', '_')
    .replaceAll(':', '_')
    ;
    final name = "Screenshot_$time";
    await ImageGallerySaver.saveImage(bytes, name: name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Take Screenshot'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Screenshot(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.red
                ),
                child: Text('Hi How are you'),
              ),
              controller: screenshotController
          ),
          const SizedBox(
            height: 32,
          ),
          ElevatedButton(
              onPressed: () {
                saveToGallery();
              },
              child: Text('Capture Screenshot')
          )
        ],
      ),
    );


  }

  Widget buildImage() => AspectRatio(
    aspectRatio: 1,
    child: Image.network(
      'https://images.unsplash.com/photo-1682686581797-21ec383ead02?ixlib=rb-4.0.3&ixid=M3wxMjA3fDF8MHxlZGl0b3JpYWwtZmVlZHwxfHx8ZW58MHx8fHx8&auto=format&fit=crop&w=500&q=60',
      fit: BoxFit.cover,
    ),

  );
}
