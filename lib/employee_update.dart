import 'package:flutter/material.dart';
import 'package:im_stepper/main.dart';
import 'package:im_stepper/stepper.dart';
import 'package:rnb/forms/formC.dart';
import 'package:rnb/forms/formB.dart';
import 'package:rnb/forms/form_A.dart';
import 'package:rnb/forms/upload_documents.dart';
import 'package:rnb/home_screen_category.dart';
import 'package:rnb/models/getForm%20Models/getFormModel.dart';
import 'package:rnb/utils/GlobalValues.dart' as globals;
import 'package:shared_preferences/shared_preferences.dart';

import 'formsUpdate/formB.dart';
import 'formsUpdate/formC.dart';
import 'formsUpdate/form_A.dart';
import 'formsUpdate/upload_documents.dart';
import 'home_screen_admin.dart';
import 'models/FamilyDetailModel.dart';
import 'models/NextOfKinModel.dart';


class EmployeeUpdate extends StatefulWidget {
  GetFormModel model;
  EmployeeUpdate(@required this.model):assert(model != null);

  @override
  _EmployeeRegState createState() => _EmployeeRegState();
}

class _EmployeeRegState extends State<EmployeeUpdate> {
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
        Navigator.pop(context);
        break;
      case "contractor":
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => HomeScreenCategory()),
              (Route<dynamic> route) => false,
        );
        break;
      case "employee":
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


  setAll(GetFormModel m){
    setState(() {
      globals.nextOfKinModel = NextOfKin(name: m.partA.nextOfKin.name, address: m.partA.nextOfKin.address);
      globals.controllerNextKin.text = m.partA.nextOfKin.name+", "+m.partA.nextOfKin.address;
      globals.relativeModel =  NextOfKin(name: m.partA.relative.name, address: m.partA.relative.address);
      globals.controllerRelativeInMegh.text = m.partA.relative.name+", "+m.partA.relative.address;

      //part B


//part B
      //globals.familyDetails = <FamilyDetail>[];
      //globals.controllerFamilyMemberStaying.text = m.partA.employeeName;
      //globals.controllerColony.text = m.partA.employeeName;

//part C
      globals.controllerPermanentAddress.text = m.partC.permanentAddress;
      globals.controllerDistrict.text = m.partC.district;
      globals.controllerCity.text = m.partC.city;
      globals.controllerState.text = m.partC.state;
      globals.controllerPinCode.text = m.partC.pincode;
      globals.controllerPostalAddress.text = m.partC.postalAddressInMeghalaya;


      //(context as Element).markNeedsBuild();
    });

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setAll(widget.model);
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
                  'Data Update',
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
                    FormAUpdate(onfrontPress: (){
                      if(activeStep < upperBound){
                        setState(() {
                          activeStep++;
                        });
                      }
                    },model: widget.model.partA),
                    FormBUpdate(onfrontPress: (){
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
                    },model: widget.model.partB),
                    FormCUpdate(onfrontPress: (){
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
                    },model: widget.model.partC),
                    UploadDocUpdate(onbackPress: (){
                      if(activeStep < upperBound){
                        setState(() {
                          activeStep--;
                        });
                      }
                    },model: widget.model.partD,empId: widget.model.partA.employeeId,)
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

}


