import 'dart:io';


import 'package:escapingplan/widget/CustomExpection.dart';
import 'package:escapingplan/widget/const.dart';
import 'package:escapingplan/widget/response.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class travelprovider with ChangeNotifier{

  Map<String, String> headers = {
    'Authorization': 'hXuRUGsEGuhGf6KG',
  };
  Future<http.Response> detailapi(Map<String,String>bodyData) async {
    const url = '$baseUrl/?action=detail_page';
    var responseJson;

    final response = await http.post(Uri.parse(url), body:bodyData , headers:headers )
        .timeout(
      const Duration(seconds: 30),
      onTimeout: () {
        throw const SocketException('Something went wrong');
      },
    );
    responseJson = responses(response);
    return responseJson;
  }
  Future<http.Response> tripapi(Map<String,String>bodyData) async {
    const url = '$baseUrl/?action=my_trip';
    var responseJson;

    final response = await http.post(Uri.parse(url), body:bodyData , headers:headers )
        .timeout(
      const Duration(seconds: 30),
      onTimeout: () {
        throw const SocketException('Something went wrong');
      },
    );
    responseJson = responses(response);
    return responseJson;
  }
  Future<http.Response> requestapi(Map<String,String>bodyData) async {
    const url = '$baseUrl/?action=request_change';
    var responseJson;

    final response = await http.post(Uri.parse(url), body:bodyData , headers:headers )
        .timeout(
      const Duration(seconds: 30),
      onTimeout: () {
        throw const SocketException('Something went wrong');
      },
    );

    responseJson = responses(response);
    return responseJson;
  }
  Future<http.Response> favouriteapi(Map<String,String>bodyData) async {
    const url = '$baseUrl/?action=favourite_trip';
    var responseJson;

    final response = await http.post(Uri.parse(url), body:bodyData , headers:headers )
        .timeout(
      const Duration(seconds: 30),
      onTimeout: () {
        throw const SocketException('Something went wrong');
      },
    );
    responseJson = responses(response);
    return responseJson;
  }
  Future<http.Response> favouritelist(Map<String,String>bodyData) async {
    const url = '$baseUrl/?action=favourite_list';
    var responseJson;

    final response = await http.post(Uri.parse(url), body:bodyData , headers:headers )
        .timeout(
      const Duration(seconds: 30),
      onTimeout: () {
        throw const SocketException('Something went wrong');
      },
    );
    responseJson = responses(response);
    return responseJson;
  }
  Future<http.Response> requestlist(Map<String,String>bodyData) async {
    const url = '$baseUrl/?action=changes_request_list';
    var responseJson;

    final response = await http.post(Uri.parse(url), body:bodyData , headers:headers )
        .timeout(
      const Duration(seconds: 30),
      onTimeout: () {
        throw const SocketException('Something went wrong');
      },
    );
    responseJson = responses(response);
    return responseJson;
  }
  Future<http.Response> viewlist(Map<String,String>bodyData) async {
    const url = '$baseUrl/?action=view_chat';
    var responseJson;

    final response = await http.post(Uri.parse(url), body:bodyData , headers:headers )
        .timeout(
      const Duration(seconds: 30),
      onTimeout: () {
        throw const SocketException('Something went wrong');
      },
    );
    responseJson = responses(response);
    return responseJson;
  }

  Future<http.Response> addlist(Map<String,String>bodyData) async {
    const url = '$baseUrl/?action=add_chat';
    var responseJson;
    if (bodyData['message_type'] == "text"  || bodyData['message_type'] == "location")
    {
      final response = await http.post(Uri.parse(url), body:bodyData , headers:headers )
          .timeout(
        const Duration(seconds: 30),
        onTimeout: () {
          throw const SocketException('Something went wrong');
        },
      );
      responseJson = responses(response);
      return responseJson;
    }
    else{
      try {
        final imageUploadRequest = http.MultipartRequest('POST', Uri.parse(url));
        imageUploadRequest.headers.addAll(headers);
        if (bodyData['message']?.isNotEmpty ?? false) {
          final file = await http.MultipartFile.fromPath(
              'message', bodyData['message']?? '',
            contentType: bodyData['type'] == "image"
                ? MediaType('image', 'jpg,png')
                : MediaType('video', 'mp4'),
          );
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
  }
  Future<http.Response> weatherapi(Map<String,String>bodyData) async {
    const url = '$baseUrl/?action=weatherforecast';
    var responseJson;

    final response = await http.post(Uri.parse(url), body:bodyData , headers:headers )
        .timeout(
      const Duration(seconds: 30),
      onTimeout: () {
        throw const SocketException('Something went wrong');
      },
    );
    responseJson = responses(response);
    return responseJson;
  }
  Future<http.Response> messagereadapi(Map<String,String>bodyData) async {
    const url = '$baseUrl/?action=messageRead';
    var responseJson;

    final response = await http.post(Uri.parse(url), body:bodyData , headers:headers )
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
