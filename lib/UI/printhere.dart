import 'package:cheque_print/UI/previewPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class PrintHere extends StatefulWidget {
  final String a1, a2, a3, a4, a5, a6;
  PrintHere(
      {Key? key,
      required this.a1,
      required this.a2,
      required this.a3,
      required this.a4,
      required this.a5,
      required this.a6})
      : super(key: key);

  @override
  State<PrintHere> createState() => _PrintHereState();
}

class _PrintHereState extends State<PrintHere> {

  bool isvisible = false;

  @override
  Widget build(BuildContext context) {
    final main_width = MediaQuery.of(context).size.width;
    final main_height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF076799),
        title: Text("Print here : "),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text("Fname : ${widget.a1}"),
            // Text("Lname : ${widget.a2}"),
            // Text("Date : ${widget.a3}"),
            // Text("Amn/W : ${widget.a4}"),
            // Text("Amount : ${widget.a5}"),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(15),
                  child: Container(
                    decoration: BoxDecoration(color: Colors.blue[100]),
                    height: main_height * 0.3,
                    width: main_width * 0.5,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(color: Colors.white),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              Text(
                                "CHEQUE HOLDER Details",
                                style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25,
                                    color: Colors.deepPurple,
                                    letterSpacing: 1),
                              ),

                              Row(
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "Payee Name : ",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                overflow:
                                                    TextOverflow.ellipsis),
                                          ),
                                          Text("${widget.a5}"),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "Cheque-Date : ",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600),
                                          ),
                                          Text(" ${widget.a2}"),
                                          // Text(" ${widget.a2.replaceAll("-", "")}"),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "Amount : ",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600),
                                          ),
                                          Text("${widget.a4}"),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "Amount : ",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600),
                                          ),
                                          Text("${widget.a4}"),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "Account-Pay : ",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600),
                                          ),
                                          Text("${widget.a6}"),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextButton(
                                      onPressed: () {
                                        _displayPdf();
                                      },
                                      style: TextButton.styleFrom(
                                        backgroundColor: Color(
                                            0xFF076799), // Background Color
                                      ),
                                      child: Text(
                                        "Preview",
                                        style: TextStyle(color: Colors.white),
                                      )),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  TextButton(
                                      onPressed: () {
                                        _createPdf();
                                      },
                                      style: TextButton.styleFrom(
                                        backgroundColor: Color(
                                            0xFF076799), // Background Color
                                      ),
                                      child: Text(
                                        "Print",
                                        style: TextStyle(color: Colors.white),
                                      )),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  TextButton(
                                      onPressed: () {
                                        generatePdf();
                                      },
                                      style: TextButton.styleFrom(
                                        backgroundColor: Color(
                                            0xFF076799), // Background Color
                                      ),
                                      child: Text(
                                        "Genrate pdf",
                                        style: TextStyle(color: Colors.white),
                                      )),
                                ],
                              ),

                              // Stack(
                              //     fit: StackFit.passthrough,
                              //     children: [
                              //       Container(
                              //         height: 336,
                              //         width: 672,
                              //         child: Center(
                              //           child:  Image.asset("assets/images/c5.jpg",
                              //             fit: BoxFit.fill,),
                              //         ),
                              //       ),
                              //
                              //       Positioned(
                              //           top: 95,
                              //           left: 525,
                              //           child: Text("${widget.a2.replaceAll("-", "")}",
                              //               style: TextStyle(
                              //                 letterSpacing: 4.5,
                              //                 fontSize: 11,
                              //                 color: Colors.black,
                              //               )
                              //           )
                              //       ),
                              //
                              //       Positioned(
                              //           top: 95,
                              //           left: 100,
                              //           child: Text("${widget.a5}",
                              //               style: TextStyle(
                              //                 fontSize: 16,
                              //                 color: Colors.black,
                              //               )
                              //           )
                              //       ),
                              //
                              //       Positioned(
                              //           top: 118,
                              //           left: 95,
                              //           child: Text("${widget.a4}",
                              //               style: TextStyle(
                              //                 fontSize: 16,
                              //                 color: Colors.black,
                              //               )
                              //           )
                              //       ),
                              //
                              //       Positioned(
                              //           top: 136,
                              //           left: 392,
                              //           child: Text("${widget.a4}/-",
                              //               style: TextStyle(
                              //                 fontSize: 14,
                              //                 color: Colors.black,
                              //               )
                              //           )
                              //       ),
                              //
                              //
                              //     ]
                              // )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// create PDF & print it
  void _createPdf() async {
    final doc = pw.Document();

    /// for using an image from assets
    // final image = await imageFromAssetBundle('assets/image.png');
    final img = await imageFromAssetBundle("assets/images/c5.jpg");
    final img1 = await imageFromAssetBundle("assets/images/mm.png");
    doc.addPage(
      pw.Page(
        pageFormat:
            PdfPageFormat(17.78 * PdfPageFormat.cm, 8.89 * PdfPageFormat.cm),
        build: (pw.Context context) {
          return pw.Stack(
              fit: pw.StackFit.passthrough,
              overflow: pw.Overflow.visible,
              children: [
                pw.Container(
                  // height: 250,
                  // width: 500,
                  child: pw.Center(
                    child: pw.Image(img, fit: pw.BoxFit.fill),
                  ),
                ),
                pw.Positioned(
                    top: 58,
                    left: 413,
                    child: pw.Text("${widget.a2.replaceAll("-", "")}",
                        style: pw.TextStyle(
                          letterSpacing: 3,
                          fontSize: 11,
                          color: PdfColors.black,
                        ))),

                // pw.Positioned(
                //   top: 1,
                //   left: 1,
                //   child: widget.a6 == "yes" ?
                //      pw.Image(img1,fit: pw.BoxFit.fill) :
                //        pw.Text("")
                //
                // ),

                pw.Positioned(
                    top: 1,
                    left: 1,
                    child: pw.SizedBox(
                        height: 50,
                        width: 50,
                        child: widget.a6 == "Yes" || widget.a6 == "yes" ?  pw.Image(img1)  :
                        pw.Text("")
                    )


                ),


                pw.Positioned(
                    top: 95,
                    left: 100,
                    child: pw.Text("${widget.a5.replaceAll("-", "")}",
                        style: pw.TextStyle(
                          fontSize: 16,
                          color: PdfColors.black,
                        ))),
                pw.Positioned(
                    top: 118,
                    left: 95,
                    child: pw.Text("${widget.a4}",
                        style: pw.TextStyle(
                          fontSize: 16,
                          color: PdfColors.black,
                        ))),
                pw.Positioned(
                    top: 136,
                    left: 392,
                    child: pw.Text("${widget.a4}/-",
                        style: pw.TextStyle(
                          fontSize: 14,
                          color: PdfColors.black,
                        ))),
              ]);
        },
      ),
    );
    await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => doc.save());
  }

  /// display a pdf document.
  void _displayPdf() async {
    final doc = pw.Document();
    final img = await imageFromAssetBundle("assets/images/c5.jpg");
    final img1 = await imageFromAssetBundle("assets/images/mm.png");
    doc.addPage(
      pw.Page(
        pageFormat:
            PdfPageFormat(17.78 * PdfPageFormat.cm, 8.89 * PdfPageFormat.cm),
        build: (pw.Context context) {
          return pw.Stack(
              fit: pw.StackFit.passthrough,
              overflow: pw.Overflow.visible,
              children: [
                pw.Container(
                  // height: 250,
                  // width: 500,
                  child: pw.Center(
                    child: pw.Image(img, fit: pw.BoxFit.fill),
                  ),
                ),


                pw.Positioned(
                    top: 58,
                    left: 413,
                    child: pw.Text("${widget.a2.replaceAll("-", "")}",
                        style: pw.TextStyle(
                          letterSpacing: 3,
                          fontSize: 11,
                          color: PdfColors.black,
                        ))),

               // pw.Positioned(
               //   top: 1,
               //   left: 1,
               //   child: widget.a6 == "yes" ?
               //      pw.Image(img1,fit: pw.BoxFit.fill) :
               //        pw.Text("")
               //
               // ),

                pw.Positioned(
                    top: 1,
                    left: 1,
                    child: pw.SizedBox(
                      height: 50,
                      width: 50,
                      child: widget.a6 == "Yes" || widget.a6 == "yes" ?  pw.Image(img1)  :
                          pw.Text("")
                    )


                ),


                pw.Positioned(
                    top: 95,
                    left: 100,
                    child: pw.Text("${widget.a5.replaceAll("-", "")}",
                        style: pw.TextStyle(
                          fontSize: 16,
                          color: PdfColors.black,
                        ))),
                pw.Positioned(
                    top: 118,
                    left: 95,
                    child: pw.Text("${widget.a4}",
                        style: pw.TextStyle(
                          fontSize: 16,
                          color: PdfColors.black,
                        ))),
                pw.Positioned(
                    top: 136,
                    left: 392,
                    child: pw.Text("${widget.a4}/-",
                        style: pw.TextStyle(
                          fontSize: 14,
                          color: PdfColors.black,
                        ))),
              ]);
        },
      ),
    );

    /// open Preview Screen
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PreviewScreen(doc: doc),
        ));
  }

  /// Convert a Pdf to images, one image per page, get only pages 1 and 2 at 72 dpi
  void _convertPdfToImages(pw.Document doc) async {
    await for (var page
        in Printing.raster(await doc.save(), pages: [0, 1], dpi: 72)) {
      final image = page.toImage(); // ...or page.toPng()
      print(image);
    }
  }

  /// print an existing Pdf file from a Flutter asset
  void _printExistingPdf() async {
    final pdf = await rootBundle.load('assets/document.pdf');
    await Printing.layoutPdf(onLayout: (_) => pdf.buffer.asUint8List());
  }

  /// more advanced PDF styling
  Future<Uint8List> _generatePdf(PdfPageFormat format, String title) async {
    final pdf = pw.Document(version: PdfVersion.pdf_1_5, compress: true);
    final font = await PdfGoogleFonts.nunitoExtraLight();
    final img = await imageFromAssetBundle("assets/images/c5.jpg");
    final img1 = await imageFromAssetBundle("assets/images/mm.png");

    pdf.addPage(
      pw.Page(
        pageFormat:  PdfPageFormat(17.78 * PdfPageFormat.cm, 8.89 * PdfPageFormat.cm),
        build: (pw.Context context) {
          return pw.Stack(
              fit: pw.StackFit.passthrough,
              overflow: pw.Overflow.visible,
              children: [
                pw.Container(
                  // height: 250,
                  // width: 500,
                  child: pw.Center(
                    child: pw.Image(img, fit: pw.BoxFit.fill),
                  ),
                ),
                pw.Positioned(
                    top: 58,
                    left: 413,
                    child: pw.Text("${widget.a2.replaceAll("-", "")}",
                        style: pw.TextStyle(
                          letterSpacing: 3,
                          fontSize: 11,
                          color: PdfColors.black,
                        ))),

                // pw.Positioned(
                //   top: 1,
                //   left: 1,
                //   child: widget.a6 == "yes" ?
                //      pw.Image(img1,fit: pw.BoxFit.fill) :
                //        pw.Text("")
                //
                // ),

                pw.Positioned(
                    top: 1,
                    left: 1,
                    child: pw.SizedBox(
                        height: 50,
                        width: 50,
                        child: widget.a6 == "Yes" || widget.a6 == "yes" ?  pw.Image(img1)  :
                        pw.Text("")
                    )


                ),


                pw.Positioned(
                    top: 95,
                    left: 90,
                    child: pw.Text("${widget.a5.replaceAll("-", "")}",
                        style: pw.TextStyle(
                          fontSize: 16,
                          color: PdfColors.black,
                        ))),
                pw.Positioned(
                    top: 118,
                    left: 95,
                    child: pw.Text("${widget.a4}",
                        style: pw.TextStyle(
                          fontSize: 16,
                          color: PdfColors.black,
                        ))),
                pw.Positioned(
                    top: 136,
                    left: 392,
                    child: pw.Text("${widget.a4}/-",
                        style: pw.TextStyle(
                          fontSize: 14,
                          color: PdfColors.black,
                        ))),
              ]);
        },
      ),
    );
    return pdf.save();
  }

  void generatePdf() async {
    const title = 'eclectify Demo';
    await Printing.layoutPdf(onLayout: (format) => _generatePdf(format, title));
  }
}
