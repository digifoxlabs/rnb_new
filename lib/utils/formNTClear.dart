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

formNTClear(GetFormModel m, context) async {
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
                    child: p_d_f.Text(
                        'Application Form For N.T. Employee Clearance Certificate',
                        style: p_d_f.TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                  p_d_f.Padding(
                      padding: p_d_f.EdgeInsets.symmetric(horizontal: 20),
                      child: p_d_f.Row(
                          //mainAxisAlignment: p_d_f.MainAxisAlignment.spaceAround,
                          children: [
                            p_d_f.Expanded(
                              child: p_d_f.Text(
                                  'To,\n\nThe Secretary to the Executive Committee,\nKhasi Hills Autonomous District Council,Shillong.\n\n\nSir,\n\nI have the honour to request you to kindly grant me a Non-Tribal Employee Clearance Certificate, necessary particulars are as given below:'),
                            )
                          ])),
                  p_d_f.Padding(
                      padding: p_d_f.EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: p_d_f.Row(
                          crossAxisAlignment: p_d_f.CrossAxisAlignment.start,
                          children: [
                            p_d_f.Expanded(
                              child: p_d_f.Text('1.'),
                            ),
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
                                              '(a). Name of the applicant:'),
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
                                          child: p_d_f.Text(
                                              '(b). Home Address of the applicant:'),
                                        ),
                                        p_d_f.Expanded(
                                          child:
                                              p_d_f.Text(m.partC.permanentAddress),
                                        ),
                                      ]),
                                      p_d_f.SizedBox(height: 10),
                                      p_d_f.Row(children: [
                                        p_d_f.Expanded(
                                          flex: 2,
                                          child: p_d_f.Text(
                                              '(c). Address of the Home Police Station with Post-Office:'),
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
                                          child: p_d_f.Text(
                                              '(d). Present address of the applicant with Police Station:'),
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
                                          child: p_d_f.Text(
                                              '(e). Name of the house owner with address:'),
                                        ),
                                        p_d_f.Expanded(
                                          child:
                                              p_d_f.Text('__________________'),
                                        ),
                                      ]),
                                      p_d_f.SizedBox(height: 10),
                                      p_d_f.Row(children: [
                                        p_d_f.Expanded(
                                          flex: 2,
                                          child: p_d_f.Text(
                                              '(f). No. of years residing in Meghalaya:'),
                                        ),
                                        p_d_f.Expanded(
                                          child:
                                              p_d_f.Text(m.partA.yearsInMeghalaya),
                                        ),
                                      ]),
                                      p_d_f.SizedBox(height: 10),
                                      p_d_f.Row(children: [
                                        p_d_f.Expanded(
                                          flex: 2,
                                          child: p_d_f.Text(
                                              '(g). Sex (Male/Female):'),
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
                                          child: p_d_f.Text('(h). Height:'),
                                        ),
                                        p_d_f.Expanded(
                                          child:
                                              p_d_f.Text(m.partA.height),
                                        ),
                                      ]),
                                      p_d_f.SizedBox(height: 10),
                                      p_d_f.Row(children: [
                                        p_d_f.Expanded(
                                          flex: 2,
                                          child: p_d_f.Text(
                                              '(i). Identification Mark:'),
                                        ),
                                        p_d_f.Expanded(
                                          child:
                                              p_d_f.Text(m.partA.identificationMark),
                                        ),
                                      ]),
                                      p_d_f.SizedBox(height: 10),
                                      p_d_f.Row(children: [
                                        p_d_f.Expanded(
                                          flex: 2,
                                          child: p_d_f.Text(
                                              '(j). Married/Un-Married:'),
                                        ),
                                        p_d_f.Expanded(
                                          child:
                                              p_d_f.Text(m.partA.maritalStatus),
                                        ),
                                      ]),
                                      p_d_f.SizedBox(height: 10),
                                      p_d_f.Row(children: [
                                        p_d_f.Expanded(
                                          flex: 2,
                                          child: p_d_f.Text(
                                              '(k). Community/Religion:'),
                                        ),
                                        p_d_f.Expanded(
                                          child:
                                              p_d_f.Text(m.partA.religion),
                                        ),
                                      ]),
                                      p_d_f.SizedBox(height: 10),
                                      p_d_f.Row(children: [
                                        p_d_f.Expanded(
                                          flex: 2,
                                          child: p_d_f.Text(
                                              '(l). Date of Birth and Age as of date:'),
                                        ),
                                        p_d_f.Expanded(
                                          child:
                                              p_d_f.Text(m.partA.dob.day.toString()+"/"+m.partA.dob.month.toString()+"/"+m.partA.dob.year.toString()+"("+calculateAge(m.partA.dob).toString()+")"),
                                        ),
                                      ]),
                                    ]))
                          ])),
                  p_d_f.Padding(
                      padding: p_d_f.EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      child: p_d_f.Row(
                          crossAxisAlignment: p_d_f.CrossAxisAlignment.start,
                          children: [
                            p_d_f.Expanded(
                              child: p_d_f.Text('2.'),
                            ),
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
                                              '(a). Father\'s name:'),
                                        ),
                                        p_d_f.Expanded(
                                          child:
                                              p_d_f.Text(m.partA.fathersName),
                                        ),
                                      ]),
                                      p_d_f.SizedBox(
                                        height: 10,
                                      ),
                                      p_d_f.Row(children: [
                                        p_d_f.Expanded(
                                          flex: 2,
                                          child: p_d_f.Text(
                                              '(a). Mother\'s name:'),
                                        ),
                                        p_d_f.Expanded(
                                          child:
                                              p_d_f.Text(m.partA.mothersName),
                                        ),
                                      ]),
                                      p_d_f.SizedBox(
                                        height: 10,
                                      ),
                                    ]))
                          ])),
                  p_d_f.Padding(
                      padding: p_d_f.EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      child: p_d_f.Row(
                          crossAxisAlignment: p_d_f.CrossAxisAlignment.start,
                          children: [
                            p_d_f.Expanded(
                              child: p_d_f.Text('3.'),
                            ),
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
                                              'No. of family members residing in Meghalaya:'),
                                        ),
                                        p_d_f.Expanded(
                                          child:
                                              p_d_f.Text(m.partA.familyMembersInMeghalaya),
                                        ),
                                      ]),
                                      p_d_f.SizedBox(
                                        height: 10,
                                      ),
                                    ]))
                          ])),
                  p_d_f.Padding(
                      padding: p_d_f.EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      child: p_d_f.Row(
                          crossAxisAlignment: p_d_f.CrossAxisAlignment.start,
                          children: [
                            p_d_f.Expanded(
                              child: p_d_f.Text('4.'),
                            ),
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
                                              'Whether convicted in connection with a criminal case at any time:'),
                                        ),
                                        p_d_f.Expanded(
                                          child:
                                              p_d_f.Text(m.partA.pendingCriminalCase),
                                        ),
                                      ]),
                                      p_d_f.SizedBox(
                                        height: 10,
                                      ),
                                    ]))
                          ])),
                  p_d_f.Padding(
                      padding: p_d_f.EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      child: p_d_f.Row(
                          crossAxisAlignment: p_d_f.CrossAxisAlignment.start,
                          children: [
                            p_d_f.Expanded(
                              child: p_d_f.Text('5.'),
                            ),
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
                                              'Type of service/work:'),
                                        ),
                                        p_d_f.Expanded(
                                          child:
                                              p_d_f.Text(m.partA.jobNature.jobNatureName),
                                        ),
                                      ]),
                                      p_d_f.SizedBox(
                                        height: 10,
                                      ),
                                    ]))
                          ])),
                  p_d_f.Padding(
                      padding: p_d_f.EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      child: p_d_f.Row(
                          crossAxisAlignment: p_d_f.CrossAxisAlignment.start,
                          children: [
                            p_d_f.Expanded(
                              child: p_d_f.Text('6.'),
                            ),
                            p_d_f.Expanded(
                                flex: 14,
                                child: p_d_f.Column(
                                    crossAxisAlignment:
                                        p_d_f.CrossAxisAlignment.start,
                                    children: [
                                      p_d_f.Row(children: [
                                        p_d_f.Expanded(
                                          flex: 2,
                                          child: p_d_f.Text('Place of work:'),
                                        ),
                                        p_d_f.Expanded(
                                          child:
                                              p_d_f.Text('__________________'),
                                        ),
                                      ]),
                                      p_d_f.SizedBox(
                                        height: 10,
                                      ),
                                    ]))
                          ])),
                  p_d_f.Padding(
                      padding: p_d_f.EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      child: p_d_f.Row(
                          crossAxisAlignment: p_d_f.CrossAxisAlignment.start,
                          children: [
                            p_d_f.Expanded(
                              child: p_d_f.Text('7.'),
                            ),
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
                                              'Wages drawn daily/annually:'),
                                        ),
                                        p_d_f.Expanded(
                                          child:
                                              p_d_f.Text(m.partA.salaryPm),
                                        ),
                                      ]),
                                      p_d_f.SizedBox(
                                        height: 10,
                                      ),
                                    ]))
                          ]))
                ]));
      }));
  pdf.addPage(p_d_f.Page(
      pageFormat: PdfPageFormat.a4,
      build: (p_d_f.Context context) {
        return p_d_f.Container(
          decoration: p_d_f.BoxDecoration(color: PdfColors.grey100),
          alignment: p_d_f.Alignment.topCenter,
          child: p_d_f.Column(
            children: [
              p_d_f.Padding(
                padding: p_d_f.EdgeInsets.fromLTRB(20, 20, 20, 10),
                child: p_d_f.Row(
                  crossAxisAlignment: p_d_f.CrossAxisAlignment.start,
                  children: [
                    p_d_f.Expanded(
                      child: p_d_f.Text('8.'),
                    ),
                    p_d_f.Expanded(
                        flex: 14,
                        child: p_d_f.Column(
                            crossAxisAlignment: p_d_f.CrossAxisAlignment.start,
                            children: [
                              p_d_f.Row(children: [
                                p_d_f.Expanded(
                                  flex: 2,
                                  child: p_d_f.Text('(a). Name of Employer:'),
                                ),
                                p_d_f.Expanded(
                                  child: p_d_f.Text(m.partA.employeeName),
                                ),
                              ]),
                              p_d_f.SizedBox(
                                height: 10,
                              ),
                              p_d_f.Row(children: [
                                p_d_f.Expanded(
                                  flex: 2,
                                  child: p_d_f.Text(
                                      '(b). Address of Employer with contact number:'),
                                ),
                                p_d_f.Expanded(
                                  child: p_d_f.Text(m.partC.permanentAddress + ',' + m.partA.mobileNo ),
                                ),
                              ]),
                              p_d_f.SizedBox(
                                height: 10,
                              ),
                              p_d_f.Row(children: [
                                p_d_f.Expanded(
                                  flex: 2,
                                  child: p_d_f.Text(
                                      '(c). Trading license number:'),
                                ),
                                p_d_f.Expanded(
                                  child: p_d_f.Text('__________________'),
                                ),
                              ]),
                              p_d_f.SizedBox(
                                height: 10,
                              ),
                            ]))
                  ],
                ),
              ),
              p_d_f.Padding(
                padding: p_d_f.EdgeInsets.fromLTRB(20, 20, 20, 10),
                child: p_d_f.Row(
                  crossAxisAlignment: p_d_f.CrossAxisAlignment.start,
                  children: [
                    p_d_f.Expanded(
                      child: p_d_f.Text('9.'),
                    ),
                    p_d_f.Expanded(
                        flex: 14,
                        child: p_d_f.Column(
                            crossAxisAlignment: p_d_f.CrossAxisAlignment.start,
                            children: [
                              p_d_f.Row(children: [
                                p_d_f.Expanded(
                                  flex: 2,
                                  child: p_d_f.Text(
                                      'Are you a citizen of India?:'),
                                ),
                                p_d_f.Expanded(
                                  child: p_d_f.Text(m.partA.indiaCitizen),
                                ),
                              ]),
                              p_d_f.SizedBox(
                                height: 10,
                              ),
                            ]))
                  ],
                ),
              ),
              p_d_f.Padding(
                padding: p_d_f.EdgeInsets.fromLTRB(20, 20, 20, 10),
                child: p_d_f.Row(
                  crossAxisAlignment: p_d_f.CrossAxisAlignment.start,
                  children: [
                    p_d_f.Expanded(
                      child: p_d_f.Text('10.'),
                    ),
                    p_d_f.Expanded(
                        flex: 14,
                        child: p_d_f.Column(
                            crossAxisAlignment: p_d_f.CrossAxisAlignment.start,
                            children: [
                              p_d_f.Row(children: [
                                p_d_f.Expanded(
                                  flex: 2,
                                  child: p_d_f.Text(
                                      'Whether the applicant has been convicted of any offence involving moral turpitude or under Act/Rule/Regulation made by the District Council:'),
                                ),
                                p_d_f.Expanded(
                                  child: p_d_f.Text('__________________'),
                                ),
                              ]),
                              p_d_f.SizedBox(
                                height: 10,
                              ),
                            ]))
                  ],
                ),
              ),
              p_d_f.Padding(
                padding: p_d_f.EdgeInsets.fromLTRB(20, 20, 20, 10),
                child: p_d_f.Row(
                  crossAxisAlignment: p_d_f.CrossAxisAlignment.start,
                  children: [
                    p_d_f.Expanded(
                      child: p_d_f.Text('11.'),
                    ),
                    p_d_f.Expanded(
                        flex: 14,
                        child: p_d_f.Column(
                            crossAxisAlignment: p_d_f.CrossAxisAlignment.start,
                            children: [
                              p_d_f.Row(children: [
                                p_d_f.Expanded(
                                  flex: 2,
                                  child: p_d_f.Text(
                                      'Name of two responsible person who will vouch for you with proper address and mobile number:'),
                                ),
                                p_d_f.Expanded(
                                  child: p_d_f.Text(m.partA.emergencyPhoneNo),
                                ),
                              ]),
                              p_d_f.SizedBox(
                                height: 10,
                              ),
                            ]))
                  ],
                ),
              ),
              p_d_f.Padding(
                padding: p_d_f.EdgeInsets.fromLTRB(20, 20, 20, 10),
                child: p_d_f.Row(
                  crossAxisAlignment: p_d_f.CrossAxisAlignment.start,
                  children: [
                    p_d_f.Expanded(
                      child: p_d_f.Text('12.'),
                    ),
                    p_d_f.Expanded(
                        flex: 14,
                        child: p_d_f.Column(
                            crossAxisAlignment: p_d_f.CrossAxisAlignment.start,
                            children: [
                              p_d_f.Row(children: [
                                p_d_f.Expanded(
                                  flex: 2,
                                  child: p_d_f.Text(
                                      'Any other special information:'),
                                ),
                                p_d_f.Expanded(
                                  child: p_d_f.Text(m.partA.otherInformation),
                                ),
                              ]),
                              p_d_f.SizedBox(
                                height: 10,
                              ),
                            ]))
                  ],
                ),
              ),
              p_d_f.SizedBox(height: 10),
              p_d_f.Padding(
                  padding: p_d_f.EdgeInsets.symmetric(horizontal: 20),
                  child: p_d_f.Text(
                      '\t\t\t\t\t\tI do hereby declare that the statements given above are true and correct to the best of my knowledge, information and belief. If any of the statement is false, I am liable to any punishment as deem fit and proper by the competent authority.')),
              p_d_f.Padding(
                  padding: p_d_f.EdgeInsets.fromLTRB(20, 40, 20, 20),
                  child: p_d_f.Row(children: [
                    p_d_f.Expanded(
                      flex: 2,
                      child: p_d_f.Text('Dated:'),
                    ),
                    p_d_f.Expanded(
                      child: p_d_f.Text('Signature of the Applicant'),
                    ),
                  ]))
            ],
          ),
        );
      }));

//save PDF
  final String dir = (await getApplicationDocumentsDirectory()).path;
  final String path = '$dir/${m.partA.employeeName}-N.T. Employee Clearance Certificate.pdf';
  final File file = File(path);
  await file.writeAsBytes(await pdf.save());
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (_) => PdfViewerPage(path: path,name:"N.T. Employee Clearance Certificate"),
    ),
  );
 }

calculateAge(DateTime birthDate) {
  DateTime currentDate = DateTime.now();
  int age = currentDate.year - birthDate.year;
  int month1 = currentDate.month;
  int month2 = birthDate.month;
  if (month2 > month1) {
    age--;
  } else if (month1 == month2) {
    int day1 = currentDate.day;
    int day2 = birthDate.day;
    if (day2 > day1) {
      age--;
    }
  }
  return age;
}
