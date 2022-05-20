import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:rnb/forms/formB.dart';
import 'package:rnb/home_screen_category.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rnb/models/PartAModel.dart';
import 'package:rnb/models/PartBModel.dart';
import 'package:rnb/models/PartCModel.dart';
import 'package:rnb/models/PartDModel.dart';
import 'package:rnb/models/Vaccination.dart';
import 'package:rnb/models/formModel.dart';
import 'package:rnb/utils/GlobalValues.dart' as globals;
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';


class UploadDoc extends StatefulWidget {
  final VoidCallback onbackPress;
  const UploadDoc({Key? key, required this.onbackPress}) : super(key: key);

  @override
  _UploadDocState createState() => _UploadDocState();
}

class _UploadDocState extends State<UploadDoc> {
  File? _imageProfilePic,_imageId;
  String? _imageProfilePics,_imageIds;
  final picker = ImagePicker();

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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                        child: Text(
                          'Upload Your Documents',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: Color.fromRGBO(182, 132, 59, 1),
                              fontFamily: 'Poppins',
                              fontSize: 20,
                              fontWeight: FontWeight.normal,
                              height: 1.0800000190734864),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                    child: SizedBox(
                      width: 200,
                      height: 200,
                      child: GestureDetector(
                          onTap: () {
                            _showPicker(context,0);
                          },
                          child: _imageProfilePic != null
                              ? Image.file(_imageProfilePic!, fit: BoxFit.contain)
                              : Icon(Icons.photo_camera_rounded,size: 100,color: Color.fromRGBO(182, 132, 59, 1),)),
                    ),
                  ),
                  Center(child: Text("Set profile picture",style: TextStyle(fontSize:15,fontWeight: FontWeight.bold,color: Colors.red),)),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                    child: SizedBox(
                      width: 200,
                      height: 200,
                      child: GestureDetector(
                          onTap: () {
                            _showPicker(context,1);
                          },
                          child: _imageId != null
                              ? Image.file(_imageId!, fit: BoxFit.contain)
                              : Icon(Icons.art_track_sharp,size: 100,color: Color.fromRGBO(182, 132, 59, 1),)),
                    ),
                  ),
                  Center(child: Text("Set Id Proof(adhaar card, driving license, passport)",style: TextStyle(fontSize:15,fontWeight: FontWeight.bold,color: Colors.red),)),

                ],
              ),
              Align(
                alignment: FractionalOffset.bottomCenter,
                child: Row(
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
                            onTap: () {
                              if(globals.controllerEmployeeName.text == ''
                              || globals.controllerdob.text == ''
                                  || globals.controllerGender.text == ''
                                  || globals.controllerMobileNo.text == ''
                                  || globals.controllercategory.text == ''
                                  //|| globals.controllercontractor.text == ''
                                  || globals.controllerdesignation.text == ''
                                  || globals.controllertribe.text == ''
                                  || globals.controllermarital_status.text == ''
                                  || globals.controllerfathers_name.text == ''
                                  || globals.controllermothers_name.text == ''
                                  || globals.controllerreligion.text == ''
                                  || globals.controllerfamily_members_in_meghalaya.text == ''
                                  || globals.controllercriminal_record.text == ''
                                  || globals.controllerpending_criminal_case.text == ''

                                  || globals.controllersalary_pm.text == ''
                                  || globals.controllerindia_citizen.text == ''
                                  || globals.controllerexpected_duration_of_stay.text == ''
                                  || globals.controllerNextKin.text == ''
                                  || globals.controllerFamilyMemberStaying.text == ''
                                  || globals.controllerPermanentAddress.text == ''
                                  || globals.controllerDistrict.text == ''
                                  || globals.controllerCity.text == ''
                                  || globals.controllerState.text == ''
                                  || globals.controllerPinCode.text == ''
                                  || globals.controllerother_vaccination_status.text == ''
                              ){
                                showToast("empty field. Please check your form again.");
                              }else {
                                if(globals.controllerother_vaccination_status.text == 'yes'){
                                  if(globals.controller_vaccination_first_date.text == ''){
                                    showToast("Please enter first vaccination dose date");
                                  }else{
                                    startUploading();
                                  }
                                }else{
                                  startUploading();
                                }

                              }
                            },
                            child: SizedBox(
                                width: 64,
                                height: 64,
                                child: Center(
                                  child: Text(
                                    'Done',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Poppins'),
                                  ),
                                )),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future _imgFromCamera(int id) async {
    final image =
        await picker.getImage(source: ImageSource.camera, imageQuality: 20);

    setState(() {
      if (image != null) {
        _cropImage(image,id);
      } else {
        print('No image selected.');
      }
    });
  }

  Future _imgFromGallery(int id) async {
    final image =
        await picker.getImage(source: ImageSource.gallery, imageQuality: 20);
      if (image != null) {
        _cropImage(image,id);

      } else {
        print('No image selected.');
      }
  }
  _cropImage(image,id) async {
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
    setState(() {
      if (croppedFile != null) {
        switch(id){
          case 0:
            _imageProfilePic = File(croppedFile.path);
            _imageProfilePics = base64Encode(File(croppedFile.path).readAsBytesSync());
            break;
          case 1:
            _imageId = File(croppedFile.path);
            _imageIds = base64Encode(File(croppedFile.path).readAsBytesSync());
            break;
        }
      }
    });

  }
















  void _showPicker(context,int id) {
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
                        _imgFromGallery(id);
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera(id);
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  startUploading() async{
    ProgressDialog pr = ProgressDialog(context);
    pr.style(message: "uploading data...");
    pr.show();
    //showToast("Uploading data...");
    PartA partA = PartA(employeeName: globals.controllerEmployeeName.text,
        dob: globals.controllerdob.text,
        gender: globals.controllerGender.text,
        mobileNo: globals.controllerMobileNo.text,
        emailId: globals.controlleremail_id.text,
        category: globals.controllercategory.text,
        contractor: globals.controllercontractor.text,
        designation: globals.controllerdesignation.text,
        jobNature: globals.controllerjob_nature.text,
        doj: globals.controllerdoj.text,
        tribe: globals.controllertribe.text,
        height: globals.controllerheight.text,
        yearsInMeghalaya: globals.controlleryears_in_meghalaya.text,
        identificationMark: globals.controlleridentification_mark.text,
        maritalStatus: globals.controllermarital_status.text,
        fathersName: globals.controllerfathers_name.text,
        mothersName: globals.controllermothers_name.text,
        religion: globals.controllerreligion.text,
        familyMembersInMeghalaya: globals.controllerFamilyMemberStaying.text,
        criminalRecord: globals.controllercriminal_record.text,
        pendingCriminalCase: globals.controllerpending_criminal_case.text,
        salaryPm: globals.controllersalary_pm.text,
        indiaCitizen: globals.controllerindia_citizen.text,
        emergencyPhoneNo: globals.controlleremergency_phone_no.text,
        bloodGroup: globals.controllerblood_group.text,
        sufferingFromIllness: globals.controllersuffering_from_illness.text,
        stableMindDeclaration: globals.controllerstable_mind_declaration.text,
        expectedDurationOfStay: globals.controllerexpected_duration_of_stay.text,
        otherInformation: globals.controllerother_information.text,
        nextOfKin: globals.nextOfKinModel,
        relative: globals.relativeModel,
        vaccination: Vaccination(
            status:globals.controllerother_vaccination_status.text,
            firstDose: globals.controller_vaccination_first_date.text,
            secondDose: globals.controller_vaccination_second_date.text)
    );


    PartB partB = PartB(colonyName: globals.controllerColony.text,
        familyDetails: globals.familyDetails);
    PartC partC = PartC(permanentAddress: globals.controllerPermanentAddress.text,
        district: globals.controllerDistrict.text,
        city: globals.controllerCity.text,
        state: globals.controllerState.text,
        pincode: globals.controllerPinCode.text,
        postalAddressInMeghalaya: globals.controllerPostalAddress.text);
    PartD partD = PartD(photoUrl: _imageProfilePics!, idProofUrl: _imageIds!);

    FormModel model = FormModel(partA: partA, partB: partB, partC: partC, partD: partD);
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var data = { "user_id": sharedPreferences.getString("id"), "username": sharedPreferences.getString("username"), "data":model};
    var jsonResponse = null;

    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('admin:1234'));
    var response = await post(Uri.parse("http://api.rnbgroup.org/api/labour/entry"),
        body: jsonEncode(data),
        headers: <String, String>{
          'authorization': basicAuth,
          'X-API-KEY':'rnb_app',
        }).timeout(const Duration(minutes: 2));
    pr.hide();
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      if (jsonResponse != null) {
        if (jsonResponse["status"] == false) {

          showToast("Something went wrong. Please try again");
        } else {
          showToast("Uploaded successfully");
          print(response.body);
          Navigator.of(context).pop();
          // Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //         builder: (context) =>
          //             HomeScreenCategory()));
        }
      }
    }
    else {
      showToast("Something went wrong. Please try again");
      print(response.body);
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
