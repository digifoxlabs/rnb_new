import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as p_d_f;
import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart';
import 'package:rnb/models/getForm%20Models/getFormModel.dart';
import 'package:rnb/utils/PdfCreator.dart';
import 'package:rnb/utils/PdfViewerPage.dart';

formLabourReg(GetFormModel m,BuildContext context) async {
  final p_d_f.Document pdf = p_d_f.Document();
  pdf.addPage(p_d_f.Page(
      pageFormat: PdfPageFormat.a4,
      build: (p_d_f.Context context) {
        return p_d_f.Container(
            decoration: p_d_f.BoxDecoration(color: PdfColors.grey100),
            alignment: p_d_f.Alignment.topCenter,
            child: p_d_f.Column(
                crossAxisAlignment: p_d_f.CrossAxisAlignment.center,
                children: [
                  p_d_f.Padding(
                    padding: p_d_f.EdgeInsets.all(20),
                    child: p_d_f.Column(children: [
                      p_d_f.Text(
                          'REGISTRATION FORM ONLY (FRESH)\n\nApplication for Registration of Migrant Workers Under the Meghalaya Identification,Registration(Safety & Security) of Migrant Workers Rules, 2020',
                          style: p_d_f.TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: p_d_f.TextAlign.center),
                    ]),
                  ),
                  p_d_f.Padding(
                      padding: p_d_f.EdgeInsets.symmetric(horizontal: 20),
                      child: p_d_f.Row(
                          //mainAxisAlignment: p_d_f.MainAxisAlignment.spaceAround,
                          children: [
                            p_d_f.Expanded(
                              child: p_d_f.Text('Applicant\'s Details',
                                  style: p_d_f.TextStyle(
                                      fontWeight: p_d_f.FontWeight.bold)),
                            )
                          ])),
                  p_d_f.Padding(
                      padding: p_d_f.EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: p_d_f.Row(
                          crossAxisAlignment: p_d_f.CrossAxisAlignment.start,
                          children: [
                            p_d_f.Expanded(
                                flex: 14,
                                child: p_d_f.Column(
                                    crossAxisAlignment:
                                        p_d_f.CrossAxisAlignment.start,
                                    children: [
                                      p_d_f.Row(children: [
                                        p_d_f.Expanded(
                                          flex: 2,
                                          child:
                                              p_d_f.Text('Applicant\'s Name:'),
                                        ),
                                        p_d_f.Expanded(
                                          child:
                                              p_d_f.Text(m.partA.employeeName),
                                        ),
                                      ]),
                                      p_d_f.SizedBox(height: 10),
                                      p_d_f.Row(children: [
                                        p_d_f.Expanded(
                                          flex: 2,
                                          child: p_d_f.Text('Date of Birth:'),
                                        ),
                                        p_d_f.Expanded(
                                          child:
                                              p_d_f.Text(m.partA.dob.day.toString()+"/"+m.partA.dob.month.toString()+"/"+m.partA.dob.year.toString()),
                                        ),
                                      ]),
                                      p_d_f.SizedBox(height: 10),
                                      p_d_f.Row(children: [
                                        p_d_f.Expanded(
                                          flex: 2,
                                          child: p_d_f.Text(
                                              'Applicant\'s Contact Number:'),
                                        ),
                                        p_d_f.Expanded(
                                          child:
                                              p_d_f.Text(m.partA.mobileNo),
                                        ),
                                      ]),
                                      p_d_f.SizedBox(height: 10),
                                      p_d_f.Row(children: [
                                        p_d_f.Expanded(
                                          flex: 2,
                                          child: p_d_f.Text(
                                              'EPIC number of the applicant:'),
                                        ),
                                        p_d_f.Expanded(
                                          child:
                                              p_d_f.Text(m.partA.employeeId),
                                        ),
                                      ]),
                                      p_d_f.SizedBox(height: 10),
                                      p_d_f.Row(children: [
                                        p_d_f.Expanded(
                                          flex: 2,
                                          child: p_d_f.Text(
                                              'Postal Address of the Applicant in Meghalaya (if any):'),
                                        ),
                                        p_d_f.Expanded(
                                          child:
                                              p_d_f.Text(m.partC.postalAddressInMeghalaya),
                                        ),
                                      ]),
                                      p_d_f.SizedBox(height: 10),
                                      p_d_f.Row(children: [
                                        p_d_f.Expanded(
                                          flex: 2,
                                          child: p_d_f.Text(
                                              'Particulars of any relative or friend of the applicant in Meghalaya:'),
                                        ),
                                        p_d_f.Expanded(
                                          child:
                                              p_d_f.Text(m.partB.familyDetails.toString()),
                                        ),
                                      ]),
                                      p_d_f.SizedBox(height: 10),
                                      p_d_f.Row(children: [
                                        p_d_f.Expanded(
                                          flex: 2,
                                          child: p_d_f.Text(
                                              'Father\'s Name:'),
                                        ),
                                        p_d_f.Expanded(
                                          child:
                                              p_d_f.Text(m.partA.fathersName),
                                        ),
                                      ]),
                                      p_d_f.SizedBox(height: 10),
                                      p_d_f.Row(children: [
                                        p_d_f.Expanded(
                                          flex: 2,
                                          child: p_d_f.Text(
                                              'Mother\'s Name:'),
                                        ),
                                        p_d_f.Expanded(
                                          child:
                                          p_d_f.Text(m.partA.mothersName),
                                        ),
                                      ]),
                                      p_d_f.SizedBox(height: 10),
                                      p_d_f.Row(children: [
                                        p_d_f.Expanded(
                                          flex: 2,
                                          child: p_d_f.Text('Gender:'),
                                        ),
                                        p_d_f.Expanded(
                                          child:
                                              p_d_f.Text(m.partA.gender),
                                        ),
                                      ]),
                                      p_d_f.SizedBox(height: 10),
                                      p_d_f.Row(children: [
                                        p_d_f.Expanded(
                                          flex: 2,
                                          child: p_d_f.Text(
                                              'Applicant\'s Email Id:'),
                                        ),
                                        p_d_f.Expanded(
                                          child:
                                              p_d_f.Text(m.partA.emailId),
                                        ),
                                      ]),
                                      p_d_f.SizedBox(height: 10),
                                    ]))
                          ])),
                  p_d_f.Padding(
                      padding: p_d_f.EdgeInsets.symmetric(horizontal: 20),
                      child: p_d_f.Row(
                          //mainAxisAlignment: p_d_f.MainAxisAlignment.spaceAround,
                          children: [
                            p_d_f.Expanded(
                              child: p_d_f.Text(
                                  'Permanent Address of the Applicant',
                                  style: p_d_f.TextStyle(
                                      fontWeight: p_d_f.FontWeight.bold)),
                            )
                          ])),
                  p_d_f.Padding(
                      padding: p_d_f.EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: p_d_f.Row(
                          crossAxisAlignment: p_d_f.CrossAxisAlignment.start,
                          children: [
                            p_d_f.Expanded(
                                flex: 14,
                                child: p_d_f.Column(
                                    crossAxisAlignment:
                                        p_d_f.CrossAxisAlignment.start,
                                    children: [
                                      p_d_f.Row(children: [
                                        p_d_f.Expanded(
                                          flex: 2,
                                          child: p_d_f.Text('State:'),
                                        ),
                                        p_d_f.Expanded(
                                          child:
                                              p_d_f.Text(m.partC.state),
                                        ),
                                      ]),
                                      p_d_f.SizedBox(height: 10),
                                      p_d_f.Row(children: [
                                        p_d_f.Expanded(
                                          flex: 2,
                                          child: p_d_f.Text('Village/Town:'),
                                        ),
                                        p_d_f.Expanded(
                                          child:
                                              p_d_f.Text(m.partC.city),
                                        ),
                                      ]),
                                      p_d_f.SizedBox(height: 10),
                                      p_d_f.Row(children: [
                                        p_d_f.Expanded(
                                          flex: 2,
                                          child: p_d_f.Text('Pincode:'),
                                        ),
                                        p_d_f.Expanded(
                                          child:
                                              p_d_f.Text(m.partC.pincode),
                                        ),
                                      ]),
                                      p_d_f.SizedBox(height: 10),
                                      p_d_f.Row(children: [
                                        p_d_f.Expanded(
                                          flex: 2,
                                          child: p_d_f.Text('District:'),
                                        ),
                                        p_d_f.Expanded(
                                          child:
                                              p_d_f.Text(m.partC.district),
                                        ),
                                      ]),
                                      p_d_f.SizedBox(height: 10),
                                      p_d_f.Row(children: [
                                        p_d_f.Expanded(
                                          flex: 2,
                                          child: p_d_f.Text('Locality:'),
                                        ),
                                        p_d_f.Expanded(
                                          child:
                                              p_d_f.Text('__________________'),
                                        ),
                                      ]),
                                      p_d_f.SizedBox(height: 10),
                                    ]))
                          ])),
                  p_d_f.Padding(
                      padding: p_d_f.EdgeInsets.symmetric(horizontal: 20),
                      child: p_d_f.Row(
                          //mainAxisAlignment: p_d_f.MainAxisAlignment.spaceAround,
                          children: [
                            p_d_f.Expanded(
                              child: p_d_f.Text(
                                  'Particulars of the next of kin of the applicant in home state',
                                  style: p_d_f.TextStyle(
                                      fontWeight: p_d_f.FontWeight.bold)),
                            )
                          ])),
                  p_d_f.Padding(
                      padding: p_d_f.EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: p_d_f.Row(
                          crossAxisAlignment: p_d_f.CrossAxisAlignment.start,
                          children: [
                            p_d_f.Expanded(
                                flex: 14,
                                child: p_d_f.Column(
                                    crossAxisAlignment:
                                        p_d_f.CrossAxisAlignment.start,
                                    children: [
                                      p_d_f.Row(children: [
                                        p_d_f.Expanded(
                                          flex: 2,
                                          child: p_d_f.Text(
                                              'Name of next of kin:'),
                                        ),
                                        p_d_f.Expanded(
                                          child:
                                              p_d_f.Text(m.partA.nextOfKin.name),
                                        ),
                                      ]),
                                      p_d_f.SizedBox(height: 10),
                                      p_d_f.Row(children: [
                                        p_d_f.Expanded(
                                          flex: 2,
                                          child: p_d_f.Text('Address:'),
                                        ),
                                        p_d_f.Expanded(
                                          child:
                                              p_d_f.Text(m.partA.nextOfKin.address),
                                        ),
                                      ]),
                                      p_d_f.SizedBox(height: 10),
                                    ]))
                          ])),
                ]));
      }));
  pdf.addPage(p_d_f.Page(
      pageFormat: PdfPageFormat.a4,
      build: (p_d_f.Context context) {
        return p_d_f.Container(
          decoration: p_d_f.BoxDecoration(color: PdfColors.grey100),
          alignment: p_d_f.Alignment.topCenter,
          child: p_d_f.Column(children: [
            p_d_f.SizedBox(height: 20),
            p_d_f.Padding(
                padding: p_d_f.EdgeInsets.symmetric(horizontal: 20),
                child: p_d_f.Row(
                    //mainAxisAlignment: p_d_f.MainAxisAlignment.spaceAround,
                    children: [
                      p_d_f.Expanded(
                        child: p_d_f.Text('Service Specific Details',
                            style: p_d_f.TextStyle(
                                fontWeight: p_d_f.FontWeight.bold)),
                      )
                    ])),
            p_d_f.Padding(
                padding:
                    p_d_f.EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: p_d_f.Row(
                    crossAxisAlignment: p_d_f.CrossAxisAlignment.start,
                    children: [
                      p_d_f.Expanded(
                          flex: 14,
                          child: p_d_f.Column(
                              crossAxisAlignment:
                                  p_d_f.CrossAxisAlignment.start,
                              children: [
                                p_d_f.Row(children: [
                                  p_d_f.Expanded(
                                    flex: 2,
                                    child: p_d_f.Text(
                                        'Whether the applicant was convicted of any offence under any law in force in India?:',
                                        style: p_d_f.TextStyle()),
                                  ),
                                  p_d_f.Expanded(
                                    child: p_d_f.Text(m.partA.criminalRecord),
                                  ),
                                ]),
                                p_d_f.SizedBox(height: 10),
                                p_d_f.Row(children: [
                                  p_d_f.Expanded(
                                    flex: 2,
                                    child: p_d_f.Text(
                                        'Whether the applicant has any criminal case pending against him/her?:'),
                                  ),
                                  p_d_f.Expanded(
                                    child: p_d_f.Text(m.partA.pendingCriminalCase),
                                  ),
                                ]),
                                p_d_f.SizedBox(height: 10),
                                p_d_f.Row(children: [
                                  p_d_f.Expanded(
                                    flex: 2,
                                    child: p_d_f.Text(
                                        'Declaration that the applicant is not of unsound mind?:'),
                                  ),
                                  p_d_f.Expanded(
                                    child: p_d_f.Text(m.partA.stableMindDeclaration),
                                  ),
                                ]),
                                p_d_f.SizedBox(height: 10),
                                p_d_f.Row(children: [
                                  p_d_f.Expanded(
                                    flex: 2,
                                    child: p_d_f.Text(
                                        'Nature of Employment/Designation:'),
                                  ),
                                  p_d_f.Expanded(
                                    child: p_d_f.Text(m.partA.designation),
                                  ),
                                ]),
                                p_d_f.SizedBox(height: 10),
                                p_d_f.Row(children: [
                                  p_d_f.Expanded(
                                    flex: 2,
                                    child: p_d_f.Text(
                                        'Date of commencement of employment or expected date of commencement:'),
                                  ),
                                  p_d_f.Expanded(
                                    child: p_d_f.Text(m.partA.doj.day.toString()+"/"+m.partA.doj.month.toString()+"/"+m.partA.doj.year.toString()),
                                  ),
                                ]),
                                p_d_f.SizedBox(height: 10),
                                p_d_f.Row(children: [
                                  p_d_f.Expanded(
                                    flex: 2,
                                    child: p_d_f.Text(
                                        'Expected duration of stay:'),
                                  ),
                                  p_d_f.Expanded(
                                    child: p_d_f.Text(m.partA.expectedDurationOfStay),
                                  ),
                                ]),
                                p_d_f.SizedBox(height: 10),
                              ]))
                    ])),
            p_d_f.Padding(
                padding: p_d_f.EdgeInsets.symmetric(horizontal: 20),
                child: p_d_f.Row(
                    //mainAxisAlignment: p_d_f.MainAxisAlignment.spaceAround,
                    children: [
                      p_d_f.Expanded(
                        child: p_d_f.Text(
                            'Location and Address of the work area where the migrant worker will be employed',
                            style: p_d_f.TextStyle(
                                fontWeight: p_d_f.FontWeight.bold)),
                      )
                    ])),
            p_d_f.Padding(
                padding:
                    p_d_f.EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: p_d_f.Row(
                    crossAxisAlignment: p_d_f.CrossAxisAlignment.start,
                    children: [
                      p_d_f.Expanded(
                          flex: 14,
                          child: p_d_f.Column(
                              crossAxisAlignment:
                                  p_d_f.CrossAxisAlignment.start,
                              children: [
                                p_d_f.Row(children: [
                                  p_d_f.Expanded(
                                    flex: 2,
                                    child: p_d_f.Text(
                                        'Details of the work [ Mention specific skill only]:',
                                        style: p_d_f.TextStyle()),
                                  ),
                                  p_d_f.Expanded(
                                    child: p_d_f.Text(m.partA.jobNature.jobNatureName),
                                  ),
                                ]),
                                p_d_f.SizedBox(height: 10),
                                p_d_f.Row(children: [
                                  p_d_f.Expanded(
                                    flex: 2,
                                    child: p_d_f.Text(
                                        'District of the area of work:'),
                                  ),
                                  p_d_f.Expanded(
                                    child: p_d_f.Text('Ri Bhoi'),
                                  ),
                                ]),
                                p_d_f.SizedBox(height: 10),
                                p_d_f.Row(children: [
                                  p_d_f.Expanded(
                                    flex: 2,
                                    child: p_d_f.Text(
                                        'Area of work [ mention communication address of the work area]:'),
                                  ),
                                  p_d_f.Expanded(
                                    child: p_d_f.Text('Umiam Industrial Area, Umiam-793103, Meghalaya, India'),
                                  ),
                                ]),
                                p_d_f.SizedBox(height: 10),
                              ]))
                    ])),
            p_d_f.Padding(
                padding: p_d_f.EdgeInsets.symmetric(horizontal: 20),
                child: p_d_f.Row(
                    //mainAxisAlignment: p_d_f.MainAxisAlignment.spaceAround,
                    children: [
                      p_d_f.Expanded(
                        child: p_d_f.Text(
                            'Details of the Establishment/Employer',
                            style: p_d_f.TextStyle(
                                fontWeight: p_d_f.FontWeight.bold)),
                      ),
                    ])),
            p_d_f.Padding(
                padding:
                    p_d_f.EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: p_d_f.Row(
                    crossAxisAlignment: p_d_f.CrossAxisAlignment.start,
                    children: [
                      p_d_f.Expanded(
                          flex: 14,
                          child: p_d_f.Column(
                              crossAxisAlignment:
                                  p_d_f.CrossAxisAlignment.start,
                              children: [
                                p_d_f.Row(children: [
                                  p_d_f.Expanded(
                                    flex: 2,
                                    child: p_d_f.Text(
                                        'Name of the Establishment/Employer:',
                                        style: p_d_f.TextStyle()),
                                  ),
                                  p_d_f.Expanded(
                                    child: p_d_f.Text('RNB Carbides And Ferro Alloys Pvt Ltd.'),
                                  ),
                                ]),
                                p_d_f.SizedBox(height: 10),
                                p_d_f.Row(children: [
                                  p_d_f.Expanded(
                                    flex: 2,
                                    child: p_d_f.Text(
                                        'Address of the establishment:'),
                                  ),
                                  p_d_f.Expanded(
                                    child: p_d_f.Text('Umiam Industrial Area , Dist : Ri-Bhoi, Umiam 793103, Meghalaya'),
                                  ),
                                ]),
                                p_d_f.SizedBox(height: 10),
                                p_d_f.Row(children: [
                                  p_d_f.Expanded(
                                    flex: 2,
                                    child: p_d_f.Text(
                                        'Contact number of Establishment/Employer:'),
                                  ),
                                  p_d_f.Expanded(
                                    child: p_d_f.Text('+918132953936'),
                                  ),
                                ]),
                                p_d_f.SizedBox(height: 10),
                              ]))
                    ])),
            p_d_f.Padding(
                padding: p_d_f.EdgeInsets.symmetric(horizontal: 20),
                child: p_d_f.Row(
                    //mainAxisAlignment: p_d_f.MainAxisAlignment.spaceAround,
                    children: [
                      p_d_f.Expanded(
                        child: p_d_f.Text('Declaration',
                            style: p_d_f.TextStyle(
                                fontWeight: p_d_f.FontWeight.bold)),
                      )
                    ])),
            p_d_f.SizedBox(height: 10),

            p_d_f.Padding(
                padding: p_d_f.EdgeInsets.symmetric(horizontal: 20),
                child: p_d_f.Row(
                  //mainAxisAlignment: p_d_f.MainAxisAlignment.spaceAround,
                    children: [
                      p_d_f.Expanded(
                        child: p_d_f.Text('I hereby declare that the particulars given above are true to the best of my knowledge and belief.',
                            style: p_d_f.TextStyle(
                                fontWeight: p_d_f.FontWeight.bold)),
                      )
                    ])),

            p_d_f.Padding(
                padding: p_d_f.EdgeInsets.symmetric(horizontal: 20),
                child: p_d_f.Row(
                  //mainAxisAlignment: p_d_f.MainAxisAlignment.spaceAround,
                    children: [
                      p_d_f.Expanded(
                        child: p_d_f.Text(
                            'Additional Details',
                            style: p_d_f.TextStyle(
                                fontWeight: p_d_f.FontWeight.bold)),
                      )
                    ])),
            p_d_f.SizedBox(height: 10),
            p_d_f.Padding(
                padding:
                p_d_f.EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: p_d_f.Row(
                    crossAxisAlignment: p_d_f.CrossAxisAlignment.start,
                    children: [
                      p_d_f.Expanded(
                          flex: 14,
                          child: p_d_f.Column(
                              crossAxisAlignment:
                              p_d_f.CrossAxisAlignment.start,
                              children: [
                                p_d_f.Row(children: [
                                  p_d_f.Expanded(
                                    flex: 2,
                                    child: p_d_f.Text(
                                        'Apply to the Office:',
                                        style: p_d_f.TextStyle()),
                                  ),
                                  p_d_f.Expanded(
                                    child: p_d_f.Text('__________________'),
                                  ),
                                ]),
                                p_d_f.SizedBox(height: 10),
                              ]))
                    ])),

          ]),
        );
      }));

//save PDF
  final String dir = (await getApplicationDocumentsDirectory()).path;
  final String path = '$dir/${m.partA.employeeName}-labour_reg.pdf';
  final File file = File(path);
  await file.writeAsBytes(await pdf.save());
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (_) => PdfViewerPage(path: path,name:"Labour Registration Form"),
    ),
  );
}
