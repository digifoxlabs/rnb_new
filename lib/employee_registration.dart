import 'package:flutter/material.dart';
import 'package:im_stepper/main.dart';
import 'package:im_stepper/stepper.dart';
import 'package:rnb/forms/formC.dart';
import 'package:rnb/forms/formB.dart';
import 'package:rnb/forms/form_A.dart';
import 'package:rnb/forms/upload_documents.dart';
import 'package:rnb/home_screen_category.dart';
import 'package:rnb/utils/GlobalValues.dart' as globals;
import 'package:shared_preferences/shared_preferences.dart';

import 'home_screen_admin.dart';
import 'models/FamilyDetailModel.dart';
import 'models/NextOfKinModel.dart';


class EmployeeReg extends StatefulWidget {
  const EmployeeReg({Key? key}) : super(key: key);

  @override
  _EmployeeRegState createState() => _EmployeeRegState();
}

class _EmployeeRegState extends State<EmployeeReg> {
  int activeStep = 0;
  int upperBound = 5;



  static TextEditingController nameController = new TextEditingController();

  Future<bool> _onBackPressed() async {
    //part A
     globals.nextOfKinModel = NextOfKin(name: '', address: '');
     globals.relativeModel = NextOfKin(name: '', address: '');
    globals.controllerEmployeeName = new TextEditingController();
    globals.controllerdob = new TextEditingController();
    globals.controllerGender = new TextEditingController();
    globals.controllerMobileNo = new TextEditingController();
    globals.controlleremail_id = new TextEditingController();
    globals.controllercategory = new TextEditingController();
    globals.controllercontractor = new TextEditingController();
    globals.controllerdesignation = new TextEditingController();
    globals.controllerjob_nature = new TextEditingController();
    globals.controllerdoj = new TextEditingController();
    globals.controllertribe = new TextEditingController();
    globals.controllerheight = new TextEditingController();
    globals.controlleryears_in_meghalaya = new TextEditingController();
    globals.controlleridentification_mark = new TextEditingController();
    globals.controllermarital_status = new TextEditingController();
    globals.controllerfathers_name = new TextEditingController();
    globals.controllermothers_name = new TextEditingController();
    globals.controllerreligion = new TextEditingController();
    globals.controllerfamily_members_in_meghalaya = new TextEditingController();
    globals.controllercriminal_record = new TextEditingController();
    globals.controllerpending_criminal_case = new TextEditingController();
    globals.controllersalary_pm = new TextEditingController();
    globals.controllerindia_citizen = new TextEditingController();
    globals.controlleremergency_phone_no = new TextEditingController();
    globals.controllerblood_group = new TextEditingController();
    globals.controllersuffering_from_illness = new TextEditingController();
    globals.controllerstable_mind_declaration = new TextEditingController();
    globals.controllerexpected_duration_of_stay = new TextEditingController();
    globals.controllerother_information = new TextEditingController();
    globals.controllerNextKin = new TextEditingController();
    globals.controllerRelativeInMegh = new TextEditingController();
    globals.controllerother_vaccination_status = new TextEditingController();
    globals.controller_vaccination_first_date = new TextEditingController();
    globals.controller_vaccination_second_date = new TextEditingController();


//part B
    globals.familyDetails = <FamilyDetail>[];
    globals.controllerFamilyMemberStaying = new TextEditingController();
    globals.controllerColony = new TextEditingController();

//part C
    globals.controllerPermanentAddress = new TextEditingController();
    globals.controllerDistrict = new TextEditingController();
    globals.controllerCity = new TextEditingController();
    globals.controllerState = new TextEditingController();
    globals.controllerPinCode = new TextEditingController();
    globals.controllerPostalAddress = new TextEditingController();
    print("removing");
    activeStep = 0;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String role = sharedPreferences.getString("role").toString();
    switch(role) {
      case "admin":
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => HomeScreenAdmin()),
              (Route<dynamic> route) => false,
        );
        break;
      case "subadmin":
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => HomeScreenCategory()),
              (Route<dynamic> route) => false,
        );
        break;
      case "security":
        break;
    }

    return true;
  }


  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Color(0xffECE9E6), Color(0xffFFFFFF)]),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 60, 20, 20),
                child: Text(
                  'Employee Registration',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: Color.fromRGBO(182, 132, 59, 1),
                      fontFamily: 'Poppins',
                      fontSize: 24,
                      letterSpacing:
                      0 /*percentages not used in flutter. defaulting to zero*/,
                      fontWeight: FontWeight.normal,
                      height: 0.9000000158945719),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: IconStepper(
                  enableNextPreviousButtons: false,
                  activeStepColor: Color(0xffB6843B),
                  lineColor: Color(0xffB6843B),
                  icons: [
                    Icon(Icons.person,color: Colors.white,),
                    Icon(Icons.people,color: Colors.white),
                    Icon(Icons.home,color: Colors.white),
                    Icon(Icons.add_photo_alternate,color: Colors.white),
                  ],
                  activeStep: activeStep,

                  // This ensures step-tapping updates the activeStep.
                  onStepReached: (index) {
                    setState(() {
                      activeStep = index;

                    });
                  },


                ),

              ),
              Expanded(
                child: IndexedStack(
                  children: <Widget>[
                    FormA(onfrontPress: (){
                      if(activeStep < upperBound){
                        setState(() {
                          activeStep++;
                        });
                      }
                    },),
                    FormB(onfrontPress: (){
                      if(activeStep < upperBound){
                        setState(() {
                          activeStep++;
                        });
                      }
                    },onbackPress: (){
                      if(activeStep < upperBound){
                        setState(() {
                          activeStep--;
                        });
                      }
                    },),
                    FormC(onfrontPress: (){
                      if(activeStep < upperBound){
                        setState(() {
                          activeStep++;
                        });
                      }
                    },onbackPress: (){
                      if(activeStep < upperBound){
                        setState(() {
                          activeStep--;
                        });
                      }
                    },),
                    UploadDoc(onbackPress: (){
                      if(activeStep < upperBound){
                        setState(() {
                          activeStep--;
                        });
                      }
                    },)
                  ],
                  index: activeStep,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  Widget Form() {
    switch (activeStep) {
      case 0:
        return FormA(onfrontPress: (){
          if(activeStep < upperBound){
            setState(() {
              activeStep++;
            });
          }
        },);

      case 1:
        return FormB(onfrontPress: (){
          if(activeStep < upperBound){
            setState(() {
              activeStep++;
            });
          }
        },onbackPress: (){
          if(activeStep < upperBound){
            setState(() {
              activeStep--;
            });
          }
        },);

      case 2:
        return FormC(onfrontPress: (){
          if(activeStep < upperBound){
            setState(() {
              activeStep++;
            });
          }
        },onbackPress: (){
          if(activeStep < upperBound){
            setState(() {
              activeStep--;
            });
          }
        },);

      case 3:
        return UploadDoc(onbackPress: (){
          if(activeStep < upperBound){
            setState(() {
              activeStep--;
            });
          }
        },);

      default:
        return FormA(onfrontPress: (){

        },);
    }
  }
}


