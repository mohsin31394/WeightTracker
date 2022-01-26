import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:weigth_tracker/helping_material/scalling.dart';

class TextFieldClass extends StatefulWidget {
  FontWeight fontWeight;
  String? labelText, hintText;
  String? image;
  TextInputType? keyboardType;
  bool? obscureText;
  double padding;
  VoidCallback? onTap;
  bool dateField;
  TextEditingController? controller;
  String? yourInitialData;
  FocusNode? myFocusNode;
  bool isEmail, isFullname;
  String? email, name;

  // bool showpassword;
  // final VoidCallback onTap;

  TextFieldClass(this.labelText, this.hintText,
      {Key? key,
        this.image,
      this.padding = 4,
      this.keyboardType,
      this.obscureText = false,
      this.onTap = null,
      this.isEmail = false,
      this.isFullname = false,
      this.dateField = false,
      this.yourInitialData,
      this.myFocusNode,
      this.fontWeight = FontWeight.normal,
      this.controller})
      : super(key: key);

  @override
  State<TextFieldClass> createState() => _TextFieldClassState();
}

class _TextFieldClassState extends State<TextFieldClass> {
  @override
  Widget build(BuildContext context) {
    init(context);

    return Padding(
      padding: EdgeInsets.only(top: height(10)),
      child: TextFormField(
        focusNode: widget.myFocusNode,
        controller: widget.controller,
        textInputAction: TextInputAction.next,
        readOnly: widget.dateField,
        cursorColor: Colors.black,
        keyboardType: widget.keyboardType,
        obscureText: widget.obscureText!,
        // obscureText: true,
        obscuringCharacter: '*',
        style: TextStyle(
          color: Colors.black,
        ),
        initialValue: widget.yourInitialData,
        decoration: InputDecoration(
          labelText: widget.labelText,
          labelStyle: TextStyle(
            color: Colors.black,
          ),
          hintText: widget.hintText,
          hintStyle: TextStyle(
            color: Colors.grey.shade400,
          ),
          contentPadding: EdgeInsets.only(top: 5),
          suffixIcon: widget.image!=null?InkWell(
            onTap: widget.onTap,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: SvgPicture.asset(widget.image!),
            ),
          ):null,
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade400),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
        ),
        validator: (String? value) {
          if (widget.isEmail) {
            if (value!.isEmpty) {
              return 'Please enter your Email';
            }
            if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                .hasMatch(value)) {
              return 'Please enter a valid Email';
            }
          } else if (widget.isFullname) {
            if (value!.isEmpty) {
              return 'Please enter your Name';
            }
          }else{
            if(value!.isEmpty){
            return 'Please enter your Weight';
            }
          }
          return null;
        },
        onSaved: (String? value) {
          if (widget.isFullname) {
            widget.name = value!;
          }
          if (widget.isEmail) {
            widget.email = value!;
          }
          return null;
        },
      ),
    );
  }
}
