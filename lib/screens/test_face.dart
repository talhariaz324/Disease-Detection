import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:tflite/tflite.dart';
import 'dart:math' as math;

import '../models/models.dart';
import '../widgets/bndbox.dart';
import '../widgets/camera_face.dart';

class TestFace extends StatefulWidget {
  final List<CameraDescription> cameras;

  const TestFace(this.cameras, {Key? key}) : super(key: key);

  @override
  _TestFaceState createState() => _TestFaceState();
}

class _TestFaceState extends State<TestFace> {
  List<dynamic>? _recognitions;
  int _imageHeight = 0;
  int _imageWidth = 0;
  String _model = "";
  int _counter = 0;
  String? res;

  @override
  void initState() {
    super.initState();
  }

  loadModel() async {
    switch (_model) {
      case posenet:
        res = await Tflite.loadModel(
            model: "assets/posenet_mv1_075_float_from_checkpoints.tflite");
        break;

      default:
        res = await Tflite.loadModel(
            model: "assets/ssd_mobilenet.tflite",
            labels: "assets/ssd_mobilenet.txt");
    }
    // print(res);
  }

  onSelect(model) {
    setState(() {
      _model = model;
    });
    loadModel();
  }

  setRecognitions(recognitions, imageHeight, imageWidth) {
    setState(() {
      _recognitions = recognitions;
      _imageHeight = imageHeight;
      _imageWidth = imageWidth;
    });
    _counter++;
  }

  setRecognitionsdumy(recognitions, imageHeight, imageWidth) {}

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      body: _model == ""
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton(
                    child: const Text(posenet),
                    onPressed: () => onSelect(posenet),
                  ),
                ],
              ),
            )
          : Stack(
              children: [
                Camera(
                  widget.cameras,
                  _model,
                  _counter >= 2 ? setRecognitionsdumy : setRecognitions,
                ),
                BndBox(
                    _recognitions == null ? [] : _recognitions!,
                    math.max(_imageHeight, _imageWidth),
                    math.min(_imageHeight, _imageWidth),
                    screen.height,
                    screen.width,
                    _model),
              ],
            ),
    );
  }
}
