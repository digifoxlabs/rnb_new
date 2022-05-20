import 'package:flutter/material.dart';
import 'package:rnb/models/getForm Models/getPartB.dart';
import 'package:intl/intl.dart';

class FamilyInfo extends StatefulWidget {
  PartBGet formModel;
  FamilyInfo(@required this.formModel) :assert(formModel != null);
  @override
  _FamilyInfoState createState() => _FamilyInfoState();
}

class _FamilyInfoState extends State<FamilyInfo> {
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
                    'Family Info',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Color.fromRGBO(182, 132, 59, 1),
                        fontFamily: 'Poppins',
                        fontSize: 24,
                        fontWeight: FontWeight.normal,
                        height: 0.9000000158945719),
                  ),
                ),
                InfoField(string1: 'Do you have family members staying in RNB staff Colony',string2: widget.formModel.familyDetails.length.toString(),),
                InfoField(string1: 'Which colony', string2: widget.formModel.colonyName),

                ListView.builder(
                  shrinkWrap: true,
                  reverse: true,
                  primary: false,
                  itemBuilder: (context, position) {
                    return familyMemberItem(widget.formModel.familyDetails[position].fPhoto, widget.formModel.familyDetails[position].fName, widget.formModel.familyDetails[position].fDob, widget.formModel.familyDetails[position].fGender);
                  },
                  itemCount: widget.formModel.familyDetails.length,
                )


              ],
            ),
          ),
        ),
      ),
    );
  }
  Widget familyMemberItem(String image,name,dob,gender){
    return Padding(
      padding: const EdgeInsets.fromLTRB(
          0, 10, 0, 0),
      child: SizedBox(
        width: double.infinity,
        child: Card(
          elevation: 14,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage(image),
                ),
                SizedBox(width: 10,),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
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
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "DOB: "+DateFormat('yyyy-MM-dd').format(dob),
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: Color.fromRGBO(0, 0, 0, 1),
                              fontFamily: 'Inter',
                              fontSize: 14,
                              letterSpacing:
                              0 /*percentages not used in flutter. defaulting to zero*/,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                        SizedBox(height: 10,),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
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
                        ),
                      ],
                    ),
                  ),
                ),

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
