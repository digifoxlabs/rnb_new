import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:rnb/home_screen_admin.dart';
import 'package:rnb/home_screen_category.dart';
import 'package:rnb/home_screen_security.dart';
import 'package:shared_preferences/shared_preferences.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;



class VerificationScreen extends StatefulWidget {


  final String mobileNumber;
  VerificationScreen({
    required this.mobileNumber,
  })  : assert(mobileNumber != null);


  @override
  _VerificationScreenState createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {


  bool isCodeSent = false;

  var verificationCode = '';

  //final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  TextEditingController _pinController = TextEditingController();

  @override
  void initState() {
    super.initState();
    //_onVerifyCode();
    verify();

  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
                    child: Image.asset('images/ic_launcher.png'),
                  ),
                  Center(
                    child: Text(
                      'VERIFICATION',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Poppins',
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          height: 1),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.fromLTRB(30, 30, 30, 10),
                      child: Text(
                        'Enter Your Code',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Inter',
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            height: 1.350000023841858),
                      )),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: PinCodeTextField(
                      controller: _pinController,
                      appContext: context,
                      length: 6,
                      autoFocus: true,
                      cursorColor: Colors.black,
                      cursorHeight: 12,
                      keyboardType: TextInputType.number,
                      autoDismissKeyboard: true,
                      obscureText: false,
                      animationType: AnimationType.scale,
                      hapticFeedbackTypes: HapticFeedbackTypes.medium,
                      pinTheme: PinTheme(
                          shape: PinCodeFieldShape.box,
                          borderRadius: BorderRadius.circular(5),
                          fieldHeight: 50,
                          fieldWidth: 40,
                          selectedFillColor: Color(0xffB6843B),
                          selectedColor: Color(0xffB6843B),
                          activeColor: Colors.black,
                          inactiveFillColor: Colors.white,
                          activeFillColor: Colors.white,
                          inactiveColor: Color(0xffB6843B)),
                      animationDuration: Duration(milliseconds: 300),
                      enableActiveFill: true,
                      // errorAnimationController: errorController,
                      // controller: textEditingController,
                      onCompleted: (v) {
                        print("Completed");
                      },
                      onChanged: (value) {
                        print(value);
                        setState(() {
                          // currentText = value;
                        });
                      },
                      beforeTextPaste: (text) {
                        print("Allowing to paste $text");
                        //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                        //but you can show anything you want here, like your pop up saying wrong paste format or etc
                        return true;
                      },
                    ),
                  ),
                  Padding(
                    padding:
                    const EdgeInsets.symmetric(vertical: 40, horizontal: 40),
                    child: Center(
                      child: SizedBox(
                        width: double.infinity,
                        child: TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            onPressed: () {
                              // Todo: Uncomment while release
                              if(_pinController.text.length == 6) {
                                validate();
                              }

                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4),
                              child: Text(
                                'Continue',
                                style: TextStyle(
                                  color: Color.fromRGBO(255, 255, 255, 1),
                                  fontFamily: 'Poppins',
                                  fontSize: 24,
                                  letterSpacing:
                                  0 /*percentages not used in flutter. defaulting to zero*/,
                                  fontWeight: FontWeight.bold,),
                              ),
                            )),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
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
  validate() async {
    try {
      await _auth
          .signInWithCredential(
          PhoneAuthProvider.credential(
              verificationId:
              verificationCode,
              smsCode: _pinController.text
                  .toString()))
          .then((user) async => {
        //sign in was success
        if (user != null)
          {
            login(widget.mobileNumber)
          }
      });

    } catch (e) {

    }

  }
  verify() async {
    var verifyPhoneNumber = _auth.verifyPhoneNumber(
      phoneNumber: "+91"+widget.mobileNumber,
      verificationCompleted: (phoneAuthCredential) {
        //auto code complete (not manually)
        _auth.signInWithCredential(phoneAuthCredential).then((user) async => {
          if (user != null)
            {
              //redirect
              setState(() {
                login(widget.mobileNumber);
              }),
            }
        });
      },
      verificationFailed: (FirebaseAuthException error) {

      },
      codeSent: (verificationId, [forceResendingToken]) {
        setState(() {
          verificationCode = verificationId;
        });
      },
      codeAutoRetrievalTimeout: (String verificationId) {

      },
      timeout: Duration(seconds: 60),
    );
    await verifyPhoneNumber;
  }

  login(String phno) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString("token")!;
    var data = {'mobile_no': phno, "token": token};
    var jsonResponse = null;

    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('admin:1234'));

    var response = await post(Uri.parse("https://rnb.digifoxlabs.com/api/auth/login"),
        body: data,
        headers: <String, String>{
          'authorization': basicAuth,
          'X-API-KEY':'rnb_app',
        });
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      if (jsonResponse != null) {

        if (jsonResponse["status"] == false) {
          showToast(jsonResponse["message"]);
        } else {
          sharedPreferences.setString("username",jsonResponse["message"]["username"]);
          sharedPreferences.setString("role",jsonResponse["message"]["role"]);
          sharedPreferences.setString("id",jsonResponse["message"]["id"]);
          String role = jsonResponse["message"]["role"];
          switch(role){
            case "admin":
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        HomeScreenAdmin(),
                  ));
              break;
            case "contractor":
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        HomeScreenCategory(),
                  ));
              break;
            case "employee":
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        HomeScreenCategory(),
                  ));
              break;
            case "security":
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        HomeScreenSecurity(),
                  ));
              break;

          }

        }
      }
    }
    else {
      showToast(json.decode(response.body)["message"]);
      print(response.body);
    }
  }
}
