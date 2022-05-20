import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:rnb/blocs/card_labour_total.dart';
import 'package:rnb/utils/GlobalValues.dart';

import 'add_popup_edit.dart';
import 'blocs/card_labour_active.dart';
 class NoOfSubadmins extends StatefulWidget {
   const NoOfSubadmins({Key? key}) : super(key: key);

   @override
   _NoOfContractorsState createState() => _NoOfContractorsState();
 }

bool _isLoading = false;
Widget container = new Container(child: Text(""),);
 class _NoOfContractorsState extends State<NoOfSubadmins> {
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
                   'Sub-admin\'s',
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
                   return createCard(global_list[position]["role"],
                       global_list[position]["username"],
                       global_list[position]["id"],
                       global_list[position]["password"],
                       global_list[position]["user_id"],
                       global_list[position]["status"]);
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
     var response = await get(Uri.parse("https://rnb.digifoxlabs.com/api/Employee/view?role=subadmin"),
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
   Widget createCard(String role, name, id,password,userId, status){
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
                   builder: (BuildContext context) => AddPopupEdit(role, name, id, status,userId,password)
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
                             userId,
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
