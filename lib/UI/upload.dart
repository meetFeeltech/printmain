import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class Upload extends StatefulWidget {
  const Upload({Key? key}) : super(key: key);

  @override
  State<Upload> createState() => _UploadState();
}

class _UploadState extends State<Upload> {

  List<List<dynamic>> _data = [];
  String? filePath;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("upload"),
      ),
      body: Column(
        children: [
          ElevatedButton(onPressed: () async{


          }, child: Text("Take Sheet")),



        ],
      ),
    );
  }
}

