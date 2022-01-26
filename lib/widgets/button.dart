import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weigth_tracker/helping_material/helping_material.dart';
import 'package:weigth_tracker/helping_material/scalling.dart';

class Button extends StatelessWidget {
  String? text;
  VoidCallback? onTap;

  Button(this.text, {Key? key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    init(context);
    return InkWell(
      onTap: onTap,
      child: Card(
        color: Colors.black,
        child: Container(
          height: width(51),
          width: screenWidth,
          child: Center(
              child: SimpleText(
                text,
                fontSize: 18,
              )),
        ),
      ),
    );
  }
}

class CircularIndicatorBar extends StatelessWidget {

  CircularIndicatorBar({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    init(context);
    return Card(
      color: Colors.black,
      child: Container(
        height: width(51),
        width: double.infinity,
        child: Center(
            child: CircularProgressIndicator(color: Colors.white)),
      ),
    );
  }
}
