import 'dart:io';
import 'package:escapingplan/widget/CustomExpection.dart';
import 'package:escapingplan/widget/const.dart';
import 'package:escapingplan/widget/response.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class authprovider with ChangeNotifier {
  Map<String, String> headers = {
    'Authorization': 'hXuRUGsEGuhGf6KG',
  };
  Future<http.Response> loginapi(Map<String, String> bodyData) async {
    print(bodyData);
    const url = 'http://portal.escapingplan.com/admin/api/?action=login';
    var responseJson;
    final response = await http
        .post(Uri.parse(url), body: bodyData, headers: headers)
        .timeout(
      const Duration(seconds: 60),
      onTimeout: () {
        throw const SocketException('Something went wrong');
      },
    );
    print(response.headers);
    print(response.body);
    responseJson = responses(response);
    return responseJson;
  }

  Future<http.Response> profileapi(Map<String, String> bodyData) async {
    const url = '$baseUrl/?action=change_profile';
    var responseJson;
    try {
      final imageUploadRequest = http.MultipartRequest('POST', Uri.parse(url));
      imageUploadRequest.headers.addAll(headers);
      if (bodyData['profile_image']?.isNotEmpty ?? false) {
        final file = await http.MultipartFile.fromPath(
            'profile_image', bodyData['profile_image'] ?? '');
        imageUploadRequest.files.add(file);
      }
      imageUploadRequest.fields.addAll(bodyData);
      final streamResponse = await imageUploadRequest.send();
      responseJson = responses(await http.Response.fromStream(streamResponse));
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<http.Response> forgetapi(Map<String, String> bodyData) async {
    const url = '$baseUrl/?action=forget_password';
    var responseJson;
    final response = await http
        .post(Uri.parse(url), body: bodyData, headers: headers)
        .timeout(
      const Duration(seconds: 30),
      onTimeout: () {
        throw const SocketException('Something went wrong');
      },
    );
    responseJson = responses(response);
    return responseJson;
  }

  Future<http.Response> viewapi(Map<String, String> bodyData) async {
    const url = '$baseUrl/?action=view_profile';
    var responseJson;
    final response = await http
        .post(Uri.parse(url), body: bodyData, headers: headers)
        .timeout(
      const Duration(seconds: 30),
      onTimeout: () {
        throw const SocketException('Something went wrong');
      },
    );
    responseJson = responses(response);
    return responseJson;
  }

  Future<http.Response> partnerapi(Map<String, String> bodyData) async {
    const url = '$baseUrl/?action=display_partners';
    var responseJson;
    final response = await http
        .post(Uri.parse(url), body: bodyData, headers: headers)
        .timeout(
      const Duration(seconds: 30),
      onTimeout: () {
        throw const SocketException('Something went wrong');
      },
    );
    responseJson = responses(response);
    return responseJson;
  }

  Future<http.Response> agentapi(Map<String, String> bodyData) async {
    const url = '$baseUrl/?action=my_agent';
    var responseJson;
    final response = await http
        .post(Uri.parse(url), body: bodyData, headers: headers)
        .timeout(
      const Duration(seconds: 30),
      onTimeout: () {
        throw const SocketException('Something went wrong');
      },
    );
    responseJson = responses(response);
    return responseJson;
  }
  Future<http.Response> extrapartnerapi(Map<String, String> bodyData) async {
    const url = '$baseUrl/?action=extra_traveller';
    var responseJson;
    final response = await http
        .post(Uri.parse(url), body: bodyData, headers: headers)
        .timeout(
      const Duration(seconds: 30),
      onTimeout: () {
        throw const SocketException('Something went wrong');
      },
    );
    responseJson = responses(response);
    return responseJson;
  }
  Future<http.Response> invoiceapi(Map<String, String> bodyData) async {
    const url = '$baseUrl/?action=invoice_history';
    var responseJson;
    final response = await http
        .post(Uri.parse(url), body: bodyData, headers: headers)
        .timeout(
      const Duration(seconds: 30),
      onTimeout: () {
        throw const SocketException('Something went wrong');
      },
    );
    responseJson = responses(response);
    return responseJson;
  }
  Future<http.Response> logoutap(Map<String, String> bodyData) async {
    const url = '$baseUrl/?action=log_out';
    var responseJson;
    final response = await http
        .post(Uri.parse(url), body: bodyData, headers: headers)
        .timeout(
      const Duration(seconds: 30),
      onTimeout: () {
        throw const SocketException('Something went wrong');
      },
    );
    responseJson = responses(response);
    return responseJson;
  }
  Future<http.Response> notiberap(Map<String, String> bodyData) async {
    const url = '$baseUrl/?action=checkNewMsg';
    var responseJson;
    final response = await http
        .post(Uri.parse(url), body: bodyData, headers: headers)
        .timeout(
      const Duration(seconds: 30),
      onTimeout: () {
        throw const SocketException('Something went wrong');
      },
    );
    responseJson = responses(response);
    return responseJson;
  }
}
