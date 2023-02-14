import 'package:flutter/material.dart';
import 'package:printing/printing.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';


class PreviewScreen extends StatefulWidget {
  final pw.Document doc;
  const PreviewScreen({
    Key? key,
    required this.doc,
  }) : super(key: key);
  @override
  State<PreviewScreen> createState() => _PreviewScreenState();
}

class _PreviewScreenState extends State<PreviewScreen> {
  @override
  Widget build(BuildContext context) {

    final main_width = MediaQuery
        .of(context)
        .size
        .width;
    final main_height = MediaQuery
        .of(context)
        .size
        .height;


    return Scaffold(

      appBar: AppBar(
        backgroundColor: Color(0xFF076799),
        title: Text("Preview"),
      ),

      body: Container(
        // height: main_height * 1,
        // width: main_width * 0.45,
        child: PdfPreview(
          build: (format) => widget.doc.save(),
          allowSharing: true,
          allowPrinting: true,
          initialPageFormat: PdfPageFormat(17.78 * PdfPageFormat.cm, 8.89 * PdfPageFormat.cm),
          pdfFileName: "mydoc.pdf",
          onError: (context, error) => Center(child: Text("Something Went Wrong!"),),
          dynamicLayout: true,
          canChangePageFormat: true,

        ),
      ),

    );
  }
}

