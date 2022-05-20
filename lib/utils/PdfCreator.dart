
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as p_d_f;
import 'package:qr_flutter/qr_flutter.dart';
import 'package:rnb/models/getForm%20Models/getFormModel.dart';
import 'package:http/http.dart';
import 'package:share_extend/share_extend.dart';
import 'PdfViewerPage.dart';

var background,logo;
var data;

String contr = "";

check(String? cont){
  if(cont != null){
    contr = cont;
  }
}


getImages(var url) async {
  background = await (rootBundle.load('images/background.png'));
  logo = await (rootBundle.load('images/ic_launcher.png'));
  Response imageResponse = await get(Uri.parse(url));
  data = imageResponse.bodyBytes;
}

reportView(context,GetFormModel model) async {

  getImages(model.partD.photoUrl);
  check(model.partA.contractor.contractorName);
  final p_d_f.Document pdf = p_d_f.Document();
  pdf.addPage(p_d_f.Page(
      pageFormat: PdfPageFormat.a3,
      build: (p_d_f.Context context) {
        return cardId(model); // Center
      }));
  //save PDF
  final String dir = (await getApplicationDocumentsDirectory()).path;
  final String path = '$dir/'+model.partA.employeeId+'.pdf';
  final File file = File(path);
  await file.writeAsBytes(await pdf.save());
  ShareExtend.share(path, "file");
  // Navigator.of(context).push(
  //   MaterialPageRoute(
  //     builder: (_) => PdfViewerPage(path: path),
  //   ),
  // );

}

p_d_f.Container cardId(GetFormModel model) {
  return p_d_f.Container(
    decoration: p_d_f.BoxDecoration(
        borderRadius: p_d_f.BorderRadius.circular(12),
        image: p_d_f.DecorationImage(
            image: p_d_f.MemoryImage(background.buffer.asUint8List()),
            fit: p_d_f.BoxFit.fill
        )
    ),
    child: p_d_f.Column(
      mainAxisAlignment: p_d_f.MainAxisAlignment.start,
      crossAxisAlignment: p_d_f.CrossAxisAlignment.center,
      children: [
        p_d_f.SizedBox(height: 20,),
        p_d_f.Row(
          mainAxisAlignment: p_d_f.MainAxisAlignment.end,
          children: [
            p_d_f.Padding(
              padding: const p_d_f.EdgeInsets.all(8.0),
              child: p_d_f.Container(
                height: 150,
                width: 150,
                decoration: p_d_f.BoxDecoration(
                    shape: p_d_f.BoxShape.circle,
                    borderRadius: p_d_f.BorderRadius.circular(50),
                    image: p_d_f.DecorationImage(
                        image: p_d_f.MemoryImage(data),
                        fit: p_d_f.BoxFit.fill
                    )
                ),
              ),
            ),
          ],
        ),

        p_d_f.Image( p_d_f.MemoryImage(logo.buffer.asUint8List()),height: 250),
        p_d_f.Text('RNB CARBIDES AND FERRO ALLOYS PVT LTD.',
          textAlign:p_d_f.TextAlign.center,style: p_d_f.TextStyle(
            fontSize: 25,
        ),),
        p_d_f.SizedBox(height: 20,),

        //p_d_f.CircleAvatar(radius: 50 ,backgroundImage: NetworkImage(model.partD.photoUrl),),

        p_d_f.Row(
          mainAxisAlignment: p_d_f.MainAxisAlignment.start,
          children: [
            p_d_f.Expanded(
              child: p_d_f.Padding(
                padding: const p_d_f.EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                child: p_d_f.Column(
                  crossAxisAlignment: p_d_f.CrossAxisAlignment.start,
                  children: [
                    p_d_f.Row(
                      crossAxisAlignment: p_d_f.CrossAxisAlignment.start,
                        children: [
                      p_d_f.Text("ID                                        : ",style: p_d_f.TextStyle(fontSize: 16),),
                      p_d_f.Expanded(child: p_d_f.Text(model.partA.employeeId,style: p_d_f.TextStyle(fontSize: 16),),
                      ),
                    ]),
                    p_d_f.SizedBox(height: 6,),
                    p_d_f.Row(
                        crossAxisAlignment: p_d_f.CrossAxisAlignment.start,
                        children: [
                          p_d_f.Text("NAME                                 : ",style: p_d_f.TextStyle(fontSize: 16),),
                          p_d_f.Expanded(child: p_d_f.Text(model.partA.employeeName,style: p_d_f.TextStyle(fontSize: 16),),
                          ),
                        ]),
                    p_d_f.SizedBox(height: 6,),
                    p_d_f.Row(
                        crossAxisAlignment: p_d_f.CrossAxisAlignment.start,
                        children: [
                          p_d_f.Text("ADDRESS                          : ",style: p_d_f.TextStyle(fontSize: 16),),
                          p_d_f.Expanded(child: p_d_f.Text(model.partC.permanentAddress,style: p_d_f.TextStyle(fontSize: 16),),
                          ),
                        ]),
                    p_d_f.SizedBox(height: 6,),
                    p_d_f.Row(
                        crossAxisAlignment: p_d_f.CrossAxisAlignment.start,
                        children: [
                          p_d_f.Text("DESIGNATION                  : ",style: p_d_f.TextStyle(fontSize: 16),),
                          p_d_f.Expanded(child: p_d_f.Text(model.partA.designation,style: p_d_f.TextStyle(fontSize: 16),),
                          ),
                        ]),
                    p_d_f.SizedBox(height: 6,),
                    p_d_f.Row(
                        crossAxisAlignment: p_d_f.CrossAxisAlignment.start,
                        children: [
                          p_d_f.Text("PHONE NO.                       : ",style: p_d_f.TextStyle(fontSize: 16),),
                          p_d_f.Expanded(child: p_d_f.Text(model.partA.mobileNo,style: p_d_f.TextStyle(fontSize: 16),),
                          ),
                        ]),
                    p_d_f.SizedBox(height: 6,),
                    p_d_f.Row(
                        crossAxisAlignment: p_d_f.CrossAxisAlignment.start,
                        children: [
                          p_d_f.Text("CONTRACTOR NAME      : ",style: p_d_f.TextStyle(fontSize: 16),),
                          p_d_f.Expanded(child: p_d_f.Text(contr,style: p_d_f.TextStyle(fontSize: 16),),
                          ),
                        ]),
                    p_d_f.SizedBox(height: 6,),
                    p_d_f.Row(
                        crossAxisAlignment: p_d_f.CrossAxisAlignment.start,
                        children: [
                          p_d_f.Text("BLOOD GROUP                : ",style: p_d_f.TextStyle(fontSize: 16),),
                          p_d_f.Expanded(child: p_d_f.Text(model.partA.bloodGroup,style: p_d_f.TextStyle(fontSize: 16),),
                          ),
                        ]),
                    p_d_f.SizedBox(height: 6,),
                    p_d_f.Row(
                        crossAxisAlignment: p_d_f.CrossAxisAlignment.start,
                        children: [
                          p_d_f.Text("EMERGENCY CONTACT : ",style: p_d_f.TextStyle(fontSize: 16),),
                          p_d_f.Expanded(child: p_d_f.Text(model.partA.emergencyPhoneNo,style: p_d_f.TextStyle(fontSize: 16),),
                          ),
                        ]),
                    p_d_f.SizedBox(height: 6,),
                    p_d_f.Row(
                        crossAxisAlignment: p_d_f.CrossAxisAlignment.start,
                        children: [
                          p_d_f.Text("DATE OF ISSUE               : ",style: p_d_f.TextStyle(fontSize: 16),),
                          p_d_f.Expanded(child: p_d_f.Text(model.partA.doj.year.toString()+'/'+model.partA.doj.month.toString()+'/'+model.partA.doj.day.toString(),style: p_d_f.TextStyle(fontSize: 16),),
                          ),
                        ]),
                    p_d_f.SizedBox(height: 6,),
                    p_d_f.Row(
                        crossAxisAlignment: p_d_f.CrossAxisAlignment.start,
                        children: [
                          p_d_f.Text("DATE OF EXPIRY             : ",style: p_d_f.TextStyle(fontSize: 16),),
                          p_d_f.Expanded(child: p_d_f.Text(model.partA.validity.year.toString()+'/'+model.partA.validity.month.toString()+'/'+model.partA.validity.day.toString(),style: p_d_f.TextStyle(fontSize: 16),),
                          ),
                        ]),

                  ],
                ),
              ),
            ),
          ],
        ),
        p_d_f.SizedBox(height: 6,),
        p_d_f.Text("Office & Works : Umiam Industrial Area,Umiam - 793103.\nDist Ri Bhoi.Meghalaya.India.\nM  +91 8132953936  E Ferro@Rnbgroup.org\nwww.rnbgroup.org",textAlign:p_d_f.TextAlign.center,style: p_d_f.TextStyle(fontSize: 12),),
        p_d_f.Row(
          mainAxisAlignment: p_d_f.MainAxisAlignment.start,
          children: [
            p_d_f.Padding(
              padding: p_d_f.EdgeInsets.all(8),
              child: p_d_f.BarcodeWidget(
                height: 70 ,
                width :70,
                color: PdfColor.fromHex("#000"),
                barcode: p_d_f.Barcode.qrCode(),
                data: model.partA.employeeId,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}