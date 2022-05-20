import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rnb/blocs/card_labour_total.dart';
import 'package:rnb/models/getForm%20Models/getFormModel.dart';
import 'package:rnb/profile_screen.dart';
import 'package:rnb/utils/GlobalValues.dart';
import 'package:http/http.dart';
import 'blocs/card_labour_expire.dart';
import 'package:progress_dialog/progress_dialog.dart';

 class TotalLabourFiltered extends StatefulWidget {
   String name,id;
   TotalLabourFiltered(
       @required this.name,
       @required this.id);
   @override
   _TotalLabourState createState() => _TotalLabourState();
 }
bool _isLoading = false;
 class _TotalLabourState extends State<TotalLabourFiltered> {

   late ProgressDialog pr;


   TextEditingController searchController = new TextEditingController();

   searchById(String emp_id) async {
     pr.show();
     var jsonResponse = null;
     String basicAuth = 'Basic ' + base64Encode(utf8.encode('admin:1234'));
     var response = await get(Uri.parse("https://rnb.digifoxlabs.com/api/labour/search?employee_id=$emp_id&cat_id=${widget.id}"),
         headers: <String, String>{
           'authorization': basicAuth,
           'X-API-KEY':'rnb_app',
         });
     if (response.statusCode == 200) {
       jsonResponse = json.decode(response.body);
       if (jsonResponse != null) {
         if (jsonResponse["status"] != false) {
           print(json.encode(jsonResponse['message']));
           pr.hide();
           Navigator.push(
               context,
               MaterialPageRoute(builder: (context) => Profile(getFormModelFromJson(json.encode(jsonResponse['message'][0])))));
         }
         else{showToast("Not found.");}
       }
       else{showToast("Not found.");}
     }
     else {
       print(response.body);
       showToast("Not found.");
     }
     setState(() {
       pr.hide();
     });

   }
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
                   widget.name,
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
                   controller: searchController,
                   onSubmitted: (value){
                     if(value != ""){
                       searchById(value);
                     }
                   },
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
                     suffixIcon: InkWell(
                       onTap: (){
                         if(searchController.text != ""){
                           searchById(searchController.text);
                         }
                       },
                       child: Icon(
                         Icons.search,
                         color: Color(0xffB6843B),
                       ),
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
     pr = ProgressDialog(context);
     pr.style(message: "Searching...");
     getData();
   }

   getData() async {
     _isLoading = true;
     var jsonResponse = null;
     String basicAuth = 'Basic ' + base64Encode(utf8.encode('admin:1234'));
     var response = await get(Uri.parse("http://api.rnbgroup.org/api/Labour/view?cat_id="+widget.id),
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
   showToast(String msg){
     Fluttertoast.showToast(
         msg: msg,
         toastLength: Toast.LENGTH_SHORT,
         gravity: ToastGravity.BOTTOM,
         timeInSecForIosWeb: 1,
         backgroundColor: Colors.black,
         textColor: Colors.white,
         fontSize: 16.0
     );
   }
 }
