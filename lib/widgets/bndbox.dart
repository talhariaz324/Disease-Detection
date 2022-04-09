// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:async';

import 'package:flutter/material.dart';

import '../utilities/routes.dart';

class BndBox extends StatefulWidget {
  final List<dynamic> results;
  final int previewH;
  final int previewW;
  final double screenH;
  final double screenW;
  final String model;

  const BndBox(this.results, this.previewH, this.previewW, this.screenH,
      this.screenW, this.model,
      {Key? key})
      : super(key: key);

  @override
  State<BndBox> createState() => _BndBoxState();
}

class _BndBoxState extends State<BndBox> {
  int sumData = 0;
  @override
  Widget build(BuildContext context) {
    var lists = <Widget>[];
    List<Widget> _renderKeypoints() {
      for (var re in widget.results) {
        var list = re["keypoints"].values.map<Widget>((k) {
          var _x = k["x"];
          var _y = k["y"];
          var scaleW, scaleH, x, y;

          if (widget.screenH / widget.screenW >
              widget.previewH / widget.previewW) {
            scaleW = widget.screenH / widget.previewH * widget.previewW;
            scaleH = widget.screenH;
            var difW = (scaleW - widget.screenW) / scaleW;
            x = (_x - difW / 2) * scaleW;
            y = _y * scaleH;
          } else {
            scaleH = widget.screenW / widget.previewW * widget.previewH;
            scaleW = widget.screenW;
            var difH = (scaleH - widget.screenH) / scaleH;
            x = _x * scaleW;
            y = (_y - difH / 2) * scaleH;
          }
          return Positioned(
            left: x - 6,
            top: y - 6,
            width: 100,
            height: 12,
            child: Text(
              "● ${k["part"]}",
              style: const TextStyle(
                color: Color.fromRGBO(37, 213, 253, 1.0),
                fontSize: 12.0,
              ),
            ),
          );
        }).toList();

        lists.addAll(list);
      }
      sumData = sumData + lists.length;
      Future.delayed(const Duration(seconds: 10), () {
        Navigator.of(context)
            .pushReplacementNamed(MyRoutes.result, arguments: sumData);
        // if (sumData == 51) {
        //   // can make a bar in which we can add its length on every iteration and then we can use it
        //   Navigator.of(context).pushNamed(MyRoutes.normal);
        // } else if (sumData > 51) {
        //   Navigator.of(context).pushNamed(MyRoutes.patient);
        // } else {}
      });

      // print(lists);
      return lists;
    }

    return Stack(
      children: _renderKeypoints(),
    );
  }
}
