import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/services.dart';
import 'package:rnb/forms/formC.dart';
import 'package:rnb/forms/nextOfKin_info.dart';
import 'package:rnb/forms/relative_info.dart';
import 'package:rnb/home_screen_category.dart';
import 'package:rnb/models/formModel.dart';
import 'package:rnb/models/getForm%20Models/getPartA.dart';
import 'package:select_form_field/select_form_field.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../employee_registration.dart';
import 'package:rnb/utils/GlobalValues.dart' as globals;
import 'package:http/http.dart';


class FormAUpdate extends StatefulWidget {
  final VoidCallback onfrontPress;
  final PartAGet model;
  const FormAUpdate({Key? key,required this.onfrontPress,required this.model}) : super(key: key);

  @override
  _PersonalFormState createState() => _PersonalFormState();
}

class _PersonalFormState extends State<FormAUpdate> {
  final _formKey = GlobalKey<FormState>();


  bool _vaccineStatus = false;

  List<Map<String, dynamic>> _itemCategory = [];
 List<Map<String, dynamic>> _itemContractor = [];



  final List<Map<String, dynamic>> _itemsjob = [];
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
  final List<Map<String, dynamic>> _itemstribe = [
    {
      'value': 'Local Tribal',
      'label': 'Local Tribal',
    },
    {
      'value': 'Non Tribal',
      'label': 'Non Tribal',
    },
  ];
  final List<Map<String, dynamic>> _itemsmarried = [
    {
      'value': 'Married',
      'label': 'Married',
    },
    {
      'value': 'Unmarried',
      'label': 'Unmarried',
    },
  ];
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



  late String curr_username,curr_id,curr_role;

  @override
  void initState() {
    super.initState();
    getCategory();
    getJob();
    getContractor();


    globals.controllerEmployeeName.text = widget.model.employeeName;
    globals.controllerdob.text = widget.model.dob.toString();
    //globals.controllerGender.text = m.partA.employeeName;
    globals.controllerMobileNo.text = widget.model.mobileNo;
    globals.controlleremail_id.text = widget.model.emailId;
    //globals.controllercategory.text = m.partA.employeeName;
    //globals.controllercontractor.text = m.partA.employeeName;
    globals.controllerdesignation.text = widget.model.designation;
    //globals.controllerjob_nature.text = m.partA.employeeName;
    globals.controllerdoj.text = widget.model.doj.toString();
    //globals.controllertribe.text = m.partA.employeeName;
    globals.controllerheight.text = widget.model.height;
    globals.controlleryears_in_meghalaya.text = widget.model.yearsInMeghalaya;
    globals.controlleridentification_mark.text = widget.model.identificationMark;

    globals.controllerfathers_name.text = widget.model.fathersName;
    globals.controllermothers_name.text = widget.model.mothersName;
    globals.controllerreligion.text = widget.model.religion;
    globals.controllerfamily_members_in_meghalaya.text = widget.model.familyMembersInMeghalaya;
    //globals.controllercriminal_record.text = m.partA.employeeName;
    //globals.controllerpending_criminal_case.text = m.partA.employeeName;
    globals.controllersalary_pm.text = widget.model.salaryPm;
    //globals.controllerindia_citizen.text = m.partA.employeeName;
    globals.controlleremergency_phone_no.text = widget.model.emergencyPhoneNo;
    globals.controllerblood_group.text = widget.model.bloodGroup;
    globals.controllersuffering_from_illness.text = widget.model.sufferingFromIllness;
    //globals.controllerstable_mind_declaration.text = m.partA.employeeName;
    globals.controllerexpected_duration_of_stay.text = widget.model.expectedDurationOfStay;
    globals.controllerother_information.text = widget.model.otherInformation;

    globals.controllerGender.text = widget.model.gender;
    globals.controllertribe.text = widget.model.tribe;
    globals.controllermarital_status.text = widget.model.maritalStatus;
    globals.controllercriminal_record.text = widget.model.criminalRecord;
    globals.controllerpending_criminal_case.text = widget.model.pendingCriminalCase;
    globals.controllerindia_citizen.text = widget.model.indiaCitizen;
    globals.controllerstable_mind_declaration.text = widget.model.stableMindDeclaration;
     globals.controllerother_vaccination_status.text = widget.model.vaccination.status;
    if(widget.model.vaccination.status == "Yes"){
      _vaccineStatus = true;
      globals.controller_vaccination_first_date.text = widget.model.vaccination.firstDose;
      globals.controller_vaccination_second_date.text = widget.model.vaccination.secondDose;
      (context as Element).markNeedsBuild();
    }
  }

  Future<void> getCategory() async {
    var jsonResponse = null;
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('admin:1234'));
    var response = await get(Uri.parse("https://rnb.digifoxlabs.com/api/category/view"),
        headers: <String, String>{
          'authorization': basicAuth,
          'X-API-KEY':'rnb_app',
        });
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      if (jsonResponse != null) {
        if (jsonResponse["status"] != false) {
          print(response.body);
          bool exist = false;
          int pos = 0;
          for(int i = 0;i < jsonResponse["message"].length; i++){
            _itemCategory.add({
              'value': jsonResponse["message"][i]["cat_id"],
              'label': jsonResponse["message"][i]["cat_name"],
            });
            if(jsonResponse["message"][i]["cat_name"] == widget.model.category.categoryName){
              exist = true;
              pos = i;
            }
          }
          if(exist){

            globals.controllercategory.text = _itemCategory.elementAt(pos)["value"];
            (context as Element).markNeedsBuild();
          }


        }
      }
    }
    else {
      print(response.body);
    }
  }
  Future<void> getJob() async {
    var jsonResponse = null;
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('admin:1234'));
    var response = await get(Uri.parse("https://rnb.digifoxlabs.com/api/job/view"),
        headers: <String, String>{
          'authorization': basicAuth,
          'X-API-KEY':'rnb_app',
        });
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      if (jsonResponse != null) {
        if (jsonResponse["status"] != false) {
          print(response.body);
          bool exist = false;
          int pos = 0;
          for(int i = 0;i < jsonResponse["message"].length; i++){
            _itemsjob.add({
              'value': jsonResponse["message"][i]["j_id"],
              'label': jsonResponse["message"][i]["job_name"],
            });
            if(jsonResponse["message"][i]["job_name"] == widget.model.jobNature.jobNatureName){
              exist = true;
              pos = i;
            }
          }
          if(exist){

            globals.controllerjob_nature.text = _itemsjob.elementAt(pos)["value"];
            (context as Element).markNeedsBuild();
          }

        }
      }
    }
    else {
      print(response.body);
    }
  }
  Future<void> getContractor() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    curr_username = sharedPreferences.getString("username")!;
    curr_id = sharedPreferences.getString("id")!;
    curr_role = sharedPreferences.getString("role")!;



    var jsonResponse = null;
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('admin:1234'));
    var response = await get(Uri.parse("https://rnb.digifoxlabs.com/api/Contractor/view"),
        headers: <String, String>{
          'authorization': basicAuth,
          'X-API-KEY':'rnb_app',
        });
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      if (jsonResponse != null) {
        if (jsonResponse["status"] != false) {
          print(response.body);
          bool exist = false;
          int pos = 0;
          for(int i = 0;i < jsonResponse["message"].length; i++){
            _itemContractor.add({
              'value': jsonResponse["message"][i]["con_id"],
              'label': jsonResponse["message"][i]["con_name"],
            });
            if(jsonResponse["message"][i]["con_name"] == widget.model.contractor.contractorName){
              exist = true;
              pos = i;
            }
          }
          if(exist){
            globals.controllercontractor.text = _itemContractor.elementAt(pos)["value"];
            (context as Element).markNeedsBuild();
          }

          //globals.controllercontractor.text = widget.model.contractor.contractorName;
        }
      }
    }
    else {
      print(response.body);
    }
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
                  'Personal Information',
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
                        child: TextFormField(
                          controller: globals.controllerEmployeeName,
                          maxLengthEnforcement: MaxLengthEnforcement.enforced,
                          decoration: InputDecoration(
                            isDense: true,
                            hintText: 'Enter employee Name',
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
                            labelText: 'Name of Employee *',
                            labelStyle: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Inter',
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                height: 1.3
                            ),
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
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                        child: DateTimePicker(
                          controller: globals.controllerdob,
                          type: DateTimePickerType.date,
                          firstDate: DateTime(1950),
                          lastDate: DateTime.now(),
                          decoration: InputDecoration(
                            isDense: true,
                            hintText: 'Enter Your Birth-Date',
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
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                        child: SelectFormField(
                          controller: globals.controllerGender,
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
                            prefixStyle: TextStyle(fontSize: 14,fontFamily: 'Inter',fontWeight: FontWeight.bold),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                    width: 2, color: Color(0xff1A203D))),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                    width: 2, color: Color(0xff1A203D))),
                            labelText: 'Male/Female *',
                            labelStyle: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Inter',
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                height: 1.3
                            ),
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
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                        child: TextFormField(
                          controller: globals.controllerMobileNo,
                          maxLengthEnforcement: MaxLengthEnforcement.enforced,
                          decoration: InputDecoration(
                            isDense: true,
                            hintText: 'Enter Your Mobile No.',
                            helperStyle: TextStyle(
                              color: Color.fromRGBO(99, 100, 103, 1),
                              fontFamily: 'Inter',
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                            ),
                            prefixText: '+91 ',
                            prefixStyle: TextStyle(fontSize: 14,fontFamily: 'Inter',fontWeight: FontWeight.bold),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                    width: 2, color: Color(0xff1A203D))),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                    width: 2, color: Color(0xff1A203D))),
                            labelText: 'Mobile no. *',
                            labelStyle: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Inter',
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                height: 1.3
                            ),
                          ),
                          cursorColor: Color(0xff1A203D),
                          keyboardType: TextInputType.phone,

                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter';
                            }
                            return null;
                          },

                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                        child: TextFormField(
                          controller: globals.controlleremail_id,
                          maxLengthEnforcement: MaxLengthEnforcement.enforced,
                          decoration: InputDecoration(
                            isDense: true,
                            hintText: 'Enter Your E-mail',
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
                            labelText: 'E-mail Id',
                            labelStyle: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Inter',
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                height: 1.3
                            ),
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
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                        child: SelectFormField(
                          controller: globals.controllercategory,
                          items: _itemCategory,
                          maxLengthEnforced: true,
                          decoration: InputDecoration(
                            isDense: true,
                            hintText: 'Category',
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
                            labelText: 'Category *',
                            labelStyle: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Inter',
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                height: 1.3
                            ),
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
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                        child: SelectFormField(
                          controller: globals.controllercontractor,
                          items: _itemContractor,
                          maxLengthEnforced: true,
                          decoration: InputDecoration(
                            isDense: true,
                            hintText: 'Contractor',
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
                            labelText: 'Contractor',
                            labelStyle: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Inter',
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                height: 1.3
                            ),
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
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                        child: TextFormField(
                          controller: globals.controllerdesignation,
                          maxLengthEnforcement: MaxLengthEnforcement.enforced,
                          decoration: InputDecoration(
                            isDense: true,
                            hintText: 'Enter Your Designation',
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
                            labelText: 'Designation *',
                            labelStyle: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Inter',
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                height: 1.3
                            ),
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
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                        child: SelectFormField(
                          controller: globals.controllerjob_nature,
                          items: _itemsjob,
                          maxLengthEnforced: true,
                          decoration: InputDecoration(
                            isDense: true,
                            hintText: 'Enter Nature Of Job',
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
                            labelText: 'Nature Of Job',
                            labelStyle: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Inter',
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                height: 1.3
                            ),
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
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                        child: DateTimePicker(
                          controller: globals.controllerdoj,
                          type: DateTimePickerType.date,
                          firstDate: DateTime(1950),
                          lastDate: DateTime.now(),
                          decoration: InputDecoration(
                            isDense: true,
                            hintText: 'Enter Your Date Of Joining',
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
                            labelText: 'Date of Joining in unit',
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
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                        child: SelectFormField(
                          controller: globals.controllertribe,
                          items: _itemstribe,
                          maxLengthEnforced: true,
                          decoration: InputDecoration(
                            isDense: true,
                            hintText: 'Enter Local Tribal/Non Tribal *',
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
                            labelText: 'Local Tribal/Non Tribal *',
                            labelStyle: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Inter',
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                height: 1.3
                            ),
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
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                        child: TextFormField(
                          controller: globals.controllerheight,
                          maxLengthEnforcement: MaxLengthEnforcement.enforced,
                          decoration: InputDecoration(
                            isDense: true,
                            hintText: 'Enter Your Height',
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
                            labelText: 'Height *',
                            labelStyle: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Inter',
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                height: 1.3
                            ),
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
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                        child: TextFormField(
                          controller: globals.controlleryears_in_meghalaya,
                          maxLengthEnforcement: MaxLengthEnforcement.enforced,
                          decoration: InputDecoration(
                            isDense: true,
                            hintText: 'Enter...',
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
                            labelText: 'Number of years residing in Meghalaya *',
                            labelStyle: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Inter',
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                height: 1.3
                            ),
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
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                        child: TextFormField(
                          controller: globals.controlleridentification_mark,
                          maxLengthEnforcement: MaxLengthEnforcement.enforced,
                          decoration: InputDecoration(
                            isDense: true,
                            hintText: 'Enter Identification mark',
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
                            labelText: 'Identification Mark',
                            labelStyle: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Inter',
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                height: 1.3
                            ),
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
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                        child: SelectFormField(
                          controller: globals.controllermarital_status,
                          items: _itemsmarried,
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
                            prefixStyle: TextStyle(fontSize: 14,fontFamily: 'Inter',fontWeight: FontWeight.bold),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                    width: 2, color: Color(0xff1A203D))),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                    width: 2, color: Color(0xff1A203D))),
                            labelText: 'Married/unmarried *',
                            labelStyle: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Inter',
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                height: 1.3
                            ),
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
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                        child: TextFormField(
                          controller: globals.controllerfathers_name,
                          maxLengthEnforcement: MaxLengthEnforcement.enforced,
                          decoration: InputDecoration(
                            isDense: true,
                            hintText: 'Enter Father\'s name',
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
                            labelText: 'Father\'s name *',
                            labelStyle: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Inter',
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                height: 1.3
                            ),
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
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                        child: TextFormField(
                          controller: globals.controllermothers_name,
                          maxLengthEnforcement: MaxLengthEnforcement.enforced,
                          decoration: InputDecoration(
                            isDense: true,
                            hintText: 'Enter Mother\'s name',
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
                            labelText: 'Mother\'s name *',
                            labelStyle: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Inter',
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                height: 1.3
                            ),
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
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                        child: TextFormField(
                          controller: globals.controllerreligion,
                          maxLengthEnforcement: MaxLengthEnforcement.enforced,
                          decoration: InputDecoration(
                            isDense: true,
                            hintText: 'Enter Community/Religion',
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
                            labelText: 'Community/Religion *',
                            labelStyle: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Inter',
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                height: 1.3
                            ),
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
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                        child: TextFormField(
                          controller: globals.controllerfamily_members_in_meghalaya,
                          maxLengthEnforcement: MaxLengthEnforcement.enforced,
                          decoration: InputDecoration(
                            isDense: true,
                            hintText: 'No of family members residing in Meghalaya',
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
                            labelText: 'No. of family members residing in Meghalaya *',
                            labelStyle: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Inter',
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                height: 1.3
                            ),
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
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                        child: SelectFormField(
                          controller: globals.controllercriminal_record,
                          items: _itemsyesno,
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
                            prefixStyle: TextStyle(fontSize: 14,fontFamily: 'Inter',fontWeight: FontWeight.bold),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                    width: 2, color: Color(0xff1A203D))),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                    width: 2, color: Color(0xff1A203D))),
                            labelText: 'Convicted with a criminal case at any time *',
                            labelStyle: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Inter',
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                height: 1.3
                            ),
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
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                        child: SelectFormField(
                          controller: globals.controllerpending_criminal_case,
                          items: _itemsyesno,
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
                            prefixStyle: TextStyle(fontSize: 14,fontFamily: 'Inter',fontWeight: FontWeight.bold),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                    width: 2, color: Color(0xff1A203D))),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                    width: 2, color: Color(0xff1A203D))),
                            labelText: 'Any criminal pending case against him/her *',
                            labelStyle: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Inter',
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                height: 1.3
                            ),
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
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                        child: TextFormField(
                          controller: globals.controllersalary_pm,
                          maxLengthEnforcement: MaxLengthEnforcement.enforced,
                          decoration: InputDecoration(
                            isDense: true,
                            hintText: 'Enter Salary Per Month',
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
                            labelText: 'Salary per month *',
                            labelStyle: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Inter',
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                height: 1.3
                            ),
                          ),
                          cursorColor: Color(0xff1A203D),
                          keyboardType: TextInputType.numberWithOptions(decimal: true),

                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter';
                            }
                            return null;
                          },

                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                        child: SelectFormField(
                          controller: globals.controllerindia_citizen,
                          items: _itemsyesno,
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
                            prefixStyle: TextStyle(fontSize: 14,fontFamily: 'Inter',fontWeight: FontWeight.bold),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                    width: 2, color: Color(0xff1A203D))),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                    width: 2, color: Color(0xff1A203D))),
                            labelText: 'Are you a citizen of India *',
                            labelStyle: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Inter',
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                height: 1.3
                            ),
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
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                        child: TextFormField(
                          controller: globals.controlleremergency_phone_no,
                          maxLengthEnforcement: MaxLengthEnforcement.enforced,
                          decoration: InputDecoration(
                            isDense: true,
                            hintText: 'Enter Emergency contact number',
                            helperStyle: TextStyle(
                              color: Color.fromRGBO(99, 100, 103, 1),
                              fontFamily: 'Inter',
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                            ),
                            prefixText: '+91 ',
                            prefixStyle: TextStyle(fontSize: 14,fontFamily: 'Inter',fontWeight: FontWeight.bold),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                    width: 2, color: Color(0xff1A203D))),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                    width: 2, color: Color(0xff1A203D))),
                            labelText: 'Emergency contact number',
                            labelStyle: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Inter',
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                height: 1.3
                            ),
                          ),
                          cursorColor: Color(0xff1A203D),
                          keyboardType: TextInputType.phone,

                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter';
                            }
                            return null;
                          },

                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                        child: TextFormField(
                          controller: globals.controllerblood_group,
                          maxLengthEnforcement: MaxLengthEnforcement.enforced,
                          decoration: InputDecoration(
                            isDense: true,
                            hintText: 'Enter Blood Group',
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
                            labelText: 'Blood Group',
                            labelStyle: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Inter',
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                height: 1.3
                            ),
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
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                        child: TextFormField(
                          controller: globals.controllersuffering_from_illness,
                          maxLengthEnforcement: MaxLengthEnforcement.enforced,
                          decoration: InputDecoration(
                            isDense: true,
                            hintText: 'Are you suffering from any illness (please specify)',
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
                            labelText: 'Are you suffering from any illness (please specify) *',
                            labelStyle: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Inter',
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                height: 1.3
                            ),
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
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                        child: SelectFormField(
                          controller: globals.controllerstable_mind_declaration,
                          items: _itemsyesno,
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
                            prefixStyle: TextStyle(fontSize: 14,fontFamily: 'Inter',fontWeight: FontWeight.bold),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                    width: 2, color: Color(0xff1A203D))),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                    width: 2, color: Color(0xff1A203D))),
                            labelText: 'Declaration that you are of a stable mind',
                            labelStyle: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Inter',
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                height: 1.3
                            ),
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
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                        child: TextFormField(
                          controller: globals.controllerexpected_duration_of_stay,
                          maxLengthEnforcement: MaxLengthEnforcement.enforced,
                          decoration: InputDecoration(
                            isDense: true,
                            hintText: 'Expected duration of stay in Plant',
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
                            labelText: 'Expected duration of stay in Plant *',
                            labelStyle: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Inter',
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                height: 1.3
                            ),
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
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                        child: TextFormField(
                          controller: globals.controllerother_information,
                          maxLengthEnforcement: MaxLengthEnforcement.enforced,
                          decoration: InputDecoration(
                            isDense: true,
                            hintText: 'Any other information',
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
                            labelText: 'Any other information',
                            labelStyle: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Inter',
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                height: 1.3
                            ),
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
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                        child: TextFormField(
                          readOnly: true,
                          controller: globals.controllerNextKin,
                          maxLengthEnforcement: MaxLengthEnforcement.enforced,
                          onTap: (){
                            setState(() {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) => nextOfKin(),
                              );

                            });
                          },
                          decoration: InputDecoration(
                            isDense: true,
                            hintText: 'Enter...',
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
                            labelText: 'Particulars of the next kin in home state *',
                            labelStyle: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Inter',
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                height: 1.3
                            ),
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
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                        child: TextFormField(
                          readOnly: true,
                          controller: globals.controllerRelativeInMegh,
                          maxLengthEnforcement: MaxLengthEnforcement.enforced,
                          onTap: (){
                          setState(() {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) => relative(),
                            );

                          });
                        },
                          decoration: InputDecoration(
                            isDense: true,
                            hintText: 'Enter...',
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
                            labelText: 'Particulars of any relative/friend in Meghalaya',
                            labelStyle: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Inter',
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                height: 1.3
                            ),
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
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                        child: SelectFormField(
                          controller: globals.controllerother_vaccination_status,
                          items: _itemsyesno,
                          onChanged: (String current) {
                            setState(() {
                              if(current == "Yes") {
                                this._vaccineStatus = true;
                              }else{
                                globals.controller_vaccination_first_date.text = '';
                                globals.controller_vaccination_second_date.text = '';
                                this._vaccineStatus = false;
                              }
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
                            'Vaccinated or not *',
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
                      this._vaccineStatus
                          ? Container(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                              child: DateTimePicker(
                                controller: globals.controller_vaccination_first_date,
                                type: DateTimePickerType.date,
                                firstDate: DateTime(1950),
                                lastDate: DateTime.now(),
                                decoration: InputDecoration(
                                  isDense: true,
                                  hintText: 'Date of First Vaccine dose',
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
                                  labelText: 'Date of First Vaccine dose',
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
                              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                              child: DateTimePicker(
                                controller: globals.controller_vaccination_second_date,
                                type: DateTimePickerType.date,
                                firstDate: DateTime(1950),
                                lastDate: DateTime.now(),
                                decoration: InputDecoration(
                                  isDense: true,
                                  hintText: 'Date of Second Vaccine dose',
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
                                  labelText: 'Date of Second Vaccine dose',
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
                          ],
                        ),
                      )
                          : SizedBox(),
                    ],
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 30, 20, 30),
                    child: ClipOval(
                      child: Material(
                        color: Colors.black, // Button color
                        child: InkWell(
                          splashColor: Colors.blueGrey, // Splash color
                          onTap:widget.onfrontPress,
                          child: SizedBox(width: 64, height: 64, child: Icon(Icons.arrow_forward_ios,color: Colors.white,)),
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

}

