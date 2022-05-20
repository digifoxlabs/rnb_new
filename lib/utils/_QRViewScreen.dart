import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:rnb/models/getForm%20Models/getFormModel.dart';

import '../qr_code_search_security.dart';

class QRViewScreen extends StatefulWidget {
  const QRViewScreen({Key? key}) : super(key: key);

  @override
  _QRViewState createState() => _QRViewState();
}


class _QRViewState extends State<QRViewScreen> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(child: _buildQrView(context)),
        ],
      ),
    );
  }
  searchId(var txtId) async {
    var jsonResponse = null;
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('admin:1234'));
    var response = await get(Uri.parse("http://api.rnbgroup.org/api/labour/view?id=$txtId"),
        headers: <String, String>{
          'authorization': basicAuth,
          'X-API-KEY':'rnb_app',
        });
    jsonResponse = json.decode(response.body);
    if (response.statusCode == 200) {
      if (jsonResponse != null) {
        if (jsonResponse["status"] != false) {
          print(response.body);
          GetFormModel model = GetFormModel.fromJson(jsonResponse['message'][0]);
          setState(() {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      SecuritySearch(model),
                ));
          });
        }
      }
    }
    else {
      showToast(jsonResponse["message"]);
      print(response.body);
    }
    controller!.resumeCamera();
  }
  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
        MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.red,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        controller.pauseCamera();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Searching...')),
        );
        result = scanData;
        searchId(result!.code.toString());
      });
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
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