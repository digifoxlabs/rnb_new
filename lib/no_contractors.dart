import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:rnb/blocs/card_labour_total.dart';
import 'package:rnb/utils/GlobalValues.dart';

import 'add_popup_edit.dart';
import 'blocs/card_labour_active.dart';
import 'edit_popup_contractor.dart';
 class NoOfContractors extends StatefulWidget {
   const NoOfContractors({Key? key}) : super(key: key);

   @override
   _NoOfContractorsState createState() => _NoOfContractorsState();
 }

bool _isLoading = false;
Widget container = new Container(child: Text(""),);
 class _NoOfContractorsState extends State<NoOfContractors> {
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
                   'Contractor\'s',
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
               _isLoading ? Padding(
                 padding: const EdgeInsets.all(28.0),
                 child: Center(child: CircularProgressIndicator()),
               ) : ListView.builder(
                 shrinkWrap: true,
                 reverse: true,
                 primary: false,
                 itemBuilder: (context, position) {
                   return createCard(
                       global_list[position]["con_name"],
                       global_list[position]["con_number"],
                       global_list[position]["con_id"]);
                 },
                 itemCount: global_list.length,
               ),             ],
           ),
         ),
       ),
     );
   }

   @override
   void initState() {
     // TODO: implement initState
     super.initState();
     getData();
   }

   getData() async {
     _isLoading = true;
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
           global_list=jsonResponse["message"];
         }
       }
     }
     else {
       print(response.body);
     }
     setState(() {
       _isLoading = false;
     });   }
   Widget createCard(String name,phNo, id){
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
           child: InkWell(
             customBorder: RoundedRectangleBorder(
               borderRadius: BorderRadius.circular(20),
             ),
             onTap: () {
               showDialog(
                   context: context,
                   builder: (BuildContext context) => EditPopupContractor(name,phNo, id)
               ).then(onGoBack);
             },
             child: Padding(
               padding: const EdgeInsets.all(10),
               child: Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                   Expanded(
                       flex: 0,
                       child: CircleAvatar(
                         radius: 40,
                         backgroundImage: AssetImage(
                           'images/Placeholder.png',
                         ),
                       )),
                   Expanded(
                     flex: 2,
                     child: Padding(
                       padding: const EdgeInsets.symmetric(horizontal: 10),
                       child: Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                         children: [
                           Text(
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
                             maxLines: 2,
                           ),
                           Text(
                             phNo,
                             textAlign: TextAlign.left,
                             style: TextStyle(
                               color: Color.fromRGBO(0, 0, 0, 1),
                               fontFamily: 'Inter',
                               fontSize: 16,
                               letterSpacing:
                               0 /*percentages not used in flutter. defaulting to zero*/,
                               fontWeight: FontWeight.normal,
                             ),
                             maxLines: 2,
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
       ),
     );
   }
   FutureOr onGoBack(dynamic value) {
     setState(() {
       (context as Element).markNeedsBuild();
     });
   }
 }
