import 'package:flutter/material.dart';
import 'package:rnb/models/getForm Models/getPartA.dart';
import 'package:intl/intl.dart';
class PersonalInfo extends StatefulWidget {
  PartAGet formModel;
  PersonalInfo(@required this.formModel) :assert(formModel != null);
  @override
  _PersonalInfoState createState() => _PersonalInfoState();
}

class _PersonalInfoState extends State<PersonalInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
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
                    'Personal Info',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Color.fromRGBO(182, 132, 59, 1),
                        fontFamily: 'Poppins',
                        fontSize: 24,
                        fontWeight: FontWeight.normal,
                        height: 0.9000000158945719),
                  ),
                ),
                InfoField(string1: 'Name',string2: widget.formModel.employeeName,),
                InfoField(string1: 'Particulars of the next kin of the applicant in home state',string2: widget.formModel.nextOfKin.name+", "+widget.formModel.nextOfKin.address,),
                InfoField(string1: "Particulars of any relative/friend of the applicant in Meghalaya", string2: widget.formModel.relative.name+", "+widget.formModel.relative.address),
                InfoField(string1: "Date of Birth", string2: DateFormat('yyyy-MM-dd').format(widget.formModel.dob)),
                InfoField(string1: 'Designation', string2: widget.formModel.designation),
                InfoField(string1: 'Mobile No', string2: widget.formModel.mobileNo),
                InfoField(string1: 'Email Id', string2: widget.formModel.emailId),
                InfoField(string1: 'Contractor', string2: widget.formModel.contractor.contractorName!= null?widget.formModel.contractor.contractorName:"_"),
                InfoField(string1: 'Category', string2: widget.formModel.category.categoryName!= null?widget.formModel.category.categoryName:"_"),
                InfoField(string1: 'Nature of Job', string2: widget.formModel.jobNature.jobNatureName!= null?widget.formModel.jobNature.jobNatureName:"_"),
                InfoField(string1: 'Gender', string2: widget.formModel.gender),
                InfoField(string1: 'Date of Joining in unit', string2: DateFormat('yyyy-MM-dd').format(widget.formModel.doj)),
                InfoField(string1: 'Local Tribal/Non Tribal', string2: widget.formModel.tribe),
                InfoField(string1: 'Height', string2: widget.formModel.height),
                InfoField(string1: 'Number of years residing in Meghalaya ', string2: widget.formModel.yearsInMeghalaya),
                InfoField(string1: 'Identification Mark', string2: widget.formModel.identificationMark),
                InfoField(string1: 'Marital Status', string2: widget.formModel.maritalStatus),
                InfoField(string1: 'Father\'s name', string2: widget.formModel.fathersName),
                InfoField(string1: 'Mother\'s name', string2: widget.formModel.mothersName),
                InfoField(string1: 'Community/Religion', string2: widget.formModel.religion),
                InfoField(string1: 'No of family members residing in Meghalaya', string2: widget.formModel.familyMembersInMeghalaya),
                InfoField(string1: 'Whether convicted with a criminal case at any time', string2: widget.formModel.criminalRecord),
                InfoField(string1: 'Any criminal pending case against him/her', string2: widget.formModel.pendingCriminalCase),
                InfoField(string1: 'Salary per month', string2: widget.formModel.salaryPm),
                InfoField(string1: 'Are you a citizen of India', string2: widget.formModel.indiaCitizen),
                InfoField(string1: 'Emergency contact number', string2: widget.formModel.emergencyPhoneNo),
                InfoField(string1: 'Blood Group', string2: widget.formModel.bloodGroup),
                InfoField(string1: 'Are you suffering from any illness', string2: widget.formModel.sufferingFromIllness),
                InfoField(string1: 'Declaration that you are of a stable mind', string2: widget.formModel.stableMindDeclaration),
                InfoField(string1: 'Expected duration of stay in Plant', string2: widget.formModel.expectedDurationOfStay),
                InfoField(string1: 'Any other information', string2: widget.formModel.otherInformation),




              ],
            ),
          ),
        ),
      ),
    );
  }
}

class InfoField extends StatelessWidget {
  InfoField({required this.string1,required this.string2});

  final String string1;
  final String string2;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            child: Text(
              string1,
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: Colors.grey[500],
                  fontFamily: 'Inter',
                  fontSize: 15,
                  fontWeight: FontWeight.normal,
                  height: 1.0800000190734864),
            ),
          ),
          Flexible(
            child: Text(
              string2,
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: Color.fromRGBO(0, 0, 0, 1),
                  fontFamily: 'Inter',
                  letterSpacing:
                  0 /*percentages not used in flutter. defaulting to zero*/,
                  fontWeight: FontWeight.bold,
                  height: 1.0800000190734864),
            ),
          )
        ],
      ),
    );
  }
}
