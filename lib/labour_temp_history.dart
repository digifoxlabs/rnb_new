import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:rnb/blocs/card_labour_total.dart';
import 'package:rnb/models/getForm%20Models/getFormModel.dart';
import 'package:rnb/utils/GlobalValues.dart';
import 'package:http/http.dart';
import 'blocs/card_labour_expire.dart';
import 'models/tempHistoryModel.dart';
 class LabourTempHistory extends StatefulWidget {

   @override
   _labourTempState createState() => _labourTempState();
 }

bool _isLoading = false;
 class _labourTempState extends State<LabourTempHistory> {
   @override
   Widget build(BuildContext context) {
     return Scaffold(
       body:  Container(
         height: double.infinity,
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
                 padding: const EdgeInsets.fromLTRB(20, 60, 20, 20),
                 child: Text(
                   'Temperature Records',
                   textAlign: TextAlign.left,
                   style: TextStyle(
                       color: Color.fromRGBO(182, 132, 59, 1),
                       fontFamily: 'Poppins',
                       fontSize: 24,
                       fontWeight: FontWeight.normal,
                       height: 0.9000000158945719),
                 ),
               ),
               _isLoading ? Padding(
                 padding: const EdgeInsets.all(28.0),
                 child: Center(child: CircularProgressIndicator()),
               ) : ListView.builder(
                 shrinkWrap: true,
                 reverse: true,
                 primary: false,
                 itemBuilder: (context, position) {
                   return cardHistory(TempHistoryModel.fromJson(global_list[position]["data"]));
                 },
                 itemCount: global_list.length,
               ),
             ],
           ),
         ),
       ),
     );
   }

   @override
   void initState() {
     super.initState();
     getData();
   }

   getData() async {
     _isLoading = true;
     var jsonResponse = null;
     String basicAuth = 'Basic ' + base64Encode(utf8.encode('admin:1234'));
     var response = await get(Uri.parse("https://rnb.digifoxlabs.com/api/security/records"),
         headers: <String, String>{
           'authorization': basicAuth,
           'X-API-KEY':'rnb_app',
         });
     if (response.statusCode == 200) {
       jsonResponse = json.decode(response.body);
       if (jsonResponse != null) {
         if (jsonResponse["status"] != false) {
           print(response.body);
           global_list = jsonResponse["message"][0];
         }
       }
     }
     else {
       print(response.body);
     }
     setState(() {
       _isLoading = false;
     });

   }

   Widget cardHistory(TempHistoryModel model){
     return Padding(
       padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
       child: Card(
         elevation: 10,
         shape: RoundedRectangleBorder(
           side: BorderSide(color: Colors.white70, width: 1),
           borderRadius: BorderRadius.circular(20),
         ),
         child: Container(
           width: double.infinity,
           child:Padding(
             padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
             child: Column(
               children: [
                 Row(
                   children: [
                     Container(padding:EdgeInsets.all(3.0),color: Colors.orange,child: Text(model.dated.year.toString()+'-'+model.dated.month.toString()+'-'+model.dated.day.toString(),
                       style: TextStyle(color: Colors.white),)),
                   ],
                 ),
                 Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                     Expanded(flex: 0,child: CircleAvatar(radius:30,backgroundImage:  NetworkImage(model.photoUrl))),
                     Expanded(
                       flex: 2,
                       child: Padding(
                         padding: const EdgeInsets.symmetric(horizontal: 10),
                         child: Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                           children: [
                             Text(model.employeeName, textAlign: TextAlign.left, style: TextStyle(
                               color: Color.fromRGBO(0, 0, 0, 1),
                               fontFamily: 'Inter',
                               fontSize: 16,
                               letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/,
                               fontWeight: FontWeight.bold,
                             ),
                               maxLines: 2,),
                             Text(model.designation, textAlign: TextAlign.left, style: TextStyle(
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
                         decoration: new BoxDecoration(
                             color: Colors.red,
                             borderRadius: new BorderRadius.only(
                               bottomRight: const Radius.circular(20.0),
                               topRight: const Radius.circular(20.0),
                             )
                         ),
                         child: Center(
                           child: Text(model.temperature+"ºF", textAlign: TextAlign.left, style: TextStyle(
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
                 Align(alignment:Alignment.centerRight,
                     child: InkWell(
                       onTap: (){
                         showDialog(
                           context: context,
                           builder: (BuildContext context) {
                             return  AlertDialog(
                               content: Container(
                                 child: Padding(
                                   padding: const EdgeInsets.all(8.0),
                                   child: Column(
                                     mainAxisAlignment: MainAxisAlignment.start,
                                     crossAxisAlignment: CrossAxisAlignment.center,
                                     mainAxisSize: MainAxisSize.min,
                                     children: [
                                       Text(
                                         'Record details',
                                         textAlign: TextAlign.center,
                                         style: TextStyle(
                                             color: Color.fromRGBO(0, 0, 0, 1),
                                             fontFamily: 'Inter',
                                             fontSize: 20,
                                             fontWeight: FontWeight.bold,
                                             height: 1.0800000190734864),
                                       ),
                                       SizedBox(height: 10,),
                                       CircleAvatar(radius: 50 ,backgroundImage: NetworkImage(model.photoUrl),),
                                       Row(
                                         mainAxisAlignment: MainAxisAlignment.start,
                                         children: [
                                           Expanded(
                                             child: Padding(
                                               padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                                               child: Column(
                                                 crossAxisAlignment: CrossAxisAlignment.start,
                                                 children: [
                                                   Text("NAME: "+model.employeeName,style: TextStyle(fontSize: 13,fontFamily: "Inter",color: Colors.black),),
                                                   SizedBox(height: 6,),
                                                   Text("TEMPERATURE: "+model.temperature+"ºF",style: TextStyle(fontSize: 13,fontFamily: "Inter",color: Colors.black),),
                                                   SizedBox(height: 6,),
                                                   Text("DATED: "+model.dated.year.toString()+'-'+model.dated.month.toString()+'-'+model.dated.day.toString(),style: TextStyle(fontSize: 13,fontFamily: "Inter",color: Colors.black),),
                                                   SizedBox(height: 6,),
                                                   Text("DESIGNATION: "+model.designation,style: TextStyle(fontSize: 13,fontFamily: "Inter",color: Colors.black),),
                                                   SizedBox(height: 6,),
                                                   Text("STATUS: "+model.status,style: TextStyle(fontSize: 13,fontFamily: "Inter",color: Colors.black),),
                                                   SizedBox(height: 6,),
                                                   Text("DATE OF ISSUE: "+model.doj.year.toString()+'-'+model.doj.month.toString()+'-'+model.doj.day.toString(),style: TextStyle(fontSize: 13,fontFamily: "Inter",color: Colors.black),),
                                                   SizedBox(height: 6,),
                                                   Text("DATE OF EXPIRY: "+model.validity.year.toString()+'-'+model.validity.month.toString()+'-'+model.validity.day.toString(),style: TextStyle(fontSize: 13,fontFamily: "Inter",color: Colors.black),),
                                                   SizedBox(height: 6,),
                                                   Text("CATEGORY: "+model.categoryName,style: TextStyle(fontSize: 13,fontFamily: "Inter",color: Colors.black),),
                                                   SizedBox(height: 6,),
                                                   Text("CONTRACTOR NAME: "+model.contractorName,style: TextStyle(fontSize: 13,fontFamily: "Inter",color: Colors.black),),
                                                   SizedBox(height: 6,),
                                                   Text("JOB NATURE: "+model.jobNatureName,style: TextStyle(fontSize: 13,fontFamily: "Inter",color: Colors.black),),
                                                   SizedBox(height: 6,),

                                                 ],
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
                           },
                         );
                       }, child: Text("more",style: TextStyle(color: Colors.blue),))),
               ],
             ),
           ),
         ),
       ),
     );
   }
 }
