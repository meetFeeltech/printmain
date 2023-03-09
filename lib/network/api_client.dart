import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../api/api.dart';
import 'cutom_exception.dart';


class ApiClient {
  http.Client? httpClient;

  ApiClient({this.httpClient});

  // GETAPICALL
  Future<dynamic> apiCallGet(String baseUrl, String apiEndPoint, {String query = ""}) async {
    var getResponseJson;
    var getUrl;

    if(query.isNotEmpty){
      getUrl = '$baseUrl$apiEndPoint?$query';
    } else {
      getUrl = '$baseUrl$apiEndPoint';
    }


    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $accessToken"
    };

    print("url: $getUrl, headers: $headers");


    try {
      var response = await httpClient?.get(Uri.parse(getUrl), headers: headers);
      getResponseJson = await _parseGetResponse(response!);
    } on SocketException {
      throw FetchDataException("No internet connection");
    }
    return getResponseJson;
  }

  Future<dynamic> _parseGetResponse(http.Response response) async {
    debugPrint("Get Api Response: ${response.body}");
    print("status: ${response.statusCode}");

    switch (response.statusCode) {
      case 200:
        var getResponseJson = json.decode(response.body);
        return getResponseJson;

      case 401:
        throw UnAuthorizedException("Unauthorized access or Invalid credentials");

      case 404:
        throw DoesNotExistException("User Does Not Exist");

      case 400:
        throw ServerValidationError("hi");

      default:
        throw Exception("Something went Wrong");
    }
  }

  // POSTAPICALL

  Future<dynamic> apiCallPost(String baseUrl,String apiEndPoint, dynamic postBody,{bool? isBearer}) async {
    var postResponseJson;
    var getUrl;


    getUrl = '$baseUrl$apiEndPoint';

    Map<String, String> headers;
    print("herrreeeeee1");
    print(postBody);
    // print();

    var encodedBody = json.encode(postBody);

    print("herrreeeeee2");
    if(isBearer == true){
      headers = {
        "Content-Type": "application/json",
        "Authorization": "Bearer $accessToken"
      };
    }else{
      headers = {
        "Content-Type": "application/json",
        // "Authorization": "$accessToken"
      };
    }


    print("url: $getUrl, headers: $headers");
    try{
      var response = await httpClient?.post(Uri.parse(getUrl), headers: headers, body: encodedBody);
      postResponseJson = await _parsePostResponse(response!);
    } on SocketException {
      throw FetchDataException("No internet connection");
    }
    return postResponseJson;
  }

  Future<dynamic> _parsePostResponse(http.Response response) async {
    debugPrint("Post Api Response: ${response.body}");
    print("status: ${response.statusCode}");

    switch (response.statusCode) {
      case 200:
        var postResponseJson = json.decode(response.body);
        return postResponseJson;

      case 401:
        throw UnAuthorizedException("Unauthorized access or Invalid credentials");

      case 404:
        throw DoesNotExistException("User Does Not Exist");

      case 400:
        throw DoesNotExistException("The email address or password you entered is incorrect. Please try again.");

      case 406:
        throw DoesNotExistException("Plan expired!");


      default:
        throw Exception("Something went Wrong");
    }
  }

  // PUTAPICALL

  Future<dynamic> apiCallPut(String baseUrl, String apiEndPoint, dynamic putBody) async {
    var putResponseJson;
    var getUrl;

    getUrl ='$baseUrl$apiEndPoint';

    var encodedBody = json.encode(putBody);

    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization": "$accessToken"
    };

    print("url: $getUrl, headers: $headers");
    try {

      var response = await httpClient!.put(Uri.parse(getUrl), headers: headers, body: encodedBody);
      print("response : ${response.body}");
      putResponseJson = await _parsePutResponse(response);
    } on SocketException {
      throw FetchDataException("No Internet Connection");
    }
    return putResponseJson;
  }

  Future<dynamic> _parsePutResponse(http.Response response) async {
    debugPrint("Put Api Response: ${response.body}");
    print("status: ${response.statusCode}");

    switch (response.statusCode) {
      case 200:
        var putResponseJson = json.decode(response.body);
        return putResponseJson;

      case 401:
        throw UnAuthorizedException("Unauthorized access or Invalid credentials");

      case 404:
        throw DoesNotExistException("User Does Not Exist");

      case 400:
        throw ServerValidationError("hi");

      default:
        throw Exception("Something went Wrong");
    }
  }

}

