import 'package:flutter/material.dart';
import 'package:rnb/models/getForm Models/getPartD.dart';

class DocumentInfo extends StatefulWidget {
  PartDGet formModel;
  DocumentInfo(@required this.formModel) :assert(formModel != null);
  @override
  _DocumentInfoState createState() => _DocumentInfoState();
}

class _DocumentInfoState extends State<DocumentInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [Color(0xffECE9E6), Color(0xffFFFFFF)]),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 60, 0, 10),
                  child: Text(
                    'Document Info',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Color.fromRGBO(182, 132, 59, 1),
                        fontFamily: 'Poppins',
                        fontSize: 24,
                        fontWeight: FontWeight.normal,
                        height: 0.9000000158945719),
                  ),
                ),
                SizedBox(height: 20,),
                Text(
                  'Profile picture',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Poppins',
                      fontSize: 17,
                      fontWeight: FontWeight.normal,
                      height: 0.9000000158945719),
                ),
                SizedBox(height: 10,),
                Image.network(widget.formModel.photoUrl,width: double.infinity,height: 300,),
                SizedBox(height: 20,),
                Text(
                  'Identity Proof',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Poppins',
                      fontSize: 17,
                      fontWeight: FontWeight.normal,
                      height: 0.9000000158945719),
                ),
                SizedBox(height: 10,),
                Image.network(widget.formModel.idProofUrl,width: double.infinity,height: 300,),
                SizedBox(height: 20,),

              ],
            ),
          ),
        ),
      ),
    );
  }
}

