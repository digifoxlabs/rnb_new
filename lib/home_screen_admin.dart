import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:floating_action_bubble/floating_action_bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:rnb/add_popup.dart';
import 'package:rnb/add_popup_category.dart';
import 'package:rnb/add_popup_contractor.dart';
import 'package:rnb/employee_registration.dart';
import 'package:rnb/login_screen.dart';
import 'package:rnb/no_contractors.dart';
import 'package:rnb/no_employees.dart';
import 'package:rnb/no_guards.dart';
import 'package:rnb/total_labour.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rnb/total_labour_filtered.dart';
import 'package:rnb/utils/GlobalValues.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart';
import 'add_popup_job.dart';
import 'labour_temp_history.dart';
import 'models/HomeResponse.dart';
import 'no_categories.dart';
import 'no_job.dart';
import 'no_subadmins.dart';

class HomeScreenAdmin extends StatefulWidget {
  const HomeScreenAdmin({Key? key}) : super(key: key);

  @override
  _HomeScreenAdminState createState() => _HomeScreenAdminState();
}

class _HomeScreenAdminState extends State<HomeScreenAdmin>
    with SingleTickerProviderStateMixin {
  late Animation<double> _animation;
  late AnimationController _animationController;

  var labours="_",activeLabours="_",employees="_",contractors="_",guards="_",categories = "_",jobs = "_";

  List<Widget> categoriesList = [];
  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 260),
    );

    final curvedAnimation =
        CurvedAnimation(curve: Curves.easeInOut, parent: _animationController);
    _animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);

    global_list.clear();
    getData();
    super.initState();
  }

  getData() async {
    var jsonResponse = null;
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('admin:1234'));
    var response = await get(Uri.parse("https://rnb.digifoxlabs.com/api/home/adminDashboard"),
        headers: <String, String>{
          'authorization': basicAuth,
          'X-API-KEY':'rnb_app',
        });
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      if (jsonResponse != null) {
        if (jsonResponse["status"] != false) {

          HomeResponse response2 = HomeResponse.fromJson(jsonResponse);
          List<Widget> temp = [];
          for(var cats in response2.message.categories){
            temp.add(Padding(
              padding: const EdgeInsets.all(8.0),
              child: Neumorphic(
                style: NeumorphicStyle(
                    shape: NeumorphicShape.concave,
                    boxShape: NeumorphicBoxShape.roundRect(
                        BorderRadius.circular(12)),
                    depth: 10,
                    intensity: .7,
                    surfaceIntensity: 0.5,
                    lightSource: LightSource.topLeft,
                    color: Colors.grey),
                child: Container(
                    color: Colors.white,
                    width: double.infinity,
                    height: 114,
                    child: Material(
                      type: MaterialType.transparency,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            Route route = MaterialPageRoute(builder: (context) => TotalLabourFiltered(cats.categoryName,cats.catId));
                            Navigator.push(context, route).then(onGoBack);
                          });
                        },
                        child:Column(
                          children:[
                            Spacer(),
                            Text(
                              cats.categoryName.toString(),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color:
                                  Color.fromRGBO(182, 132, 59, 1),
                                  fontSize: 20,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.normal,
                                  height: 1.212500015894572),
                            ),
                            Text(
                              cats.count.toString(),
                              style: TextStyle(
                                  color:
                                  Color.fromRGBO(182, 132, 59, 1),
                                  fontFamily: 'Poppins',
                                  fontSize: 30,
                                  fontWeight: FontWeight.normal,
                                  height: 1.212500015894572),
                            ),
                            Text(
                              "active:"+cats.active.toString(),
                              style: TextStyle(
                                  color: Colors.green,
                                  fontFamily: 'Poppins',
                                  fontSize: 20,
                                  fontWeight: FontWeight.normal,
                                  height: 1.212500015894572),
                            ),

                            Spacer()
                          ],
                        ),
                      ),
                    )),
              ),
            ));
          }
          setState(() {
            categoriesList = temp;
            // admins  = jsonResponse["message"]["admin_count"].toString();
            // employees  = jsonResponse["message"]["employee_count"].toString();
            // guards  = jsonResponse["message"]["security_count"].toString();
            // contractors  = jsonResponse["message"]["contractor_count"].toString();
            // categories  = jsonResponse["message"]["category_count"].toString();
            // jobs  = jsonResponse["message"]["job_count"].toString();
            labours  = response2.message.totalLabour.toString();
            activeLabours  = response2.message.activeLabour.toString();
            (context as Element).markNeedsBuild();
          });
        }
      }
    }

    else {
      print("error");
      print(response.body);
    }
  }


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
          child: CustomScrollView(
            shrinkWrap: false,
            slivers: <Widget>[
            SliverList(
            delegate: SliverChildListDelegate(
              [
                  Stack(
                    alignment: Alignment.centerRight,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(20, 60, 20, 0),
                          child: Text(
                            'Admin',
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
                      ),
                      Align(alignment: Alignment.centerRight,child: btnLogout()),
                    ],
                  ),
                  Padding(
                    padding:
                    const EdgeInsets.fromLTRB(20, 20, 20, 10),
                    child: Neumorphic(
                      style: NeumorphicStyle(
                          shape: NeumorphicShape.concave,
                          boxShape: NeumorphicBoxShape.roundRect(
                              BorderRadius.circular(12)),
                          depth: 10,
                          intensity: .7,
                          surfaceIntensity: 0.5,
                          lightSource: LightSource.topLeft,
                          color: Colors.grey),
                      child: Container(
                          color: Colors.white,
                          width: double.infinity,
                          height: 114,
                          child: Material(
                            type: MaterialType.transparency,
                            child: Padding(
                              padding:
                              const EdgeInsets.symmetric(horizontal: 30),
                              child: Column(
                                children: [
                                  Spacer(),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Total Employees:',
                                        style: TextStyle(
                                            color: Color.fromRGBO(182, 132, 59, 1),
                                            fontFamily: 'Poppins',
                                            fontSize: 20,
                                            fontWeight: FontWeight.normal,
                                            height: 1.212500015894572),
                                      ),
                                      Text(
                                        labours.toString(),
                                        style: TextStyle(
                                            color: Color.fromRGBO(182, 132, 59, 1),
                                            fontFamily: 'Poppins',
                                            fontSize: 25,
                                            fontWeight: FontWeight.normal,
                                            height: 1.212500015894572),
                                      )
                                    ],
                                  ),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Active:',
                                        style: TextStyle(
                                            color: Colors.green,
                                            fontFamily: 'Poppins',
                                            fontSize: 15,
                                            fontWeight: FontWeight.normal,
                                            height: 1.212500015894572),
                                      ),
                                      Text(
                                        activeLabours.toString(),
                                        style: TextStyle(
                                            color: Colors.green,
                                            fontFamily: 'Poppins',
                                            fontSize: 15,
                                            fontWeight: FontWeight.normal,
                                            height: 1.212500015894572),
                                      )
                                    ],
                                  ),
                                  Spacer()
                                ],
                              ),
                            ),
                          )),
                    ),
                  ),

                SizedBox(height: 10,),
                Padding(
                  padding:
                  const EdgeInsets.fromLTRB(20, 20, 20, 20),
                  child: Neumorphic(
                    style: NeumorphicStyle(
                        shape: NeumorphicShape.concave,
                        boxShape: NeumorphicBoxShape.roundRect(
                            BorderRadius.circular(12)),
                        depth: 10,
                        intensity: .7,
                        surfaceIntensity: 0.5,
                        lightSource: LightSource.topLeft,
                        color: Colors.grey),
                    child: Container(
                        color: Colors.white,
                        width: double.infinity,
                        height: 114,
                        child: Material(
                          type: MaterialType.transparency,
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LabourTempHistory()));
                            },
                            child: Padding(
                              padding:
                              const EdgeInsets.symmetric(horizontal: 30),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Temperature \nRecords',
                                    style: TextStyle(
                                        color: Color.fromRGBO(182, 132, 59, 1),
                                        fontFamily: 'Poppins',
                                        fontSize: 24,
                                        fontWeight: FontWeight.normal,
                                        height: 1.212500015894572),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )),
                  ),
                ),
                ],
              ),
            ),
              categoriesList.isEmpty?SliverList(delegate: SliverChildListDelegate(
                [
                  Center(child: CircularProgressIndicator(),)
                ]
              )):SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                delegate: SliverChildListDelegate(categoriesList,),
              ),
          ],
          ),
        ),
        floatingActionButton: FloatingActionBubble(
          // Menu items
          items: <Bubble>[
            // Floating action menu item
            // Floating action menu item
            Bubble(
              title: "Sub-admin",
              iconColor: Colors.white,
              bubbleColor: Color.fromRGBO(182, 132, 59, 1),
              icon: FontAwesomeIcons.userFriends,
              titleStyle: TextStyle(fontSize: 12, color: Colors.white),
              onPress: () {
                setState(() {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) => addManagePopup("subadmin"),
                  ).then(onGoBack);

                });
                _animationController.reverse();
              },
            ),
            //Floating action menu item
            Bubble(
              title: "Security",
              iconColor: Colors.white,
              bubbleColor: Color.fromRGBO(182, 132, 59, 1),
              icon: FontAwesomeIcons.userShield,
              titleStyle: TextStyle(fontSize: 12, color: Colors.white),
              onPress: () {
                setState(() {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) => addManagePopup("security"),
                  ).then(onGoBack);

                });
                _animationController.reverse();
              },
            ),

            Bubble(
              title: "Master Category",
              iconColor: Colors.white,
              bubbleColor: Color.fromRGBO(182, 132, 59, 1),
              icon: FontAwesomeIcons.list,
              titleStyle: TextStyle(fontSize: 12, color: Colors.white),
              onPress: () {
                setState(() {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) => addManagePopup("categories"),
                  ).then(onGoBack);

                });
                _animationController.reverse();
              },
            ),
            Bubble(
              title: "Master Job",
              iconColor: Colors.white,
              bubbleColor: Color.fromRGBO(182, 132, 59, 1),
              icon: FontAwesomeIcons.list,
              titleStyle: TextStyle(fontSize: 12, color: Colors.white),
              onPress: () {
                setState(() {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) => addManagePopup("job"),
                  ).then(onGoBack);

                });
                _animationController.reverse();
              },
            ),
            Bubble(
              title: "Master Contractor",
              iconColor: Colors.white,
              bubbleColor: Color.fromRGBO(182, 132, 59, 1),
              icon: FontAwesomeIcons.list,
              titleStyle: TextStyle(fontSize: 12, color: Colors.white),
              onPress: () {
                setState(() {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) => addManagePopup("contractor"),
                  ).then(onGoBack);

                });
                _animationController.reverse();
              },
            ),
            Bubble(
              title: "Employee Form",
              iconColor: Colors.white,
              bubbleColor: Color.fromRGBO(182, 132, 59, 1),
              icon: FontAwesomeIcons.userFriends,
              titleStyle: TextStyle(fontSize: 12, color: Colors.white),
              onPress: () {
                _animationController.reverse();
                setState(() {
                  Route route = MaterialPageRoute(builder: (context) => EmployeeReg());
                  Navigator.push(context, route).then(onGoBack);
                });
              },
            ),
          ],

          // animation controller
          animation: _animation,

          // On pressed change animation state
          onPress: () => _animationController.isCompleted
              ? _animationController.reverse()
              : _animationController.forward(),

          // Floating Action button Icon color
          iconColor: Colors.white,

          // Floating Action button Icon
          iconData: FontAwesomeIcons.plus,
          backGroundColor: Color.fromRGBO(182, 132, 59, 1),
        ));
  }

  Widget addManagePopup(String type){
    return AlertDialog(
      content: Container(
        width: 300,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:  const EdgeInsets.fromLTRB(
                  0, 20, 0, 0),
              child: Center(
                child: Text(type,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
              ),),
            SizedBox(height: 10,),

            SizedBox(
              width: double.infinity,
              child: TextButton(style: TextButton.styleFrom(
                backgroundColor: Colors.black,
              ),onPressed: (){
                Navigator.of(context).pop();
                switch(type){
                  case "subadmin":
                    setState(() {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) => AddPopup("subadmin","main"),
                      ).then(onGoBack);

                    });
                    _animationController.reverse();
                    break;
                  case "security":
                    setState(() {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) => AddPopup("security","main"),
                      ).then(onGoBack);

                    });
                    _animationController.reverse();
                    break;
                  case "contractor":
                    setState(() {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) => AddPopupContractor("contractor", "main"),
                      ).then(onGoBack);

                    });
                    _animationController.reverse();
                    break;
                  case "job":
                    setState(() {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) => AddPopupJob(),
                      ).then(onGoBack);

                    });
                    _animationController.reverse();
                    break;
                  case "categories":
                    setState(() {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) => AddPopupCaregory(),
                      ).then(onGoBack);

                    });
                    _animationController.reverse();
                    break;
                }

              }, child: Text('ADD', textAlign: TextAlign.center, style: TextStyle(
                  color: Color.fromRGBO(255, 255, 255, 1),
                  fontFamily: 'Inter',
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  height: 1.350000023841858
              ),)),
            ),

            SizedBox(
              width: double.infinity,
              child: TextButton(style: TextButton.styleFrom(
                backgroundColor: Colors.black,
              ),onPressed: (){
                Navigator.of(context).pop();
                switch(type) {
                  case "subadmin":
                    Route route = MaterialPageRoute(builder: (context) => NoOfSubadmins());
                    Navigator.push(context, route).then(onGoBack);
                    break;
                  case "security":
                    Route route = MaterialPageRoute(builder: (context) => NoOfGuards());
                    Navigator.push(context, route).then(onGoBack);
                    break;
                  case "contractor":
                    Route route = MaterialPageRoute(builder: (context) => NoOfContractors());
                    Navigator.push(context, route).then(onGoBack);
                    break;
                  case "job":
                    Route route = MaterialPageRoute(builder: (context) => NoOfJobs());
                    Navigator.push(context, route).then(onGoBack);
                    break;
                  case "categories":
                    Route route = MaterialPageRoute(builder: (context) => NoOfCategories());
                    Navigator.push(context, route).then(onGoBack);
                    break;
                }
              }, child: Text('MANAGE', textAlign: TextAlign.center, style: TextStyle(
                  color: Color.fromRGBO(255, 255, 255, 1),
                  fontFamily: 'Inter',
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  height: 1.350000023841858
              ),)),
            ),
          ],),
      ),
    );
  }
  Container btnLogout() {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 60, 20, 0),
      child: RaisedButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              title: Text("LOGOUT"),
              content: Text("Are you sure?"),
              actions: <Widget>[
                FlatButton(
                  onPressed: () async {
                    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                    sharedPreferences.clear();
                    FirebaseAuth.instance.signOut();
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (BuildContext context) => loginScreen()), (
                        Route<dynamic> route) => false);
                  },
                  child: Text("Logout"),
                ),
              ],
            ),
          );

        },
        elevation: 0.0,
        color: Colors.redAccent[400],
        child: Text("Logout", style: TextStyle(color: Colors.white,fontSize: 10,fontFamily: "Archivo",fontWeight: FontWeight.bold)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(11.0)),
      ),
    );
  }
  FutureOr onGoBack(dynamic value) {
    setState(() {
      getData();
      global_list.clear();
    });
  }
}



