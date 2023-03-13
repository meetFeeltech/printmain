
import 'dart:convert';

import '../api/api.dart';
import '../model/Excel_data_model.dart';
import '../model/delete_model.dart';
import '../model/login_model.dart';
import '../model/post_excel_model.dart';
import '../model/user_data_model.dart';
import '../model/viewallcategories/ViewAllCategories_model.dart';
import 'api_client.dart';
import 'package:http/http.dart' as http;
import 'cutom_exception.dart';

class Repository {

  final ApiClient apiClient;

  Repository(this.apiClient);

  static Repository getInstance() {
    return Repository(ApiClient(httpClient: http.Client()));
  }


  Future<login_model> loginPostAPI(String apiEndPoint, dynamic body) async {
    try {
      Map<String, dynamic> json = await apiClient.apiCallPost(BASEURL, LoginEndPoint, body);
      print("final received json = $json");
      login_model loginResponse = login_model.fromJson(json);
      return loginResponse;
    } on CustomException {
      rethrow;
    }
  }

  Future<List<user_data_model>> getUser() async {
    try {
      var listData1 = await apiClient.apiCallGet(BASEURL,UserDataEndPoint) as List;
      var userListResponse = listData1.map((json) => user_data_model.fromJson(json)).toList();
      print("listdata : $listData1");
      return userListResponse;
    } on CustomException {
      rethrow;
    }
  }

  Future<List<user_data_model>> getDateUser() async {
    try {
      var listData1 = await apiClient.apiCallGet(BASEURL,UserDataEndPoint) as List;
      var userListResponse = listData1.map((json) => user_data_model.fromJson(json)).toList();
      print("listdata : $listData1");
      return userListResponse;
    } on CustomException {
      rethrow;
    }
  }

  Future<List<ExcelDataModel>> getAllCategoryData({String? oneDate}) async {
    try {
      var listData1 = await apiClient.apiCallGet(BASEURL,LoggetEndPoint) as List;
      var efficiencyTableRes1 = listData1.map((json) => ExcelDataModel.fromJson(json)).toList();
      return efficiencyTableRes1;
    } on CustomException {
      rethrow;
    }
  }

  Future<post_excel_model> logPostAPI(String apiEndPoint, dynamic body) async {
    try {
      print(" body are here: ${body} ");
      Map<String, dynamic> json = await apiClient.apiCallPost(BASEURL, LogEndPoint, body,isBearer:true);
      post_excel_model loginResponse = post_excel_model.fromJson(json);
      return loginResponse;
    } on CustomException {
      rethrow;
    }
  }

  Future<Delete_model>delLogData({required String id}) async {
    try {
      Map<String, dynamic> json = await apiClient.apiCallDel(BASEURL,"$DeleteEndPoint$id",isBearer:true);
      Delete_model changePassModelRes = Delete_model.fromJson(json);
      return changePassModelRes;
    } on CustomException {
      rethrow;
    }
  }



}
