import 'package:cheque_print/UI/USERS/users_data.dart';
import 'package:cheque_print/UI/printHere/printhere.dart';
import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid_export/export.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' hide Column, Row;
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

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late TableDataSource _tableDataSource;

  List<List<dynamic>> bulkprintData = [];

  List<List<dynamic>> rowdata1 = [];

  List<dynamic> _row = [];
  String? filePath;

  @override
  void initState() {
    super.initState();
    // _row = getHolderData();
    _tableDataSource = TableDataSource(context, x1: []);
  }

  final GlobalKey<SfDataGridState> _key = GlobalKey<SfDataGridState>();

  Future<void> _exportDataGridToExcel() async {
    // print("key : ${_key.currentState}");
    final Workbook workbook = _key.currentState!.exportToExcelWorkbook();
    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();
    await helper.saveAndLaunchFile(bytes, 'DataGrid.xlsx');
    final snackBar = SnackBar(
      duration: Duration(seconds: 2),
      content: const Text("Download Excel!"),
      backgroundColor: Color(0xFF076799),
      action: SnackBarAction(
        label: 'dismiss',
        onPressed: () {},
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<void> createExcel1() async {
    final snackBar = SnackBar(
      duration: Duration(seconds: 2),
      content: const Text("Getting Excel Format!"),
      backgroundColor: Color(0xFF076799),
      action: SnackBarAction(
        label: 'dismiss',
        onPressed: () {},
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);

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

        final snackBar = SnackBar(
          duration: Duration(seconds: 2),
          content: const Text("Excel Imported Successfully!"),
          backgroundColor: Color(0xFF076799),
          action: SnackBarAction(
            label: 'dismiss',
            onPressed: () {},
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } catch (e) {
        final snackBar = SnackBar(
          duration: Duration(seconds: 2),
          content: const Text("Excel is not in Format!"),
          backgroundColor: Color(0xFF076799),
          action: SnackBarAction(
            label: 'dismiss',
            onPressed: () {},
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }

      // final row = excel.tables[excel.tables.keys.first]!.rows
      // .map((e) => e.map((e) => e!.value).toList())
      // .toList();
      // print("rows : ${row.elementAt(0)}");

      print("only data : $rowdata1");
      print("only data : ${rowdata1.elementAt(0)}");
      _tableDataSource = TableDataSource(context, x1: rowdata1);

      print("all data $rowdata1");
      print("one data ${rowdata1.elementAt(1)}");
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
            // clip: true,
            pageFormat: PdfPageFormat(
              22 * PdfPageFormat.cm,
              8 * PdfPageFormat.cm,
            ),
            build: (pw.Context context) => <pw.Widget>[
                  pw.Wrap(children: [
                    pw.Container(
                        height: 8 * PdfPageFormat.cm,
                        child: pw.Stack(children: [
                          pw.Positioned(
                              top: 21,
                              left: 445,
                              child: pw.Text(
                                  "${bulkprintData[i].elementAt(1).toString().replaceAll("-", "")}",
                                  style: pw.TextStyle(
                                    letterSpacing: 8,
                                    fontSize: 11,
                                    color: PdfColors.black,
                                  ))),
                          pw.Positioned(
                              top: 0,
                              left: 12,
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
                              top: 55,
                              left: 62,
                              child: pw.Text("${bulkprintData[i].elementAt(4)}",
                                  style: pw.TextStyle(
                                    font: pw.Font.times(),
                                    fontSize: 12,
                                    color: PdfColors.black,
                                  ))),
                          pw.Positioned(
                              top: 80,
                              left: 78,
                              child: pw.Container(
                                height: 50,
                                width: 500,
                                child: pw.Text(
                                  "${NumberToWordsEnglish.convert(int.parse(bulkprintData[i].elementAt(3).toString()))} only"
                                      .capitalize(),
                                  maxLines: 2,
                                  style: pw.TextStyle(
                                    fontSize: 12,
                                    font: pw.Font.times(),
                                    lineSpacing: 7,
                                    letterSpacing: 1,
                                    color: PdfColors.black,
                                  ),
                                ),
                              )),
                          pw.Positioned(
                              top: 105,
                              left: 443,
                              child: pw.Text(
                                  "*** ${NumberFormat.simpleCurrency(locale: 'hi-In', decimalDigits: 2).format(int.parse(bulkprintData[i].elementAt(3).toString()))}/-"
                                      .replaceAll("₹", ""),
                                  style: pw.TextStyle(
                                    // letterSpacing: 1,
                                    fontSize: 10,
                                    color: PdfColors.black,
                                  ))),
                        ]))
                  ])
                ]),
      );
    }

      final ab = await Printing.layoutPdf(
        // format:  PdfPageFormat(22 * PdfPageFormat.cm, 8 * PdfPageFormat.cm),
          onLayout: (PdfPageFormat format) async => doc.save());

    print("nlkscnda ${ab}");
    print("nlkscnda ${ab.runtimeType}");

    if(ab == true){
      print("abc");

      final snackBar = SnackBar(
        duration: Duration(seconds: 2),
        content: const Text("Bulk Print!"),
        backgroundColor: Color(0xFF076799),
        action: SnackBarAction(
          label: 'dismiss',
          onPressed: () {},
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

    } else{
      print("xyz");
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF076799),
        title: Text("CHEQUE PRINT"),
      ),
      endDrawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
                accountName: Text("cheque Holder"),
                accountEmail: Text("abc@gmail.com")),
            ListTile(
              title: Text("User's Data"),
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => USER_Data_Here()));
              },
            ),
            Divider(
              color: Colors.black,
              thickness: 2,
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
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
                  ),
                  Flexible(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(
                            onPressed: createExcel,
                            child: Text(
                              "Get Excel",
                              maxLines: 1,
                              softWrap: false,
                              overflow: TextOverflow.fade,
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 50,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              _pickFile();
                            },
                            child: Text(
                              "Import Excel",
                              maxLines: 1,
                              softWrap: false,
                              overflow: TextOverflow.fade,
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 50,
                          ),
                          ElevatedButton(
                            onPressed: _exportDataGridToExcel,
                            child: Text(
                              "Download Excel",
                              maxLines: 1,
                              overflow: TextOverflow.fade,
                              softWrap: false,
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 50,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              _createPdf();
                            },
                            child: Text(
                              "Bulk Print",
                              maxLines: 1,
                              overflow: TextOverflow.fade,
                              softWrap: false,
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: SfDataGridTheme(
                  data: SfDataGridThemeData(headerColor: Colors.blue[500]),
                  child: SfDataGrid(
                    key: _key,
                    shrinkWrapRows: true,
                    allowFiltering: false,
                    allowSorting: true,
                    gridLinesVisibility: GridLinesVisibility.both,
                    headerGridLinesVisibility: GridLinesVisibility.both,
                    columnWidthMode: ColumnWidthMode.fitByCellValue,
                    rowHeight: 50,
                    headerRowHeight: 40,
                    footerHeight: 30,
                    isScrollbarAlwaysShown: true,
                    source: _tableDataSource,
                    columns: [
                      GridDataCommonFunc.tableColumnsDataLayout(
                          columnName: 'SR-NO',
                          toolTipMessage: 'SR-NO',
                          columnTitle: 'SR-NO',
                          columnWidthModeData: ColumnWidthMode.fill),
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
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class TableDataSource extends DataGridSource {
  final BuildContext _context;
  TableDataSource(this._context, {required x1}) {
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
      final a2 = row.getCells()[1].value.toString().substring(0, 10);
      final a3 = row.getCells()[2].value.toString();
      final a4 = row.getCells()[3].value.toString();
      final a5 = row.getCells()[4].value.toString();
      final a6 = row.getCells()[5].value.toString();

      return Container(
          alignment: Alignment.center,
          child: dataGridCell.columnName == "AccountPay"
              ? SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          dataGridCell.value.toString(),
                          softWrap: false,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),

                        SizedBox(
                          width: 15,
                        ),

                        ElevatedButton(
                            onPressed: () {
                              Navigator.of(_context).push(MaterialPageRoute(
                                  builder: (context) => PrintHere(
                                        a1: a1,
                                        a2: a2,
                                        a3: a3,
                                        a4: a4,
                                        a5: a5,
                                        a6: a6,
                                      )));
                            },
                            child: Text("Print")),

                        // Expanded(
                        //   child:SingleChildScrollView(
                        //     scrollDirection: Axis.horizontal,
                        //     child:  ElevatedButton(
                        //         onPressed: () {
                        //           Navigator.of(_context).push(MaterialPageRoute(
                        //               builder: (context) => PrintHere(
                        //                 a1: a1,
                        //                 a2: a2,
                        //                 a3: a3,
                        //                 a4: a4,
                        //                 a5: a5,
                        //                 a6: a6,
                        //               )));
                        //         },
                        //         child: Text("Print")),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                )
              : dataGridCell.columnName == "CHEQUE-DATE"
                  ? Text(
                      dataGridCell.value.toString().substring(0, 10),
                      // dataGridCell.value.toString(),
                      overflow: TextOverflow.ellipsis,
                    )
                  : Text(
                      dataGridCell.value.toString(),
                      overflow: TextOverflow.ellipsis,
                    ));
    }).toList());
  }
}
