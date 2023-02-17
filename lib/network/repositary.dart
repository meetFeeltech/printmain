
import 'dart:convert';

import '../api/api.dart';
import '../model/login_model.dart';
import '../model/user_data_model.dart';
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
      Map<String, dynamic> json = await apiClient.apiCallPost(BASEURL, apiEndPoint, body);
      print("final received json = $json");
      login_model loginResponse = login_model.fromJson(json);
      return loginResponse;
    } on CustomException {
      rethrow;
    }
  }

  // Future<user_data_model> getUser() async {
  //   try {
  //     Map<String,dynamic> json =
  //     await apiClient.apiCallGet(BASEURL,UserDataEndPoint);
  //     print("Final received Json - $json");
  //     user_data_model userListResponse = user_data_model.fromJson(json);
  //     return userListResponse;
  //   }on CustomException{
  //     rethrow;
  //   }
  // }

  // Future<user_data_model> getUser() async {
  //   try {
  //     var listData1 = await apiClient.apiCallGet(BASEURL,UserDataEndPoint);
  //     var userListResponse = listData1.map((json) => user_data_model.fromJson(json));
  //     return userListResponse;
  //   } on CustomException {
  //     rethrow;
  //   }
  // }

  // Future<user_data_model> getUser() async {
  //   try {
  //     var listData1 = await apiClient.apiCallGet(BASEURL,UserDataEndPoint);
  //     var userListResponse = listData1.map((json) => user_data_model.fromJson(json));
  //     // print("json : $json");
  //     print("listdata : $listData1");
  //     return userListResponse;
  //   } on CustomException {
  //     rethrow;
  //   }
  // }


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


}
