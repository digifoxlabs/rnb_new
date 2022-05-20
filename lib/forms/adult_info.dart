import 'dart:convert';
import 'dart:io';

import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rnb/models/FamilyDetailModel.dart';
import 'package:select_form_field/select_form_field.dart';
import 'package:rnb/utils/GlobalValues.dart' as globals;


class Adult extends StatefulWidget {
  const Adult({Key? key}) : super(key: key);

  @override
  _AdultState createState() => _AdultState();
}



class _AdultState extends State<Adult> {
  File? _image;
  final picker = ImagePicker();
  final List<Map<String, dynamic>> _itemsgender = [
    {
      'value': 'Male',
      'label': 'Male',
    },
    {
      'value': 'Female',
      'label': 'Female',
    },
  ];

  TextEditingController controllerName = new TextEditingController();
  TextEditingController controllerAge = new TextEditingController();
  TextEditingController _controllerGender = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        child: AlertDialog(
          content: Container(
            width: 300,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: (){
                    _showPicker(context);
                  },
                  child: SizedBox(
                    width: 100,
                    height: 100,
                    child: ClipOval(
                      child: (_image != null)
                          ? Image.file(_image!,fit: BoxFit.cover,)
                          : CircleAvatar(
                        backgroundImage: AssetImage(
                          'images/add_person.png',
                        ),
                      ),
                    ),
                  ),
                  ),
              Padding(
                padding: const EdgeInsets.fromLTRB(
                    0, 20, 0, 0),
                child: TextFormField(
                  controller: controllerName,
                  maxLengthEnforcement: MaxLengthEnforcement.enforced,
                  decoration: InputDecoration(
                    isDense: true,
                    hintText: 'Name',
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
                    labelText: 'Name *',
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
                      0, 20, 0, 0),
                  child: DateTimePicker(
                    controller: controllerAge,
                    type: DateTimePickerType.date,
                    firstDate: DateTime(1950),
                    lastDate: DateTime.now(),
                    decoration: InputDecoration(
                      isDense: true,
                      hintText: 'Enter Birth-Date',
                      helperStyle: TextStyle(
                        color: Color.fromRGBO(99, 100, 103, 1),
                        fontFamily: 'Inter',
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                      ),
                      prefixStyle: TextStyle(fontSize: 14,fontFamily: 'Inter',fontWeight: FontWeight.bold),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(
                              width: 2, color: Color(0xff1A203D))),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(
                              width: 2, color: Color(0xff1A203D))),
                      labelText: 'Date of Birth *',
                      labelStyle: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Inter',
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          height: 1.3
                      ),
                    ),
                    cursorColor: Color(0xff1A203D),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter';
                      }
                      return null;
                    },

                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(00, 20, 00, 0),
                  child: SelectFormField(
                    controller: _controllerGender,
                    items: _itemsgender,
                    maxLengthEnforced: true,
                    decoration: InputDecoration(
                      isDense: true,
                      hintText: 'Enter Gender',
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
                          borderSide:
                          BorderSide(width: 2, color: Color(0xff1A203D))),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide:
                          BorderSide(width: 2, color: Color(0xff1A203D))),
                      labelText: 'Male/Female *',
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
            ],),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Done',style: TextStyle(color: Color.fromRGBO(182, 132, 59, 1)),),
              onPressed: () {
                if(_image != null && controllerName.text != "" && controllerAge != "" && _controllerGender.text != "") {
                  setState(() {
                    globals.familyDetails.add(FamilyDetail(
                        fName: controllerName.text,
                        fDob: controllerAge.text,
                        fGender: _controllerGender.text,
                        fPhoto: base64Encode(_image!.readAsBytesSync())));
                    (context as Element).markNeedsBuild();
                    Navigator.of(context).pop();
                    _image = null;
                    controllerAge.text = '';
                    controllerName.text = "";
                    _controllerGender.text = '';
                  });

                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Future _imgFromCamera() async {
    final image =
    await picker.getImage(source: ImageSource.camera, imageQuality: 20);

    setState(() {
      if (image != null) {
        _cropImage(image);
      } else {
        print('No image selected.');
      }
    });
  }

  Future _imgFromGallery() async {
    final image =
    await picker.getImage(source: ImageSource.gallery, imageQuality: 20);
    setState(() {
      if (image != null) {
        _cropImage(image);

      } else {
        print('No image selected.');
      }
    });
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }
  _cropImage(image) async {
    final croppedFile = await ImageCropper().cropImage(
        sourcePath: image.path,
        aspectRatioPresets: Platform.isAndroid
        ? [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
        ]
        : [
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio5x3,
        CropAspectRatioPreset.ratio5x4,
        CropAspectRatioPreset.ratio7x5,
        CropAspectRatioPreset.ratio16x9
        ],
        // androidUiSettings: AndroidUiSettings(
        //     toolbarTitle: 'Cropper',
        //     toolbarColor: Colors.deepOrange,
        //     toolbarWidgetColor: Colors.white,
        //     initAspectRatio: CropAspectRatioPreset.original,
        //     lockAspectRatio: false),
        // iosUiSettings: IOSUiSettings(
        //   title: 'Cropper',
        // )
        );
    if (croppedFile != null) {
      _image = File(croppedFile.path);
      (context as Element).markNeedsBuild();
    }
  }
  showToast(String msg){
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }
}

