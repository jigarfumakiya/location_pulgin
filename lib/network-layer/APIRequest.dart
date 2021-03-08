import 'package:flutter/material.dart';

enum RequestMethods { POST }

class APIRequest {
  final String baseUrl;
  final Map<String, dynamic> data;
  final Map<String, dynamic> header;
  final RequestMethods methods;

  APIRequest(
      {@required this.baseUrl,
      @required this.data,
      this.header,
      @required this.methods});

  Map<String, dynamic> toMap() =>
      {"baseUrl": baseUrl, "data": data, "header": header, "methods": 'post'};
}
