import 'dart:io';

import 'package:http/http.dart';
import 'dart:convert';

Map<String, String> userHeader = {
  // HttpHeaders.contentTypeHeader: 'application/x-www-form-urlencoded',
  HttpHeaders.acceptHeader: '*/*',
  // "Access-Control-Allow-Origin": "*",
  // HttpHeaders.connectionHeader: 'keep-alive',
  // HttpHeaders.userAgentHeader: 'Flutter 2.1',
  // HttpHeaders.acceptEncodingHeader: 'gzip, deflate, br',
};

class HttpReq {
  String data = "";
  Future<void> getRedditData() async {
    try {
      // make the request
      print("Reddit");
      Response response = await get(
        "https://www.reddit.com/r/news/hot/.json",
        headers: userHeader,
      );
      if (response.statusCode != 200) {
        throw Exception(
            "Request failed with status ${response.statusCode}: ${response.body}");
      }
      print(response);
      data = response.body;
      print(data);
    } catch (e) {
      print(e);
      data = "";
    }
  }

  Future<void> applyApplicant(email) async {
    Map req = {"jobId": "5ec3b7688170e923c95ddc8a", "email": email};
    String reqStr = jsonEncode(req);
    try {
      // make the request
      String u = Uri.encodeFull(
          "https://applicantzstage.com/applicantz/apply?jobId=5ec3b7688170e923c95ddc8a&action=addEditApplicantConfirmation&applicantJson=$reqStr");
      print(u);
      Response response = await get(
        "/tutoring/userProfile?action=getUserProfile",
        headers: userHeader,
      );
      if (response.statusCode != 200) {
        throw Exception(
            "Request failed with status ${response.statusCode}: ${response.body}");
      }
      print(response);
      data = response.body;
      print(data);
    } catch (e) {
      print(e);
      data = "";
    }
  }

  Future<void> postData() async {
    try {
      // make the request
      Response response = await post(
          "https://reqres.in/api/users?name=Ram&job=CEO",
          headers: userHeader);
      if (response.statusCode != 201) {
        throw Exception(
            "Request failed with status ${response.statusCode}: ${response.body}");
      }
      print(response);
      data = response.body;
      print(data);
    } catch (e) {
      print(e);
      data = "";
    }
  }

  Future<void> newsData() async {
    try {
      // make the request
      Response response = await get(
          "http://newsapi.org/v2/top-headlines?apiKey=e603267fd53c406cb4d230e6deac25d1&country=in",
          headers: userHeader);
      if (response.statusCode != 200) {
        throw Exception(
            "Request failed with status ${response.statusCode}: ${response.body}");
      }
      print(response);
      data = response.body;
      print(data);
    } catch (e) {
      print(e);
      data = "";
    }
  }
}
