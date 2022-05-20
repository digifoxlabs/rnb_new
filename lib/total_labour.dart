import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:rnb/blocs/card_labour_total.dart';
import 'package:rnb/models/getForm%20Models/getFormModel.dart';
import 'package:rnb/utils/GlobalValues.dart';
import 'package:http/http.dart';
import 'blocs/card_labour_expire.dart';
 class TotalLabour extends StatefulWidget {

   @override
   _TotalLabourState createState() => _TotalLabourState();
 }

bool _isLoading = false;
 class _TotalLabourState extends State<TotalLabour> {
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
                   'Total Labours',
                   textAlign: TextAlign.left,
                   style: TextStyle(
                       color: Color.fromRGBO(182, 132, 59, 1),
                       fontFamily: 'Poppins',
                       fontSize: 24,
                       fontWeight: FontWeight.normal,
                       height: 0.9000000158945719),
                 ),
               ),
               Padding(
                 padding: const EdgeInsets.symmetric(horizontal: 20),
                 child: TextField(
                   style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                   decoration: InputDecoration(
                     fillColor: Color(0xffC4C4C4),
                     filled: true,
                     enabledBorder: const OutlineInputBorder(
                       borderSide: BorderSide(
                         color: Color(0xffB6843B),
                       ),
                     ),
                     focusedBorder: OutlineInputBorder(
                       borderSide: BorderSide(color: Colors.black),
                     ),
                     suffixIcon: Icon(
                       Icons.search,
                       color: Color(0xffB6843B),
                     ),
                     border: InputBorder.none,
                     hintText: "Search here...",
                     contentPadding: const EdgeInsets.only(
                       left: 16,
                       right: 20,
                       top: 14,
                       bottom: 14,
                     ),
                   ),
                   cursorColor: Color(0xffB6843B),
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
                   return CardLabourTotal(GetFormModel.fromJson(global_list[position]));
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
     var response = await get(Uri.parse("https://rnb.digifoxlabs.com/api/labour/view"),
         headers: <String, String>{
           'authorization': basicAuth,
           'X-API-KEY':'rnb_app',
         });
     if (response.statusCode == 200) {
       jsonResponse = json.decode(response.body);
       if (jsonResponse != null) {
         if (jsonResponse["status"] != false) {
           print(response.body);
           global_list = jsonResponse["message"];
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
   FutureOr onGoBack(dynamic value) {
     setState(() {
       getData();
       global_list.clear();
     });
   }
 }
