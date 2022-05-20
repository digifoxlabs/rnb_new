import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rnb/forms/adult_info.dart';
import 'package:rnb/forms/upload_documents.dart';
import 'package:rnb/home_screen_category.dart';
import 'package:rnb/models/FamilyDetailModel.dart' as FamilyDetails;
import 'package:rnb/models/getForm%20Models/getPartB.dart';
import 'package:select_form_field/select_form_field.dart';
import 'package:rnb/utils/GlobalValues.dart' as globals;
import 'package:http/http.dart';
import 'dart:io';

class FormBUpdate extends StatefulWidget {
  final VoidCallback onfrontPress,onbackPress;
  final PartBGet model;
  const FormBUpdate({Key? key,required this.onfrontPress,required this.onbackPress,required this.model}) : super(key: key);

  @override
  _FamilyFormState createState() => _FamilyFormState();
}

class _FamilyFormState extends State<FormBUpdate> {
  final _formKey = GlobalKey<FormState>();

  final List<Map<String, dynamic>> _itemsyesno = [
    {
      'value': 'Yes',
      'label': 'Yes',
    },
    {
      'value': 'No',
      'label': 'No',
    },
  ];
  final List<Map<String, dynamic>> _itemscolony = [
    {
      'value': 'Inside plant campus',
      'label': 'Inside plant campus',
    },
    {
      'value': 'Lower colony',
      'label': 'Lower colony',
    },
    {
      'value': 'Upper Colony',
      'label': 'Upper Colony',
    },
  ];

  bool _familyMember = false;
  List<Widget> adult = [];
  List<Widget> kids = [];


  setData() async {
    for(var elements in widget.model.familyDetails){
      final response = await get(Uri.parse(elements.fPhoto));
      var image = Base64Encoder().convert(response.bodyBytes);
      FamilyDetails.FamilyDetail detail = FamilyDetails.FamilyDetail(fName: elements.fName, fDob: elements.fDob.toString(), fGender: elements.fGender, fPhoto: image);
      globals.familyDetails.add(detail);
    }
    setState(()  {
      globals.controllerFamilyMemberStaying.text = widget.model.familyDetails.isEmpty?'No':'Yes';
      if(globals.controllerFamilyMemberStaying.text == 'Yes'){
        _familyMember = true;
        globals.controllerColony.text = _itemscolony.contains(widget.model.colonyName)?widget.model.colonyName:"";
      }
      (context as Element).markNeedsBuild();
    });

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setData();
  }

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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Text(
                  'Family Member',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: Color.fromRGBO(182, 132, 59, 1),
                      fontFamily: 'Poppins',
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                      height: 1.0800000190734864),
                ),
              ),
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                        child: SelectFormField(
                          controller: globals.controllerFamilyMemberStaying,
                          items: _itemsyesno,
                          onChanged: (String current) {
                            setState(() {
                              current == "Yes"
                                  ? this._familyMember = true
                                  : this._familyMember = false;
                              (context as Element).markNeedsBuild();
                            });
                          },
                          maxLengthEnforced: true,
                          decoration: InputDecoration(
                            isDense: true,
                            hintText: 'Enter...',
                            helperStyle: TextStyle(
                              color: Color.fromRGBO(99, 100, 103, 1),
                              fontFamily: 'Inter',
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                            ),
                            prefixStyle: TextStyle(
                                fontSize: 14,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.bold),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                    width: 2, color: Color(0xff1A203D))),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                    width: 2, color: Color(0xff1A203D))),
                            labelText:
                                'Family members staying in RNB staff Colony? *',
                            labelStyle: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Inter',
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                height: 1.3),
                          ),
                          cursorColor: Color(0xff1A203D),
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter';
                            }
                            return null;
                          },
                        ),
                      ),
                      this._familyMember
                          ? Container(
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        20, 20, 20, 0),
                                    child: SelectFormField(
                                      controller: globals.controllerColony,
                                      items: _itemscolony,
                                      maxLengthEnforced: true,
                                      decoration: InputDecoration(
                                        isDense: true,
                                        hintText: 'Enter...',
                                        helperStyle: TextStyle(
                                          color:
                                              Color.fromRGBO(99, 100, 103, 1),
                                          fontFamily: 'Inter',
                                          fontSize: 12,
                                          fontWeight: FontWeight.normal,
                                        ),
                                        prefixStyle: TextStyle(
                                            fontSize: 14,
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.bold),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            borderSide: BorderSide(
                                                width: 2,
                                                color: Color(0xff1A203D))),
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            borderSide: BorderSide(
                                                width: 2,
                                                color: Color(0xff1A203D))),
                                        labelText: 'Which Colony',
                                        labelStyle: TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'Inter',
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            height: 1.3),
                                      ),
                                      cursorColor: Color(0xff1A203D),
                                      keyboardType: TextInputType.text,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        20, 20, 20, 0),
                                    child: SizedBox(
                                      width: double.infinity,
                                      child: TextButton(
                                          style: TextButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    new BorderRadius.circular(
                                                        10.0),
                                                side: BorderSide(
                                                    color: Colors.black)),
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              Route route = MaterialPageRoute(builder: (context) => Adult());
                                              Navigator.push(context, route).then(onGoBack);
                                              // showDialog(
                                              //   context: context,
                                              //   builder: (BuildContext context) => Adult(),
                                              // );
                                            });
                                          },
                                          child: Text(
                                            'Add Family members',
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                                color: Color.fromRGBO(
                                                    182, 132, 59, 1),
                                                fontSize: 14,
                                                fontFamily: 'Inter'),
                                          )),
                                    ),
                                  ),
                                  ListView.builder(
                                    shrinkWrap: true,
                                    reverse: true,
                                    primary: false,
                                    itemBuilder: (context, position) {
                                      return familyMemberItem(position,globals.familyDetails[position].fPhoto, globals.familyDetails[position].fName, globals.familyDetails[position].fDob, globals.familyDetails[position].fGender);
                                    },
                                    itemCount: globals.familyDetails.length,
                                  )
                                ],
                              ),
                            )
                          : SizedBox(),
                    ],
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 30, 20, 30),
                    child: ClipOval(
                      child: Material(
                        color: Colors.black, // Button color
                        child: InkWell(
                          splashColor: Colors.blueGrey, // Splash color
                          onTap: widget.onbackPress,
                          child: SizedBox(
                              width: 64,
                              height: 64,
                              child: Icon(
                                Icons.arrow_back_ios,
                                color: Colors.white,
                              )),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 30, 20, 30),
                    child: ClipOval(
                      child: Material(
                        color: Colors.black, // Button color
                        child: InkWell(
                          splashColor: Colors.blueGrey, // Splash color
                          onTap: widget.onfrontPress,
                          child: SizedBox(
                              width: 64,
                              height: 64,
                              child: Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.white,
                              )),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
  Image imageFromBase64String(String base64String) {
    return Image.memory(base64Decode(base64String));
  }
  Widget familyMemberItem(position,image,name,age,gender){
    return Padding(
      padding: const EdgeInsets.fromLTRB(
          20, 20, 20, 0),
      child: SizedBox(
        width: double.infinity,
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            Card(
              elevation: 14,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 18, 8, 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(width:50,height: 50,child: ClipOval(child: imageFromBase64String(image),)),
                    SizedBox(width: 10,),
                    Expanded(
                      child: Text(
                        name,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Color.fromRGBO(0, 0, 0, 1),
                          fontFamily: 'Inter',
                          fontSize: 16,
                          letterSpacing:
                          0 /*percentages not used in flutter. defaulting to zero*/,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 2,
                      ),
                    ),
                    SizedBox(width: 20,),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      child: Column(
                        children: [
                          Text(
                            age,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: Color.fromRGBO(0, 0, 0, 1),
                              fontFamily: 'Inter',
                              fontSize: 14,
                              letterSpacing:
                              0 /*percentages not used in flutter. defaulting to zero*/,
                              fontWeight: FontWeight.w300,
                            ),
                            maxLines: 2,
                          ),
                          SizedBox(height: 10,),
                          Text(
                            gender,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: Color.fromRGBO(0, 0, 0, 1),
                              fontFamily: 'Inter',
                              fontSize: 14,
                              letterSpacing:
                              0 /*percentages not used in flutter. defaulting to zero*/,
                              fontWeight: FontWeight.w300,
                            ),
                            maxLines: 2,
                          ),
                        ],
                      ),
                    ),

                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: InkWell(
                  onTap: (){
                    globals.familyDetails.removeAt(position);
                    (context as Element).markNeedsBuild();
                  },
                  child: Icon(Icons.highlight_remove_outlined,color: Colors.red)),
            ),
          ],
        ),
      ),
    );
  }
  FutureOr onGoBack(dynamic value) {
    setState(() {

    });
  }

}


