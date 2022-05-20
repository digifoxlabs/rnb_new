import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rnb/forms/formB.dart';
import 'package:select_form_field/select_form_field.dart';
import 'package:rnb/utils/GlobalValues.dart' as globals;

class Kid extends StatefulWidget {
  const Kid({Key? key}) : super(key: key);

  @override
  _KidState createState() => _KidState();
}

class _KidState extends State<Kid> {
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
              child: CircleAvatar(
                backgroundColor: Colors.black,
                radius: 40.0,
                child: CircleAvatar(
                  radius: 38.0,
                  child: ClipOval(
                    child: (_image != null)
                        ? Image.file(_image!)
                        : Icon(Icons.person),
                  ),
                  backgroundColor: Colors.white,
                ),
              ),
            ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: TextFormField(
                    maxLengthEnforcement: MaxLengthEnforcement.enforced,
                    decoration: InputDecoration(
                      isDense: true,
                      hintText: 'Name',
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
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: TextFormField(
                    maxLengthEnforcement: MaxLengthEnforcement.enforced,
                    decoration: InputDecoration(
                      isDense: true,
                      hintText: 'Age',
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
                      labelText: 'Age *',
                      labelStyle: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Inter',
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          height: 1.3),
                    ),
                    cursorColor: Color(0xff1A203D),
                    keyboardType: TextInputType.number,
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
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'Done',
                style: TextStyle(color: Color.fromRGBO(182, 132, 59, 1)),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }

  Future _imgFromCamera() async {
    final image =
    await picker.getImage(source: ImageSource.camera, imageQuality: 50);

    setState(() {
      if (image != null) {
        _image = File(image.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future _imgFromGallery() async {
    final image =
    await picker.getImage(source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      if (image != null) {
        _image = File(image.path);
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
}
