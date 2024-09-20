import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:vibehunt/data/repositories/post_repo.dart';
import 'package:vibehunt/utils/api_url.dart';
import 'package:vibehunt/utils/funtions.dart';

class UserRepo {
  static var client = http.Client();

  //Fetch loggedIn user details
  static Future<Response?> fetchLoggedInUserDetails() async {
    try {
      final token = await getUsertoken();
      var response = await client.get(
          Uri.parse('${ApiEndpoints.baseUrl}${ApiEndpoints.logginedUser}'),
          headers: {'Authorization': 'Bearer $token'});
      return response;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  //Fetch loggedIn user posts
  static Future fetchUserPosts({String? userId}) async {
    try {
      final loggineduserId = await getUserId();
      if (kDebugMode) {
        print(loggineduserId);
      }
      var response = await client.get(Uri.parse(
          '${ApiEndpoints.baseUrl}${ApiEndpoints.getPostByUserId}/$loggineduserId'));
      if (kDebugMode) {
        print(
            '${ApiEndpoints.baseUrl}${ApiEndpoints.getPostByUserId}/$loggineduserId');
      }
      debugPrint(response.statusCode.toString());
      debugPrint(response.body);
      return response;
    } catch (e) {
      log(e.toString());
    }
  }

  //Edit Profile
  static Future editProfile(
      {required String image,
      required String name,
      required String bio,
      required String imageUrl,
      required String bgImageUrl,
      required String bgImage}) async {
    try {
      dynamic cloudinaryimageUrl;
      dynamic cloudinarybgimageUrl;
      if (image != '') {
        cloudinaryimageUrl = await PostRepo.uploadImage(image);
      }
      if (bgImage != '') {
        cloudinarybgimageUrl = await PostRepo.uploadImage(bgImage);
      }
      final token = await getUsertoken();
      final details = {
        "name": name,
        "bio": bio,
        "image": image != '' ? cloudinaryimageUrl : imageUrl,
        "backGroundImage": bgImage != '' ? cloudinarybgimageUrl : bgImageUrl
      };
      var response = await client.put(
          Uri.parse('${ApiEndpoints.baseUrl}${ApiEndpoints.editProfile}'),
          body: jsonEncode(details),
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json'
          });
      debugPrint(response.statusCode.toString());
      debugPrint(response.body);
      return response;
    } catch (e) {
      log(e.toString());
    }
  }

  //follow user
  static Future followUser({required String followerId}) async {
    try {
      final token = await getUsertoken();
      var response = client.post(
          Uri.parse(
              '${ApiEndpoints.baseUrl}${ApiEndpoints.followUser}/$followerId'),
          headers: {'Authorization': 'Bearer $token'});
      return response;
    } catch (e) {
      log(e.toString());
    }
  }

  //unfollow user
  static Future unfollowUser({required String followerId}) async {
    try {
      final token = await getUsertoken();
      var response = client.put(
          Uri.parse(
              '${ApiEndpoints.baseUrl}${ApiEndpoints.unfollowUser}/$followerId'),
          headers: {'Authorization': 'Bearer $token'});
      return response;
    } catch (e) {
      log(e.toString());
    }
  }

  //fetchAll user
  // static Future<Response?> fetchAllUser() async {
  //   try {
  //     final token = await getUsertoken();
  //     var response = client.get(
  //         Uri.parse('${ApiEndpoints.baseUrl}${ApiEndpoints.allUsers}'),
  //         headers: {'Authorization': 'Bearer $token'});
  //     return response;
  //   } catch (e) {
  //     log(e.toString());
  //     return null;
  //   }
  // }
  static Future<Response?> fetchAllUser(int page, int limit) async {
  try {
    final token = await getUsertoken();
    var response = await client.get(
      Uri.parse('${ApiEndpoints.baseUrl}${ApiEndpoints.allUsers}?page=$page&limit=$limit'),
      headers: {'Authorization': 'Bearer $token'},
    );
    
    log('Response status: ${response.statusCode}');
    log('Response body: ${response.body}');
    
    return response;
  } catch (e) {
    log(e.toString());
    return null;
  }
}

 static Future fetchFollowers() async {
    try {
      final token = await getUsertoken();
      var response = client.get(
          Uri.parse('${ApiEndpoints.baseUrl}${ApiEndpoints.getFollowers}'),
          headers: {'Authorization': 'Bearer $token'});
      return response;
    } catch (e) {
      log(e.toString());
    }
  }

  //fetch followers
  static Future fetchFollowing() async {
    try {
      final token = await getUsertoken();
      var response = client.get(
          Uri.parse('${ApiEndpoints.baseUrl}${ApiEndpoints.getFollowing}'),
          headers: {'Authorization': 'Bearer $token'});
      return response;
    } catch (e) {
      log(e.toString());
    }
  }

}
