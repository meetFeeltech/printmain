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

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late TableDataSource _tableDataSource;

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
        onPressed: () {
        },
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<void> createExcel() async {
    final snackBar = SnackBar(
      duration: Duration(seconds: 1),
      content: const Text("Getting Excel Format!"),
      backgroundColor: Color(0xFF076799),
      action: SnackBarAction(
        label: 'dismiss',
        onPressed: () {
        },
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);

    final Workbook workbook = Workbook();
    final Worksheet sheet = workbook.worksheets[0];
    sheet.getRangeByName('A1').setText('SR NO');
    sheet.getRangeByName('B1').setText('CHEQUEDATE');
    sheet.getRangeByName('C1').setText('CHEQUE NO');
    sheet.getRangeByName('D1').setText('AMOUNT');
    sheet.getRangeByName('E1').setText('PAYEENAME');
    sheet.getRangeByName('F1').setText('AccountPay');
    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();

    if (kIsWeb) {
      AnchorElement(
          href:
          'data:application/octet-stream;charset=utf-16le;base64,${base64.encode(bytes)}')
        ..setAttribute('download', 'Output.xlsx')
        ..click();
    } else {
      final String path = (await getApplicationSupportDirectory()).path;
      final String fileName =
      Platform.isWindows ? '$path\\Output.xlsx' : '$path/Output.xlsx';
      final File file = File(fileName);
      await file.writeAsBytes(bytes, flush: true);
      OpenFile.open(fileName);
    }


  }

  void _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      withData: true,
      allowedExtensions: ['xlsx'],
      type: FileType.custom,
    );

    // print("result $result");

    if (result != null) {
      // List<dynamic> xlsxToList = [];
      // PlatformFile file = result.files.first;
      // print(file.name);
      // print(file.bytes);
      // print(file.size);
      // print(file.extension);
      // print(file.path);
      var bytes = result.files.single.bytes;
      // print("bytes $bytes");
      var excel = Excel.decodeBytes(bytes!);

      final row = excel.tables[excel.tables.keys.first]!.rows
          .map((e) => e.map((e) => e!.value).toList())
          .toList();

      // print("rows : ${row.elementAt(0)}");

      var x1 = row..removeAt(0);
      print("only data : $x1");
      print("only data : ${x1.elementAt(0)}");
      _tableDataSource = TableDataSource(context, x1: x1);
      final snackBar = SnackBar(
        duration: Duration(seconds: 1),
        content: const Text("Excel Imported Successfully!"),
        backgroundColor: Color(0xFF076799),
        action: SnackBarAction(
          label: 'dismiss',
          onPressed: () {
          },
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

      setState(() {});
    } else {
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
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>USER_Data_Here()));
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

                  Expanded(child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SizedBox(
                          width: 200,
                        ),
                        ElevatedButton(
                          onPressed: createExcel,
                          child: Text(
                            "Get Excel",
                            maxLines: 1,
                            softWrap: false,
                            overflow: TextOverflow.fade,
                            style: TextStyle(color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 30,
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
                            style: TextStyle(color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        ElevatedButton(
                          onPressed: _exportDataGridToExcel,
                          child: Text(
                            "Download Excel",
                            maxLines: 1,
                            overflow: TextOverflow.fade,
                            softWrap: false,
                            style: TextStyle(color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),


                ],
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: SfDataGridTheme(
                  data: SfDataGridThemeData(headerColor: Colors.blue[500]),
                  child: SfDataGrid(
                    key: _key,
                    shrinkWrapRows: true,
                    allowFiltering: true,
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

// class HolderModel {
//   final String a1;
//   final String a2;
//   final String a3;
//   final String a4;
//   final String a5;
//   final String a6;
//
//   HolderModel({required this.a1,
//     required this.a2,
//     required this.a3,
//     required this.a4,
//     required this.a5,
//     required this.a6});
// }

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
          child: dataGridCell.columnName == "AccountPay" ?
          SingleChildScrollView(
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

