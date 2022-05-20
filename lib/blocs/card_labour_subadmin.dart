import 'package:flutter/material.dart';
import 'package:rnb/models/formModel.dart';
import 'package:rnb/models/getForm%20Models/getFormModel.dart';
import 'package:rnb/profile_screen_subadmin.dart';

class CardLabourSubadmin extends StatefulWidget {

  GetFormModel formModel;
  CardLabourSubadmin(@required this.formModel) :assert(formModel != null);

  @override
  _CardLabourTotalState createState() => _CardLabourTotalState();
}

class _CardLabourTotalState extends State<CardLabourSubadmin> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Card(
        elevation: 10,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.white70, width: 1),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          width: double.infinity,
          height: 102,
          child: InkWell(
            customBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            onTap: (){
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfileSubadmin(widget.formModel)));
            },
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(flex: 0,child: CircleAvatar(radius:40,backgroundImage:  NetworkImage(widget.formModel.partD.photoUrl))),
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(widget.formModel.partA.employeeName, textAlign: TextAlign.left, style: TextStyle(
                              color: Color.fromRGBO(0, 0, 0, 1),
                              fontFamily: 'Inter',
                              fontSize: 16,
                              letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/,
                              fontWeight: FontWeight.bold,
                          ),
                            maxLines: 2,),
                          Text(widget.formModel.partC.city, textAlign: TextAlign.left, style: TextStyle(
                              color: Color.fromRGBO(0, 0, 0, 1),
                              fontFamily: 'Inter',
                              fontSize: 16,
                              letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/,
                              fontWeight: FontWeight.normal,
                          ),
                            maxLines: 2,)
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: double.infinity,
                      decoration: new BoxDecoration(
                          color: Color(0xff282121),
                          borderRadius: new BorderRadius.only(
                            bottomRight: const Radius.circular(20.0),
                            topRight: const Radius.circular(20.0),
                          )
                      ),
                      child: Center(
                        child: Text(widget.formModel.partA.status, textAlign: TextAlign.left, style: TextStyle(
                            color: Color.fromRGBO(255, 255, 255, 1),
                            fontFamily: 'Inter',
                            fontSize: 16,
                            letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/,
                            fontWeight: FontWeight.normal,
                            height: 1.350000023841858
                        ),),
                      ),
                    ),
                  )

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
