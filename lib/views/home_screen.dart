import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:weigth_tracker/helping_material/helping_material.dart';
import 'package:weigth_tracker/helping_material/scalling.dart';
import 'package:weigth_tracker/network/firebase.dart';
import 'package:weigth_tracker/widgets/button.dart';
import 'package:weigth_tracker/widgets/textfield_class.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController weightCtr = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  String? password = '';
  bool loading = false;
  bool screenDisable = false;

  @override
  Widget build(BuildContext context) {
    init(context);
    return AbsorbPointer(
      absorbing: screenDisable,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: Container(
          height: screenHeight,
          width: double.infinity,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: width(10)),
              child: Form(
                key: _formkey,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          top: height(50),bottom: height(20)),
                      child: SimpleText('Weight',
                          color: Colors.black,
                          roboto: true,
                          fontWeight: FontWeight.w700,
                          fontSize: 24),
                    ),
                    TextFieldClass(
                      'Weight',
                      'Enter your Weight',
                      keyboardType: TextInputType.number,
                      controller: weightCtr,
                    ),

                    Padding(
                      padding: EdgeInsets.only(top: height(30)),
                      child: loading
                          ? CircularIndicatorBar()
                          : Button(
                          'Done',
                          onTap: () async {
                            FocusScope.of(context).unfocus();
                            if (_formkey.currentState!.validate() ){

                              setState(() {
                                loading=true;
                              });
                              await Database.addData(weight: weightCtr.text.toString());
                              setState(() {
                                loading=false;
                              });
                            }

                          }
                      ),
                    ),
                      Divider(),
                    Padding(
                      padding: EdgeInsets.only(
                          top: height(20),bottom: height(20)),
                      child: SimpleText('Weight List From Database',
                          color: Colors.black,
                          roboto: true,
                          fontWeight: FontWeight.w700,
                          fontSize: 18),
                    ),

                      Container(
                        child: StreamBuilder(
                        stream: FirebaseFirestore.instance.collection("userInfo").snapshots(),
                        builder: (context,AsyncSnapshot snapshot) {
                          if(snapshot.hasData){
                            return Center(
                              child: ListView.separated(
                                  shrinkWrap: true,
                                  itemBuilder: (context,index)=>SimpleText(
                                    snapshot.data.docs[index].data()!['weight'],
                                    textAlign: TextAlign.center,
                                    color: Colors.black,),
                                  separatorBuilder:(context,index)=> SizedBox(height: height(10),),
                                  itemCount: snapshot.data.docs.length),
                            );
                          }
                          return SimpleText('no data available yet',color: Colors.black,);
                        }),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

}
