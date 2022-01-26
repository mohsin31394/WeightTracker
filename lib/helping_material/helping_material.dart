import 'dart:io';
import 'package:flutter/material.dart';
import 'package:weigth_tracker/helping_material/scalling.dart';

showSnackBar(String text,BuildContext context){
  final snackBar = SnackBar(
    content: Text(text),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
checkInternetConnection() async {
  try {
    final result = await InternetAddress.lookup('example.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      return true;
    }else{
      return false;
    }
  } on SocketException catch (_) {
    return false;
  }
}
bool checkOpeningTime({required TimeOfDay currentTime, openTime, closeTime}) {
  List open = openTime.toString().split(':');
  List close = closeTime.toString().split(':');
  int openingHour = int.parse(open[0]);
  if(openingHour==00){
    openingHour=24;
  }
  int openingMint;
  if(open[1].toString().contains('am')||open[1].toString().contains('AM')){
    openingMint=int.parse(open[1].toString().substring(0,2));
  }else if(open[1].toString().contains('pm')||open[1].toString().contains('PM')){
    openingMint=int.parse(open[1].toString().substring(0,2));
    openingHour=openingHour+12;
  }
  else{
    openingMint = int.parse(open[1]);
  }


  int closingHour = int.parse(close[0]);
  if(closingHour==00){
    closingHour=24;
  }
  int closingMint;
  if(close[1].toString().contains('am')||close[1].toString().contains('AM')){
    closingMint=int.parse(close[1].toString().substring(0,2));
  }else if(close[1].toString().contains('pm')||close[1].toString().contains('PM')){
    closingMint=int.parse(close[1].toString().substring(0,2));
    closingHour=closingHour+12;
  }
  else{
    closingMint = int.parse(close[1]);
  }



  if (openingHour < int.parse(currentTime.hour.toString()) &&
      closingHour > int.parse(currentTime.hour.toString())) {
    return true;
    // if(openingMint<=int.parse(currentTime.minute.toString()) && closingHour>=int.parse(currentTime.hour.toString())
  } else if (openingHour == int.parse(currentTime.hour.toString())) {
    if (openingMint <= int.parse(currentTime.minute.toString())) {
      return true;
    } else {
      return false;
    }
  } else if (closingHour == int.parse(currentTime.hour.toString())) {
    if (closingMint > int.parse(currentTime.minute.toString())) {
      return true;
    } else {
      return false;
    }
  } else {
    return false;
  }
}

showLoaderDialog(BuildContext context){
  AlertDialog alert=AlertDialog(
    content: Container(
        color: Colors.transparent,
        child: Center(child: CircularProgressIndicator(color: Colors.blue,))),
  );
  showDialog(barrierDismissible: false,
    context:context,
    builder:(BuildContext context){
      return alert;
    },
  );
}
class LoadingDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: true,
      child: Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          color: Colors.transparent,
          child: Center(child: CircularProgressIndicator(color: Colors.blue,)),
        ),
      ),
    );
  }
}


class SimpleText extends StatelessWidget {
  String? text;
  double fontSize;
  FontWeight fontWeight;
  Color color;
  TextAlign? textAlign;
  bool isTextUnderLine, roboto;
  double padding;
  VoidCallback? onTap;

  SimpleText(this.text,
      {Key? key,
        this.fontSize = 16,
        this.fontWeight = FontWeight.w500,
        this.color = Colors.white,
        this.isTextUnderLine = false,
        this.roboto = false,
        this.onTap,
        this.padding = 0,
        this.textAlign = TextAlign.start})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    init(context);
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.all(padding),
        child: Text(
          text!,
          textAlign: textAlign,
          style:TextStyle(
                  decoration: isTextUnderLine == true
                      ? TextDecoration.underline
                      : null,
                  color: color,
                  fontSize: width(fontSize),
                  fontWeight: fontWeight),

        ),
      ),
    );
  }
}
