import 'package:flutter/material.dart';
// import 'package:flutter_full_pdf_viewer/full_pdf_viewer_scaffold.dart';
import 'package:share_extend/share_extend.dart';
import 'package:pdf_viewer_flutter/pdf_viewer_flutter.dart';

class PdfViewerPage extends StatelessWidget {
  final String path,name;
  const PdfViewerPage({required this.path,required this.name});

  @override
  Widget build(BuildContext context) {
    return PDFViewerScaffold(
      appBar: AppBar(
        title: Text(name),
        centerTitle: true,
        actions: [
          IconButton(onPressed: (){
             ShareExtend.share(path, name);
          }, icon: Icon(Icons.share))
        ],
      ),
      path: path,
    );
  }
}