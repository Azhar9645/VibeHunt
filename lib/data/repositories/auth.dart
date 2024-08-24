import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:vibehunt/data/models/user_model.dart';
import 'package:vibehunt/utils/api_url.dart';

class AuthenticationRepo {
  static var client = http.Client();
  Future<http.Response?> sentOtp(UserModel user) async {
    if (kDebugMode) {
      print(user.emailId);
    }
    var data = {
      "userName": user.userName,
      "email": user.emailId,
      "password": user.password,
      "phone": user.phoneNumber
    };
    var jsonData = jsonEncode(data);

    try {
      final response = await client.post(
        Uri.parse(ApiEndpoints.baseUrl + ApiEndpoints.signUp),
        body: jsonData,
        headers: {
          "Content-Type": "application/json", // Set the content type to JSON
        },
      );
      return response;
    } catch (e) {
      debugPrint('+++++++++');
      debugPrint(e.toString());
      return null;
    }
  }

  static Future<Response?> verifyOtp(String email, String otp) async {
    var data = {'email': email, 'otp': otp};

    try {
      var response = await client.post(
        Uri.parse(ApiEndpoints.baseUrl + ApiEndpoints.verifyOtp),
        body: jsonEncode(data),
        headers: {
          "Content-Type": "application/json",
        },
      );
      debugPrint(response.body);
      return response;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  static Future<Response?> userLogin(String email, String password) async {
    try {
      var user = {'email': email, 'password': password};
      var response = await client.post(
          Uri.parse(ApiEndpoints.baseUrl + ApiEndpoints.login),
          body: jsonEncode(user),
          headers: {"Content-Type": 'application/json'});
      debugPrint(response.statusCode.toString());
      if (kDebugMode) {
        print(user);
      }
      debugPrint(response.body);
      final responseBody = jsonDecode(response.body);
      if (response.statusCode == 200) {
        debugPrint("Login successful: ${responseBody['user']}");

        return response;
      } else {
        debugPrint("Login failed: ${responseBody['message']}");

        return response;
      }
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  static Future<Response?> googleLogin(String email) async {
    try {
      final finalEmail = {'email': email};
      var response = await client.post(
          Uri.parse(ApiEndpoints.baseUrl + ApiEndpoints.googleLogin),
          body: jsonEncode(finalEmail),
          headers: {"Content-Type": 'application/json'});
      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        // You can handle the response here if needed, but without setting user preferences
      }
      return response;
    } catch (e) {
      return null;
    }
  }

}
