import 'package:flutter/material.dart';
import 'package:rnb/models/getForm Models/getPartC.dart';

class AddressInfo extends StatefulWidget {
  PartCGet formModel;
  AddressInfo(@required this.formModel) :assert(formModel != null);
  @override
  _AddressInfoState createState() => _AddressInfoState();
}

class _AddressInfoState extends State<AddressInfo> {
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
                    'Address Info',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Color.fromRGBO(182, 132, 59, 1),
                        fontFamily: 'Poppins',
                        fontSize: 24,
                        fontWeight: FontWeight.normal,
                        height: 0.9000000158945719),
                  ),
                ),
                InfoField(string1: 'Permanent / Postal Address',string2: widget.formModel.permanentAddress,),
                InfoField(string1: 'District', string2: widget.formModel.district),
                InfoField(string1: 'City/Town', string2: widget.formModel.city),
                InfoField(string1: 'State', string2: widget.formModel.state),
                InfoField(string1: 'Postal Address in Meghalaya', string2: widget.formModel.postalAddressInMeghalaya),
                




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
