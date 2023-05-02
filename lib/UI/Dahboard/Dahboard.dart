import 'dart:math';

import 'package:cheque_print/UI/Logprint/LogPrint.dart';
import 'package:cheque_print/UI/USERS/users_data.dart';
import 'package:cheque_print/UI/loginpage/loginpage.dart';
import 'package:cheque_print/UI/printHere/printhere.dart';
import 'package:cheque_print/api/api.dart';
import 'package:cheque_print/model/post_excel_model.dart';
import 'package:http/http.dart' as http;
import 'package:cheque_print/commonWidget/themeHelper.dart';
import 'package:cheque_print/network/api_client.dart';
import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:number_to_words/number_to_words.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid_export/export.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' hide Column, Row, Border;
import 'package:url_launcher/url_launcher.dart';
import '../../bloc/Dashboard/Dashboard_bloc.dart';
import '../../commonWidget/GridDataCommonFunc.dart';
import 'package:cheque_print/helper/save_file_mobile.dart'
if (dart.library.html) 'helper/save_file_web.dart' as helper;
import 'dart:io';
import 'package:open_file/open_file.dart';
import 'package:universal_html/html.dart' show AnchorElement;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:convert';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:number_to_words_english/number_to_words_english.dart';
import 'package:intl/intl.dart';

import 'package:cheque_print/UI/printHere/previewPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:number_to_words_english/number_to_words_english.dart';
import 'package:intl/intl.dart';

import '../../commonWidget/themeHelper.dart';
import '../../model/user_data_model.dart';
import '../../network/repositary.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  DashboardBloc DBBloc = DashboardBloc(Repository.getInstance());

  bool? bulkPrintPressed;

  late TableDataSource _tableDataSource;

  List<List<dynamic>> bulkprintData = [];

  List<List<dynamic>> rowdata1 = [];

  Repository repositoryRepo = Repository(ApiClient(httpClient: http.Client()));

  List<dynamic> _row = [];
  String? filePath;

  @override
  void initState() {
    super.initState();

    print("init print");
    loadui1();
    _tableDataSource =
        TableDataSource(context, x1: [], DBBloc, repositoryRepo, rowdata1);
  }

  loadui1() async {
    DBBloc.add(AllFetchDataForDashboardPageEvent());
    // print("response $response");
  }

  final GlobalKey<SfDataGridState> _key = GlobalKey<SfDataGridState>();

  Future<void> createExcel1() async {
    // final snackBar = SnackBar(
    //   duration: Duration(seconds: 2),
    //   content: const Text("Getting Excel Format!"),
    //   backgroundColor: Color(0xFF076799),
    //   action: SnackBarAction(
    //     label: 'dismiss',
    //     onPressed: () {},
    //   ),
    // );
    // ScaffoldMessenger.of(context).showSnackBar(snackBar);

    //
    // final main_width = MediaQuery.of(context).size.width;
    //
    // ThemeHelper.customDialogForMessage(
    //     isBarrierDismissible: false,
    //     context,
    //     "Getting Excel Format!",
    //     main_width * 0.25,
    //     // contentMessage: contentMes,
    //         () {
    //       // Navigator.of(context).pop('refresh');
    //       Navigator.of(context).pop();
    //       // Navigator.of(context).pop('refresh');
    //     },
    //     ForSuccess: true);

    final Workbook workbook = Workbook();
    final Worksheet sheet = workbook.worksheets[0];
    sheet.enableSheetCalculations();

    sheet.getRangeByName('A1').setValue('SR-NO');
    sheet.getRangeByName('B1').setValue('CHEQUEDATE');
    sheet.getRangeByName('C1').setValue('CHEQUE NO');
    sheet.getRangeByName('D1').setValue('AMOUNT');
    sheet.getRangeByName('E1').setValue('PAYEENAME');
    sheet.getRangeByName('F1').setValue('AccountPay');

    sheet.getRangeByName('A2').setValue('1');
    sheet.getRangeByName('B2').setText('19-02-2023');
    sheet.getRangeByName('C2').setValue('123456789');
    sheet.getRangeByName('D2').setValue('987654321');
    sheet.getRangeByName('E2').setValue('Feeltech');
    sheet.getRangeByName('F2').setValue('Yes');

    sheet.getRangeByName('A3').setValue('2');
    sheet.getRangeByName('B3').setText('23-03-2018');
    sheet.getRangeByName('C3').setValue('347983202');
    sheet.getRangeByName('D3').setValue('947578743');
    sheet.getRangeByName('E3').setValue('Feeltech');
    sheet.getRangeByName('F3').setValue('No');

    final List<int> bytes = workbook.saveAsStream();

    workbook.dispose();

    if (kIsWeb) {
      print("trure here");
      AnchorElement(
          href:
          'data:application/octet-stream;charset=utf-16le;base64,${base64.encode(bytes)}')
        ..setAttribute('download', 'Output.xlsx')
        ..click();
    } else {
      print("false here ");
      final String path = (await getApplicationSupportDirectory()).path;
      final String fileName =
      Platform.isWindows ? '$path\\Output.xlsx' : '$path/Output.xlsx';
      final File file = File(fileName);
      await file.writeAsBytes(bytes);
      OpenFile.open(fileName);
    }
  }

  Future<void> createExcel() async {
    var excel = Excel.createExcel();

    for (var table in excel.tables.keys) {
      print(table);
      print(excel.tables[table]!.maxCols);
      print(excel.tables[table]!.maxRows);
      for (var row in excel.tables[table]!.rows) {
        print("${row.map((e) => e?.value)}");
      }
    }

    excel.setDefaultSheet("abc");

    print("excel : ${excel.sheets[0]}");
    excel.updateCell(excel.getDefaultSheet().toString(),
        CellIndex.indexByString("A1"), "SR-NO");
    excel.updateCell(excel.getDefaultSheet().toString(),
        CellIndex.indexByString("B1"), "CHEQUEDATE");
    excel.updateCell(excel.getDefaultSheet().toString(),
        CellIndex.indexByString("C1"), "CHEQUE NO");
    excel.updateCell(excel.getDefaultSheet().toString(),
        CellIndex.indexByString("D1"), "AMOUNT");
    excel.updateCell(excel.getDefaultSheet().toString(),
        CellIndex.indexByString("E1"), "PAYEENAME");
    excel.updateCell(excel.getDefaultSheet().toString(),
        CellIndex.indexByString("F1"), "AccountPay");

    excel.updateCell(
        excel.getDefaultSheet().toString(), CellIndex.indexByString("A2"), "1");
    excel.updateCell(excel.getDefaultSheet().toString(),
        CellIndex.indexByString("B2"), "19-01-2023");
    excel.updateCell(excel.getDefaultSheet().toString(),
        CellIndex.indexByString("C2"), "23456 8765223 8923 32");
    excel.updateCell(excel.getDefaultSheet().toString(),
        CellIndex.indexByString("D2"), "123456789");
    excel.updateCell(excel.getDefaultSheet().toString(),
        CellIndex.indexByString("E2"), "Feeltech Solutions");
    excel.updateCell(excel.getDefaultSheet().toString(),
        CellIndex.indexByString("F2"), "Yes");

    excel.updateCell(
        excel.getDefaultSheet().toString(), CellIndex.indexByString("A3"), "2");
    excel.updateCell(excel.getDefaultSheet().toString(),
        CellIndex.indexByString("B3"), "20-02-2023");
    excel.updateCell(excel.getDefaultSheet().toString(),
        CellIndex.indexByString("C3"), "23456 5465223 6533 45");
    excel.updateCell(excel.getDefaultSheet().toString(),
        CellIndex.indexByString("D3"), "123456789");
    excel.updateCell(excel.getDefaultSheet().toString(),
        CellIndex.indexByString("E3"), "Feeltech Solutions");
    excel.updateCell(excel.getDefaultSheet().toString(),
        CellIndex.indexByString("F3"), "No");

    // var sheet = excel["Sheet 1"];
    // excel.updateCell(excel.sheets[0].toString(), CellIndex.indexByString("A1"), "1");

    // var cell = sheet.cell(CellIndex.indexByString("A1"));
    // cell.value = "Heya How are you I am fine ok goood night";
    // // cell.cellStyle = cellStyle;

    var fileBytes = excel.save();
    // excel.copy("A1", "A1");
    // excel.updateCell(sheet, cellIndex, value)

    var directory = (await getApplicationSupportDirectory()).path;
    ;
    final String fileName = Platform.isWindows
        ? '$directory\\Output.xlsx'
        : '$directory/Output.xlsx';

    final File file = File(fileName);
    await file.writeAsBytes(fileBytes!);
    // OpenFile.open(fileName);

    OpenFile.open(fileName);
    print("directory $directory");
    print("directory $fileName");

    // final String fileName =
    // Platform.isWindows ? '$path\\Output.xlsx' : '$path/Output.xlsx';
    // final File file = File(fileName);
    // await file.writeAsBytes(bytes);
    // OpenFile.open(fileName);

    //Create a Excel document.
    //Creating a workbook.
    // final Workbook workbook = Workbook();
    // //Accessing via index.
    // final Worksheet sheet = workbook.worksheets[0];
    // // Set the text value.
    // sheet.getRangeByName('A1').setText('Hello!!');
    // //Save and launch the excel.
    // final List<int> bytes = workbook.saveAsStream();
    // //Dispose the document.
    // workbook.dispose();
    //
    // final String path = (await getApplicationSupportDirectory()).path;
    // final String fileName =
    // Platform.isWindows ? '$path\\Output.xlsx' : '$path/Output.xlsx';
    // final File file = File(fileName);
    // await file.writeAsBytes(bytes);
    // OpenFile.open(fileName);

    // final String path = (await getApplicationSupportDirectory()).path;
    // final String fileName =
    // Platform.isWindows ? '$path\\Output.xlsx' : '$path/Output.xlsx';
    // final File file = File(fileName);
    // await file.writeAsBytes(fileBytes);
    // OpenFile.open(excel);
  }

  void _pickFile() async {
    final main_width = MediaQuery.of(context).size.width;

    FilePickerResult? result = await FilePicker.platform.pickFiles(
      withData: true,
      allowedExtensions: ['xlsx'],
      // type: FileType.custom,
    );

    // print("result $result");

    if (result != null) {
      List<dynamic> xlsxToList = [];
      PlatformFile file = result.files.first;
      // print(file.name);
      // print(file.bytes);
      // print(file.size);
      // print(file.extension);
      // print(file.path);
      // var bytes = result.files.single.bytes;
      var bytes = result.files.single.bytes;
      // print("bytes : $bytes");

      var excel = Excel.decodeBytes(bytes!);

      // final row = excel.tables[excel.tables.keys.first]!.rows
      //     .map((e) => e.map((e) => e!.value).toList())
      //     .toList();
      // print("abc here");
      // excel.tables[excel.tables.keys.first]!.rows
      //     .map((e) => e.map((e) => print("${e!.value}")).toList())
      //     .toList();

      try {
        final row = excel.tables[excel.tables.keys.first]!.rows
            .map((e) => e.map((e) => e!.value).toList())
            .toList();

        var x1 = row..removeAt(0);

        rowdata1 = x1;

        // final snackBar = SnackBar(
        //   duration: Duration(seconds: 2),
        //   content: const Text("Excel Imported Successfully!"),
        //   backgroundColor: Color(0xFF076799),
        //   action: SnackBarAction(
        //     label: 'dismiss',
        //     onPressed: () {},
        //   ),
        // );
        // ScaffoldMessenger.of(context).showSnackBar(snackBar);

        ThemeHelper.customDialogForMessage(
            isBarrierDismissible: false,
            context,
            "Excel Imported Successfully!",
            main_width * 0.25,
            // contentMessage: contentMes,
                () {
              // Navigator.of(context).pop('refresh');
              Navigator.of(context).pop();
              // Navigator.of(context).pop('refresh');
            }, ForSuccess: true);
      } catch (e) {
        // final snackBar = SnackBar(
        //   duration: Duration(seconds: 2),
        //   content: const Text("Excel is not in Format!"),
        //   backgroundColor: Color(0xFF076799),
        //   action: SnackBarAction(
        //     label: 'dismiss',
        //     onPressed: () {},
        //   ),
        // );
        // ScaffoldMessenger.of(context).showSnackBar(snackBar);
        //
        //
        //

        final main_width = MediaQuery.of(context).size.width;

        ThemeHelper.customDialogForMessage(
            isBarrierDismissible: false,
            context,
            "Excel is not in Format!",
            main_width * 0.25,
            // contentMessage: contentMes,
                () {
              // Navigator.of(context).pop('refresh');
              Navigator.of(context).pop();
              // Navigator.of(context).pop('refresh');
            }, ForSuccess: false);
      }

      print("only data : $rowdata1");
      print("only data : ${rowdata1.elementAt(0)}");
      _tableDataSource = TableDataSource(
          context, DBBloc, x1: rowdata1, repositoryRepo, rowdata1);

      print("all data $rowdata1");
      // print("one data ${rowdata1.elementAt(1)}");
      // print("one data ${x1.elementAt(1).elementAt(3)}");

      bulkprintData = rowdata1;

      setState(() {});
    } else {}
  }

  void _createPdf() async {
    print("call data page");

    final doc = pw.Document();
    final img1 = await imageFromAssetBundle("assets/images/mm.png");

    for (int i = 0; i < bulkprintData.length; i++) {
      doc.addPage(
        pw.MultiPage(
            maxPages: 10,
            margin: pw.EdgeInsets.all(0.0),
            pageFormat: PdfPageFormat.a4,
            // clip: true,
            // pageFormat: PdfPageFormat(
            //   22 * PdfPageFormat.cm,
            //   8 * PdfPageFormat.cm,
            // ),
            build: (pw.Context context) =>
            <pw.Widget>[
              pw.Wrap(children: [
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.center,
                  children: [
                    pw.Transform.rotateBox(angle: 90/180 * pi,
                    child:
                    pw.Container(
                        height: 9 * PdfPageFormat.cm,
                        width: 22 * PdfPageFormat.cm,
                        child: pw.Stack(children: [
                          pw.Positioned(
                              top: 17.5,
                              left: 488,
                              child: pw.Text(
                                  "${bulkprintData[i].elementAt(1).toString().replaceAll("-", "")}",
                                  style: pw.TextStyle(
                                    letterSpacing: 8.5,
                                    fontSize: 11,
                                    color: PdfColors.black,
                                  ))),
                          pw.Positioned(
                              top: 0,
                              left: 53,
                              child: pw.SizedBox(
                                  height: 50,
                                  width: 50,
                                  child: bulkprintData[i]
                                      .elementAt(5)
                                      .toString() ==
                                      "Yes" ||
                                      bulkprintData[i]
                                          .elementAt(5)
                                          .toString() ==
                                          "yes"
                                      ? pw.Image(img1)
                                      : pw.Text(""))),
                          pw.Positioned(
                              top: 51.5,
                              left: 115,
                              child: pw.Text("***${bulkprintData[i].elementAt(4)}***",
                                  style: pw.TextStyle(
                                    font: pw.Font.times(),
                                    fontWeight: pw.FontWeight.bold,
                                    fontSize: 12,
                                    color: PdfColors.black,
                                  ))),
                          pw.Positioned(
                              top: 77.5,
                              left: 138,
                              child: pw.Container(
                                height: 50,
                                width: 430,
                                child: pw.Text(
                                  "***${NumberToWord().convert('en-in', int.parse(bulkprintData[i].elementAt(3).toString()))} only***"
                                  // "${NumberToWordsEnglish.convert(int.parse(bulkprintData[i].elementAt(3).toString()))} only"
                                      .toUpperCase(),
                                  maxLines: 2,
                                  style: pw.TextStyle(
                                    font: pw.Font.times(),
                                    fontSize: 12,
                                    lineSpacing: 9,
                                    // letterSpacing: 1,
                                    fontWeight: pw.FontWeight.bold,
                                    color: PdfColors.black,
                                  ),
                                ),
                              )),
                          pw.Positioned(
                              top: 97,
                              left: 495,
                              child: pw.Text(
                                  "*** ${NumberFormat.simpleCurrency(locale: 'hi-In', decimalDigits: 2).format(int.parse(bulkprintData[i].elementAt(3).toString()))}"
                                      .replaceAll("₹", ""),
                                  style: pw.TextStyle(
                                    // letterSpacing: 1,
                                    fontSize: 10,
                                    color: PdfColors.black,
                                  ))),
                        ]))
                    )
                  ]
                )
              ])
            ]),
      );

      bool? tempBool;
      if (bulkprintData[i].elementAt(5).toString() == "Yes" ||
          bulkprintData[i].elementAt(5).toString() == "yes") {
        tempBool = true;
      } else {
        tempBool = false;
      }
      DBBloc.add(PostExcelDataEvent(
          bulkprintData[i].elementAt(2).toString(),
          bulkprintData[i].elementAt(1).toString(),
          tempBool,
          bulkprintData[i].elementAt(3).toString(),
          bulkprintData[i].elementAt(4).toString()));

      // bulkprintData[i].remove(i);
      // print("abc object are : ${bulkprintData.removeAt(0)}");
      // bulkprintData.removeAt(i);

      // print("abc object are : ${bulkprintData}");

      // DBbloc2.add(PostExcelDataEvent(row.getCells()[2].value.toString(),row.getCells()[1].value.toString(), tempBool, row.getCells()[3].value.toString(),row.getCells()[4].value.toString()));

      // row.getCells().remove(rows);
    }

    final ab = await Printing.layoutPdf(
      // format:  PdfPageFormat(22 * PdfPageFormat.cm, 8 * PdfPageFormat.cm),
        onLayout: (PdfPageFormat format) async => doc.save());

    print("nlkscnda ${ab}");
    print("nlkscnda ${ab.runtimeType}");

    if (ab == true) {
      print("abc");
      //
      // final snackBar = SnackBar(
      //   duration: Duration(seconds: 2),
      //   content: const Text("Bulk Print!"),
      //   backgroundColor: Color(0xFF076799),
      //   action: SnackBarAction(
      //     label: 'dismiss',
      //     onPressed: () {},
      //   ),
      // );
      // ScaffoldMessenger.of(context).showSnackBar(snackBar);
      //
      //

      final main_width = MediaQuery.of(context).size.width;
      TextSpan contentMes = TextSpan(
          text: "Data has moved to Print Log!",style: TextStyle(color: Colors.grey, fontSize: 15));
      ThemeHelper.customDialogForMessage(
          isBarrierDismissible: false,
          context,
          "Bulk Print Successful!",
          main_width * 0.25,
          contentMessage: contentMes,
              () {
            if (bulkPrintPressed == true) {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => Dashboard()));
            }
            else{
              Navigator.of(context).pop();
            }
          }, ForSuccess: true);



    } else {
      print("xyz");
    }
  }

  DateTime currentTime = new DateTime.now();

  @override
  Widget build(BuildContext context) {
    final main_width = MediaQuery.of(context).size.width;
    final main_height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(40),
        child: AppBar(
          // foregroundColor: Colors.black,
          leading: IconButton(
            tooltip: "Logout",
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Row(
                        children: [
                          Text("Do you want to Logout?"),
                        ],
                      ),
                      content: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            width: 40,
                          ),
                          ElevatedButton(
                              onPressed: () async {
                                // SharedPreferences pref = await SharedPreferences.getInstance();
                                // pref.clear();
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (context) => LoginPage()),
                                        (route) => false);
                              },
                              child: Text("Yes")),
                          ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text("No")),
                        ],
                      ),
                      shadowColor: Colors.grey,
                    );
                  })
            },
          ),
          backgroundColor: Color(0xFF3182B3),
          title: Text("FTS Bulk Cheque Printing Software"),
        ),
      ),
      body: BlocProvider<DashboardBloc>(
        create: (context) => DBBloc..add(DashboardInitialEvent()),
        child: BlocConsumer<DashboardBloc, DashboardStates>(
          builder: (context, state) {
            if (state is DashboardLoadingState) {
              return ThemeHelper.buildLoadingWidget();
            } else {
              return mainBodyData();
            }
          },
          listener: (context, state) async {
            if (state is APIFailureState) {
              CircularProgressIndicator();
              // ThemeHelper.toastForAPIFaliure(state.exception.toString());
            } else if (state is PostExcelDataEventState) {
              print("------------------------");
            }
          },
        ),
      ),
    );
  }

  Widget mainBodyData() {
    final main_width = MediaQuery.of(context).size.width;
    final main_height = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "CHEQUE DETAILS : ",
                  softWrap: false,
                  maxLines: 1,
                  overflow: TextOverflow.fade,
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(width: 3, color: Colors.black)),
                      height: main_height * 0.73,
                      child: SfDataGridTheme(
                        data: SfDataGridThemeData(
                          headerColor: Color(0xFF3182B3),
                        ),
                        child: SfDataGrid(
                          key: _key,
                          // shrinkWrapRows: true,
                          allowFiltering: true,
                          allowSorting: true,
                          gridLinesVisibility: GridLinesVisibility.both,
                          headerGridLinesVisibility: GridLinesVisibility.both,
                          rowHeight: 35,
                          headerRowHeight: 35,
                          footerHeight: 30,
                          // isScrollbarAlwaysShown: true,
                          source: _tableDataSource,
                          columns: [
                            GridDataCommonFunc.tableColumnsDataLayout(
                                columnName: 'SR-NO',
                                toolTipMessage: 'SR-NO',
                                columnTitle: 'SR-NO',
                                columnWidthModeData:
                                ColumnWidthMode.fitByColumnName),
                            GridDataCommonFunc.tableColumnsDataLayout(
                                columnName: 'CHEQUE-DATE',
                                toolTipMessage: 'CHEQUE-DATE',
                                columnTitle: 'CHEQUE-DATE',
                                columnWidthModeData: ColumnWidthMode.fill),
                            GridDataCommonFunc.tableColumnsDataLayout(
                                columnName: 'CHEQUE-NO',
                                toolTipMessage: 'CHEQUE-NO',
                                columnTitle: 'CHEQUE-NO',
                                columnWidthModeData: ColumnWidthMode.fill),
                            GridDataCommonFunc.tableColumnsDataLayout(
                                columnName: 'Amount',
                                toolTipMessage: 'Amount',
                                columnTitle: 'Amount',
                                columnWidthModeData: ColumnWidthMode.fill),
                            GridDataCommonFunc.tableColumnsDataLayout(
                                columnName: 'PAYEE-NAME',
                                toolTipMessage: 'PAYEE-NAME',
                                columnTitle: 'PAYEE-NAME',
                                columnWidthModeData: ColumnWidthMode.fill),
                            GridDataCommonFunc.tableColumnsDataLayout(
                                columnName: 'AccountPay',
                                toolTipMessage: 'AccountPay',
                                columnTitle: 'AccountPay',
                                columnWidthModeData: ColumnWidthMode.fill),
                            GridDataCommonFunc.tableColumnsDataLayout(
                                columnName: 'Action',
                                toolTipMessage: 'Action',
                                columnTitle: 'Action',
                                columnWidthModeData: ColumnWidthMode.fill),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Container(
                      width: main_width * 0.24,
                      height: main_height * 0.73,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(width: 3, color: Colors.black),
                          borderRadius: BorderRadius.circular(5)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            height: 150,
                            width: 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3),
                            ),
                            child: Image.asset("assets/images/icn.png"),
                          ),
                          Container(
                            height: main_height * 0.065,
                            width: main_width * 0.22,
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      blurRadius: 0.000001, color: Colors.grey),
                                ],
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.white),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 5, right: 5, bottom: 5, top: 5),
                              child: Container(
                                height: main_height * 0.025,
                                width: main_width * 0.20,
                                decoration: BoxDecoration(
                                    color: Colors.blue[50],
                                    borderRadius: BorderRadius.circular(7)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "${companyName.toString()}",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: main_height * 0.06,
                            width: main_width * 0.22,
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      blurRadius: 0.000001, color: Colors.grey),
                                ],
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.white),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 5, bottom: 5, left: 10, right: 10),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Total Cheque : ",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16),
                                  ),
                                  Flexible(
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Container(
                                        height: main_height * 0.045,
                                        width: main_width * 0.12,
                                        decoration: BoxDecoration(
                                            color: Colors.blue[50],
                                            borderRadius:
                                            BorderRadius.circular(7)),
                                        child: Column(
                                          // mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              width: 8,
                                            ),
                                            Text(
                                              "${rowdata1.length}",
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontSize: 22,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            height: main_height * 0.095,
                            width: main_width * 0.22,
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      blurRadius: 0.000001, color: Colors.grey),
                                ],
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.white),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 5, right: 5, bottom: 5, top: 3),
                              child: Column(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 7),
                                    child: Row(
                                      children: [
                                        Text(
                                          "Purchase Date : ",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: main_height * 0.045,
                                    width: main_width * 0.20,
                                    decoration: BoxDecoration(
                                        color: Colors.blue[50],
                                        borderRadius: BorderRadius.circular(7)),
                                    child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "${sDate.toString() != null ? sDate.toString().substring(0, 10) : sDate.toString()}",
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            height: main_height * 0.095,
                            width: main_width * 0.22,
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      blurRadius: 0.000001, color: Colors.grey),
                                ],
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.white),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 5, right: 5, bottom: 5, top: 3),
                              child: Column(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 7),
                                    child: Row(
                                      children: [
                                        Text(
                                          "Today Date : ",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: main_height * 0.045,
                                    width: main_width * 0.20,
                                    decoration: BoxDecoration(
                                        color: Colors.blue[50],
                                        borderRadius: BorderRadius.circular(7)),
                                    child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "${cDate.toString() != null ? cDate.toString().substring(0, 10) : cDate.toString()}",
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            height: main_height * 0.095,
                            width: main_width * 0.22,
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      blurRadius: 0.000001, color: Colors.grey),
                                ],
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.white),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 5, right: 5, bottom: 5, top: 3),
                              child: Column(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 7),
                                    child: Row(
                                      children: [
                                        Text(
                                          "Expire Date : ",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: main_height * 0.045,
                                    width: main_width * 0.20,
                                    decoration: BoxDecoration(
                                        color: Colors.blue[50],
                                        borderRadius: BorderRadius.circular(7)),
                                    child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "${eDate.toString() != null ? eDate.toString().substring(0, 10) : eDate.toString()}",
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(width: 2.5, color: Color(0xFF43A047)),
                      borderRadius: BorderRadius.circular(5)),
                  height: main_height * 0.08,
                  width: main_width * 0.19,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white, // Background color
                    ),
                    onPressed: () {
                      _pickFile();
                    },
                    child: Text(
                      "Browse Excel",
                      maxLines: 1,
                      softWrap: false,
                      overflow: TextOverflow.fade,
                      style: TextStyle(
                        fontSize: 20,
                        color: Color(0xFF43A047),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: main_height * 0.08,
                  width: main_width * 0.19,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      width: 2.5,
                      color: Color(0xFFE53935),
                    ),
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white, // Background color
                    ),
                    onPressed: () {
                      bulkPrintPressed = true;
                      _createPdf();
                    },
                    child: Text(
                      "Bulk Print",
                      maxLines: 1,
                      overflow: TextOverflow.fade,
                      softWrap: false,
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.red[600],
                      ),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(width: 2.5, color: Colors.black87)),
                  height: main_height * 0.08,
                  width: main_width * 0.19,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white, // Background color
                    ),
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => LogPrint()));
                    },
                    child: Text(
                      "Print Cheque Log",
                      maxLines: 1,
                      overflow: TextOverflow.fade,
                      softWrap: false,
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(width: 2.5, color: Color(0xFF8E24AA))),
                  height: main_height * 0.08,
                  width: main_width * 0.19,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white, // Background color
                    ),
                    onPressed: createExcel,
                    child: Text(
                      "Get Sample Excel",
                      maxLines: 1,
                      softWrap: false,
                      overflow: TextOverflow.fade,
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.purple[600],
                      ),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(width: 2.5, color: Color(0xFF1E88E5))),
                  height: main_height * 0.08,
                  width: main_width * 0.19,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white, // Background color
                    ),
                    onPressed: () {
                      {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Row(
                                  children: [
                                    Text("Do you want to Logout?"),
                                  ],
                                ),
                                content: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
                                  children: [
                                    SizedBox(
                                      width: 40,
                                    ),
                                    ElevatedButton(
                                        onPressed: () async {
                                          // SharedPreferences pref = await SharedPreferences.getInstance();
                                          // pref.clear();
                                          Navigator.of(context)
                                              .pushAndRemoveUntil(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      LoginPage()),
                                                  (route) => false);
                                        },
                                        child: Text("Yes")),
                                    ElevatedButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text("No")),
                                  ],
                                ),
                                shadowColor: Colors.grey,
                              );
                            });
                      }
                    },
                    child: Text(
                      "Log Out",
                      maxLines: 1,
                      softWrap: false,
                      overflow: TextOverflow.fade,
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.blue[600],
                      ),
                    ),
                  ),
                ),

                // SizedBox(
                //   width: 10,
                // ),
                // Container(
                //   height: main_height * 0.08,
                //   width: main_width * 0.15,
                //   child: ElevatedButton(
                //     onPressed: _exportDataGridToExcel,
                //     child: Text(
                //       "Export Excel",
                //       maxLines: 1,
                //       overflow: TextOverflow.fade,
                //       softWrap: false,
                //       style: TextStyle(
                //         fontSize: 25,
                //         color: Colors.white,
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
          Container(
            height: main_height * 0.06,
            width: main_height * 10,
            decoration: BoxDecoration(color: Color(0xFF3182B1)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    launch("https://feeltechsolutions.com/");
                  },
                  child: Text(
                    "  www.feeltechsolutions.com ",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
                Text(
                  "  © FeelTech Solutions Pvt. Ltd.  |  +91 9687112390  |  connect@feeltechsolutions.com    ",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class TableDataSource extends DataGridSource {
  final BuildContext _context;
  final DashboardBloc DBbloc2;
  final Repository repositoryRepo;
  List<List<dynamic>> rowdata1;
  TableDataSource(
      this._context, this.DBbloc2, this.repositoryRepo, this.rowdata1,
      {required x1}) {
    // print("data here main: $x1");
    // print("data print : ${x1}");
    // print(" row of : ${dataGridRows.elementAt(0)}");
    dataGridRows = x1
        .map<DataGridRow>((dataGridRow) => DataGridRow(cells: [
      DataGridCell<String>(
          columnName: 'SR-NO', value: dataGridRow[0].toString()),
      DataGridCell<String>(
          columnName: 'CHEQUE-DATE', value: dataGridRow[1].toString()),
      DataGridCell<String>(
          columnName: 'CHEQUE-NO', value: dataGridRow[2].toString()),
      DataGridCell<String>(
          columnName: 'Amount', value: dataGridRow[3].toString()),
      DataGridCell<String>(
          columnName: 'PAYEE-NAME', value: dataGridRow[4].toString()),
      DataGridCell<String>(
          columnName: 'AccountPay', value: dataGridRow[5].toString()),
      DataGridCell<String>(columnName: 'Action', value: null),
    ]))
        .toList();
  }

  List<DataGridRow> dataGridRows = [];

  @override
  List<DataGridRow> get rows => dataGridRows;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((dataGridCell) {
          String data = dataGridCell.value.toString();
          // print("data here : ${dataGridCell.value}");
          // print("data here : ${row.getCells()[0].value}");
          // print(" data of $ab");

          final a1 = row.getCells()[0].value.toString();
          final a2 = row.getCells()[1].value.toString();
          final a3 = row.getCells()[2].value.toString();
          final a4 = row.getCells()[3].value.toString();
          final a5 = row.getCells()[4].value.toString();
          final a6 = row.getCells()[5].value.toString();

          // var indiaFormat = NumberFormat.compactCurrency(locale: 'hi-IN');
          // print("pesa : ${indiaFormat.format(1000000)}");//10L

          // print("${NumberToWord().convert('en-in',int.parse(row.getCells()[3].value.toString()))} only");

          return Container(
              alignment: Alignment.center,
              child: dataGridCell.columnName == "AccountPay"
                  ? SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        dataGridCell.value.toString(),
                        softWrap: false,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ))
                  : dataGridCell.columnName == "CHEQUE-DATE"
                  ? Text(
                dataGridCell.value.toString().substring(0, 10),
                // dataGridCell.value.toString(),
                overflow: TextOverflow.ellipsis,
              )
                  : dataGridCell.columnName == "Amount"
                  ? Padding(
                padding: const EdgeInsets.all(3.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      dataGridCell.value.toString(),
                      textAlign: TextAlign.right,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              )
                  : dataGridCell.columnName == "Action"
                  ? SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      tooltip: "Print",
                      iconSize: 26,
                      color: Colors.orange[300],
                      icon: const Icon(Icons.print_outlined),
                      onPressed: () {
                        _createPrint(row);
                        // rows.remove(row);
                      },
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    IconButton(
                      tooltip: "Preview",
                      iconSize: 26,
                      color: Colors.blue[300],
                      icon: const Icon(
                          Icons.remove_red_eye_outlined),
                      onPressed: () {
                        _displayPdf(row);
                      },
                    ),
                  ],
                ),
              )
                  : Padding(
                padding: const EdgeInsets.all(3.0),
                child: Text(
                  dataGridCell.value.toString(),
                  overflow: TextOverflow.ellipsis,
                ),
              ));
        }).toList());
  }

  void _displayPdf(DataGridRow row) async {
    final doc = pw.Document();
    final img = await imageFromAssetBundle("assets/images/c5.jpg");
    final img2 = await imageFromAssetBundle("assets/images/wp.jpg");
    final img1 = await imageFromAssetBundle("assets/images/mm.png");
    final img3 = await imageFromAssetBundle("assets/images/abcd.png");
    final img4 = await imageFromAssetBundle("assets/images/xyz1.jpg");
    final img5 = await imageFromAssetBundle("assets/images/cheq.jpg");
    // final a = await getFontFamily(FontFamily.Cutive);
    // var font = await getFontFamily();

    doc.addPage(
      pw.Page(
        pageFormat:
        PdfPageFormat(19 * PdfPageFormat.cm, 8.61 * PdfPageFormat.cm)
            .copyWith(
            marginTop: 0.0 * PdfPageFormat.cm,
            marginLeft: 0.0 * PdfPageFormat.cm),
        build: (pw.Context context) {
          return pw.Container(
              child: pw.Stack(
                  fit: pw.StackFit.passthrough,
                  overflow: pw.Overflow.visible,
                  children: [
                    pw.Container(
                      // height: 250,
                      // width: 500,
                      child: pw.Center(
                        child: pw.Image(img5),
                      ),
                    ),
                    pw.Positioned(
                        top: 22,
                        left: 407,
                        child: pw.Text(
                            "${row.getCells()[1].value.toString().replaceAll("-", "")}",
                            style: pw.TextStyle(
                              letterSpacing: 7,
                              fontSize: 11,
                              color: PdfColors.black,
                            ))),
                    pw.Positioned(
                      top: 0,
                      left: 0,
                      child: pw.SizedBox(
                          height: 50,
                          width: 50,
                          child: row.getCells()[5].value.toString() == "Yes" ||
                              row.getCells()[5].value.toString() == "yes"
                              ? pw.Image(img1)
                              : pw.Text("")),
                    ),
                    pw.Positioned(
                        top: 53.5,
                        left: 42,
                        child: pw.Text("***${row.getCells()[4].value.toString()}***",
                            style: pw.TextStyle(
                              font: pw.Font.times(),
                              fontWeight: pw.FontWeight.bold,
                              fontSize: 10,
                              color: PdfColors.black,
                            ))),
                    pw.Positioned(
                        top: 77,
                        left: 70,
                        child: pw.Container(
                          height: 50,
                          width: 430,
                          child: pw.Text(
                            "***${NumberToWord().convert('en-in', int.parse(row.getCells()[3].value.toString()))} only***"
                                .toUpperCase(),
                            maxLines: 2,
                            style: pw.TextStyle(
                              fontSize: 10,
                              font: pw.Font.times(),
                              fontWeight: pw.FontWeight.bold,
                              lineSpacing: 10,
                              // letterSpacing: 1,
                              color: PdfColors.black,
                            ),
                          ),
                        )),
                    pw.Positioned(
                        top: 98,
                        left: 402,
                        child: pw.Text(
                            "*** ${NumberFormat.simpleCurrency(locale: 'hi-In', decimalDigits: 2).format(int.parse(row.getCells()[3].value.toString()))}"
                                .replaceAll("₹", ""),
                            style: pw.TextStyle(
                              // letterSpacing: 1,
                              fontSize: 10,
                              color: PdfColors.black,
                            ))),
                  ]));
        },
      ),
    );

    /// open Preview Screen
    Navigator.push(
        _context,
        MaterialPageRoute(
          builder: (context) => PreviewScreen(doc: doc),
        ));
  }

  /// create PDF & print it
  void _createPrint(DataGridRow row) async {
    final doc = pw.Document();

    /// for using an image from assets
    // final image = await imageFromAssetBundle('assets/image.png');
    final img = await imageFromAssetBundle("assets/images/c5.jpg");
    final img2 = await imageFromAssetBundle("assets/images/wp.jpg");
    final img1 = await imageFromAssetBundle("assets/images/mm.png");
    final img3 = await imageFromAssetBundle("assets/images/abcd.png");

    doc.addPage(
      pw.Page(
        margin: pw.EdgeInsets.all(0.0),
        // clip: true,
        // pageFormat: PdfPageFormat(22 * PdfPageFormat.cm, 8 * PdfPageFormat.cm),
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.center,
            children: [
              pw.Transform.rotateBox(angle: 90 / 180 * pi,
                  child: pw.Container(
                      height: 9 * PdfPageFormat.cm,
                      width: 22 * PdfPageFormat.cm,
                      // color: PdfColors.blue,
                      child: pw.Stack(
                          children: [
                            //
                            // pw.Container(
                            //   child: pw.Center(
                            //     child: pw.Image(img3),
                            //   ),
                            // ),
                            pw.Positioned(
                                top: 17.5,
                                left: 488,
                                child: pw.Text(
                                    "${row.getCells()[1].value.toString().replaceAll("-", "")}",
                                    style: pw.TextStyle(
                                      letterSpacing: 8.5,
                                      fontSize: 11,
                                      color: PdfColors.black,
                                    ))),

                            pw.Positioned(
                                top: 0,
                                left: 53,
                                child: pw.SizedBox(
                                    height: 50,
                                    width: 50,
                                    child: row.getCells()[5].value.toString() == "Yes" ||
                                        row.getCells()[5].value.toString() == "yes"
                                        ? pw.Image(img1)
                                        : pw.Text(""))),

                            pw.Positioned(
                                top: 51.5,
                                left: 115,
                                child: pw.Text("***${row.getCells()[4].value.toString()}***",
                                    style: pw.TextStyle(
                                      font: pw.Font.times(),
                                      fontSize: 12,
                                      fontWeight: pw.FontWeight.bold,
                                      color: PdfColors.black,
                                    ))),

                            pw.Positioned(
                                top: 77.5,
                                left: 138,
                                child: pw.Container(
                                  height: 50,
                                  width: 430,
                                  child: pw.Text(
                                    "***${NumberToWord().convert('en-in', int.parse(row.getCells()[3].value.toString()))} only***"
                                        .toUpperCase(),
                                    maxLines: 2,
                                    style: pw.TextStyle(
                                      font: pw.Font.times(),
                                      fontWeight: pw.FontWeight.bold,
                                      fontSize: 12,
                                      lineSpacing: 9,
                                      // letterSpacing: 1,
                                      color: PdfColors.black,
                                    ),
                                  ),
                                )),

                            pw.Positioned(
                                top: 97,
                                left: 495,
                                child: pw.Text(
                                    "*** ${NumberFormat.simpleCurrency(locale: 'hi-In', decimalDigits: 2).format(int.parse(row.getCells()[3].value.toString()))}"
                                        .replaceAll("₹", ""),
                                    style: pw.TextStyle(
                                      // letterSpacing: 1,
                                      fontSize: 10,
                                      color: PdfColors.black,
                                    ))),
                          ])))
            ]
          );
        },
      ),
    );

    final ab = await Printing.layoutPdf(
      // usePrinterSettings: true,
      // dynamicLayout: true,
      // format: PdfPageFormat(22 * PdfPageFormat.cm, 8 * PdfPageFormat.cm,
      // marginTop: 0),
      // format:  PdfPageFormat(22 * PdfPageFormat.cm, 8 * PdfPageFormat.cm),
        onLayout: (PdfPageFormat format) async => doc.save());

    if (ab == true) {
      // final snackBar = SnackBar(
      //   duration: Duration(seconds: 2),
      //   content: const Text("Print Successfully!"),
      //   backgroundColor: Color(0xFF076799),
      //   action: SnackBarAction(
      //     label: 'dismiss',
      //     onPressed: () {},
      //   ),
      // );
      // ScaffoldMessenger.of(context).showSnackBar(snackBar);

      final main_width = MediaQuery.of(_context).size.width;
      TextSpan contentMes = TextSpan(
          text: "Data has moved to Print Log!",style: TextStyle(color: Colors.grey, fontSize: 15));
      ThemeHelper.customDialogForMessage(
          isBarrierDismissible: false,
          _context,
          "Print Successful!",
          main_width * 0.25,
          contentMessage: contentMes,
              () {
            // Navigator.of(context).pop('refresh');
            Navigator.of(_context).pop();
            // Navigator.of(context).pop('refresh');
          }, ForSuccess: true);

      bool? tempBool;
      if (row.getCells()[5].value.toString() == "Yes" ||
          row.getCells()[5].value.toString() == "yes") {
        tempBool = true;
      } else {
        tempBool = false;
      }

      // post_excel_model excelData = await repositoryRepo.logPostAPI('chequeprintlog',[
      //   {
      //     "chequeNo":row.getCells()[2].value.toString(),
      //     "chequeDate":row.getCells()[1].value.toString(),
      //     "isAccountPay":tempBool,
      //     "chequeAmount":row.getCells()[3].value.toString(),
      //     "chequePayname":row.getCells()[4].value.toString()}
      // ]
      // );
      DBbloc2.add(PostExcelDataEvent(
          row.getCells()[2].value.toString(),
          row.getCells()[1].value.toString(),
          tempBool,
          row.getCells()[3].value.toString(),
          row.getCells()[4].value.toString()));

      print("dcks : ${dataGridRows.indexOf(row) + 1}");
      print("dcks : ${rows}");
      row.getCells().remove(rows);
      rows.remove(row);

      print("a nsdkll : ${dataGridRows.indexOf(row)}");

      rowdata1.removeAt(dataGridRows.indexOf(row) + 1);
      print("object ki : ${row}");
    } else {}
  }
}
