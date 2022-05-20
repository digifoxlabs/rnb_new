import 'package:flutter/material.dart';
import 'package:rnb/blocs/card_labour_inactive.dart';
import 'package:rnb/blocs/card_labour_total.dart';

import 'blocs/card_labour_expire.dart';
 class InactiveLab extends StatefulWidget {
   const InactiveLab({Key? key}) : super(key: key);

   @override
   _InactiveLabState createState() => _InactiveLabState();
 }

 class _InactiveLabState extends State<InactiveLab> {
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
                   'Inactive Labours',
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
               CardLabourInactive(),
               CardLabourInactive()
             ],
           ),
         ),
       ),
     );
   }
 }
