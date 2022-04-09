import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:tflite/tflite.dart';

typedef Callback = void Function(List<dynamic> list); // me

class CameraWidget extends StatefulWidget {
  final List<CameraDescription> cameras;
  final Callback setRecognitions;

  const CameraWidget(this.cameras, this.setRecognitions, {Key? key})
      : super(key: key);
  @override
  _CameraState createState() => _CameraState();
}

class _CameraState extends State<CameraWidget> {
  late CameraController cameraController; // me
  bool isDetecting = false;

  @override
  void initState() {
    super.initState();
    cameraController =
        CameraController(widget.cameras[0], ResolutionPreset.ultraHigh);
    cameraController.initialize().then((value) {
      if (!mounted) {
        return;
      }
      setState(() {});

      cameraController.startImageStream((image) {
        if (!isDetecting) {
          isDetecting = true;
          Tflite.runModelOnFrame(
            bytesList: image.planes.map((plane) {
              return plane.bytes;
            }).toList(),
            imageHeight: image.height,
            imageWidth: image.width,
            numResults: 1,
          ).then((value) {
            if (value!.isNotEmpty) {
              widget.setRecognitions(value);
              isDetecting = false;
            }
          });
        }
      });
    });
  }

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // var size = MediaQuery.of(context).size;
    if (!cameraController.value.isInitialized) {
      return Container();
    }

    return ClipRect(
      clipper: _MediaSizeClipper(MediaQuery.of(context).size),
      child: Transform.scale(
        scale: cameraController.value.aspectRatio,
        alignment: Alignment.topCenter,
        child: CameraPreview(cameraController),
      ),
    );
  }
}

class _MediaSizeClipper extends CustomClipper<Rect> {
  final Size mediaSize;
  const _MediaSizeClipper(this.mediaSize);
  @override
  Rect getClip(Size size) {
    return Rect.fromLTWH(0, 0, mediaSize.width, mediaSize.height);
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) {
    return true;
  }
}

    // return Transform.scale(
    //   scale: cameraController.value.aspectRatio,
    //   child: Center(
    //     child: AspectRatio(
    //       aspectRatio: cameraController.value.aspectRatio,
    //       child: CameraPreview(cameraController),
    //     ),
    //   ),
    // );
 
