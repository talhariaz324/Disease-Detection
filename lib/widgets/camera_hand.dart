import 'package:camera/camera.dart';
import 'package:disease_detection/widgets/camera_widget.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tflite/tflite.dart';

import '../utilities/routes.dart';

class CameraHands extends StatefulWidget {
  final List<CameraDescription> cameras;

  const CameraHands(this.cameras, {Key? key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<CameraHands> {
  String predOne = '';
  double confidence = 0;
  double index = 0;
  int? getCount;
  int? getCount2 = 0;

  @override
  void initState() {
    super.initState();
    loadTfliteModel();

    nextPage();
  }

  nextPage() {
    Future.delayed(const Duration(seconds: 12), () {
      Navigator.of(context).pushReplacementNamed(
        MyRoutes.result,
        arguments: getCount2! > 1 && confidence > 0.5
            ? 51
            : 17, // you can change confidence for the result
      );
    });
  }

  loadTfliteModel() async {
    // ignore: unused_local_variable
    String? res;
    res = await Tflite.loadModel(
        model: "assets/model_unquant.tflite", labels: "assets/labels.txt");
  }

  setRecognitions(outputs) async {
    if (outputs[0]['index'] == 0) {
      index = 0;
    } else {
      index = 1;
      int count = 0;
      count++;
      final prefs = await SharedPreferences.getInstance();

      prefs.setInt('count', count);
      getCount = prefs.getInt('count');
      if (getCount == 1) {
        int getCount1 = getCount! + 1;
        prefs.setInt('count', getCount1);
        getCount2 = prefs.getInt('count');
      } else {
        return;
      }
    }

    confidence = outputs[0]['confidence'];

    setState(() {
      predOne = outputs[0]['label'];
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text(
          "HAND TEST",
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Stack(
        children: [
          CameraWidget(widget.cameras, setRecognitions),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.all(size.height * 0.01),
              child: Card(
                color: Theme.of(context).backgroundColor,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              const Expanded(
                                flex: 2,
                                child: Text(
                                  '-ve',
                                  style: TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20.0),
                                ),
                              ),
                              SizedBox(
                                width: size.height * 0.01,
                              ),
                              Expanded(
                                flex: 8,
                                child: SizedBox(
                                  height: 32.0,
                                  child: Stack(
                                    children: [
                                      LinearProgressIndicator(
                                        valueColor:
                                            const AlwaysStoppedAnimation<Color>(
                                                Colors.green),
                                        value: index == 0 ? confidence : 0.0,
                                        backgroundColor:
                                            Colors.green.withOpacity(0.2),
                                        minHeight: 50.0,
                                      ),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: Text(
                                          '${index == 0 ? (confidence * 100).toStringAsFixed(0) : 0} %',
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 20.0),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: size.height * 0.01,
                          ),
                          Row(
                            children: [
                              const Expanded(
                                flex: 2,
                                child: Text(
                                  '+ve',
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20.0),
                                ),
                              ),
                              SizedBox(
                                width: size.height * 0.01,
                              ),
                              Expanded(
                                flex: 8,
                                child: SizedBox(
                                  height: 32.0,
                                  child: Stack(
                                    children: [
                                      LinearProgressIndicator(
                                        valueColor:
                                            const AlwaysStoppedAnimation<Color>(
                                                Colors.red),
                                        value: index == 1 ? confidence : 0.0,
                                        backgroundColor:
                                            Colors.red.withOpacity(0.2),
                                        minHeight: 50.0,
                                      ),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: Text(
                                          '${index == 1 ? (confidence * 100).toStringAsFixed(0) : 0} %',
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 20.0),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
