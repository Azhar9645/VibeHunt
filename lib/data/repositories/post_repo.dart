import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:vibehunt/utils/api_url.dart';
import 'package:vibehunt/utils/funtions.dart';

class PostRepo {
  static var client = http.Client();
  //Add post
  static Future<Response?> addPost(
      String description, String image, List<String> tags) async {
    try {
      final imageUrl = await PostRepo.uploadImage(image);
      final userid = await getUserId();
      final token = await getUsertoken();
      final post = {
        'imageUrl': imageUrl,
        'description': description,
        'tags': tags,
        'userId': userid
      };
      var response = await client.post(
          Uri.parse('${ApiEndpoints.baseUrl}${ApiEndpoints.addpostUrl}'),
          body: jsonEncode(post),
          headers: {
            "Content-Type": 'application/json',
            'Authorization': 'Bearer $token'
          });
      debugPrint(response.statusCode.toString());
      return response;
    } catch (e) {
      return null;
    }
  }

  // edit post
  static Future<Response?> editPost({
    required String description,
    required String postId,
    required List<String> tags,
  }) async {
    try {
      final token = await getUsertoken();
      final post = {
        'description': description,
        'tags': tags,
      };

      final response = await client.put(
        Uri.parse('${ApiEndpoints.baseUrl}${ApiEndpoints.updatePost}/$postId'),
        body: jsonEncode(post),
        headers: {
          "Content-Type": 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      debugPrint('Response status: ${response.statusCode}');
      debugPrint('Response body: ${response.body}');

      if (response.statusCode == 200) {
        return response;
      } else {
        // Handle different status codes if needed
        return null;
      }
    } catch (e) {
      log('Error in editPost: $e');
      return null;
    }
  }

  // upload to cloudinary
  static Future uploadImage(imagePath) async {
    String filePath = imagePath;
    File file = File(filePath);
    try {
      final url =
          Uri.parse('https://api.cloudinary.com/v1_1/djvy5tkpi/image/upload');
      // final file = await imagePath.file ?? imagePath;
      final request = http.MultipartRequest('POST', url)
        ..fields['upload_preset'] = 'mmbpfibi'
        ..files.add(await http.MultipartFile.fromPath('file', file.path));
      final response = await request.send();
      debugPrint(response.statusCode.toString());
      if (response.statusCode == 200) {
        final responseData = await response.stream.toBytes();
        final responseString = String.fromCharCodes(responseData);
        final jsonMap = jsonDecode(responseString);
        log(jsonMap['url']);
        return jsonMap['url'];
      }
    } catch (e) {
      log(e.toString());
    }
  }

  //Delete Post
  static Future<Response?> deletePost(String postId) async {
  try {
    final token = await getUsertoken();
    debugPrint("User token: $token");
    debugPrint("Post ID to delete: $postId");
    var response = await client.delete(
        Uri.parse(
            '${ApiEndpoints.baseUrl}${ApiEndpoints.deletePost}/$postId'),
        headers: {'Authorization': 'Bearer $token'});
    
    debugPrint("Delete API Response Status: ${response.statusCode}");
    debugPrint("Delete API Response Body: ${response.body}");

    return response;
  } catch (e) {
    debugPrint("Error while deleting post: $e");
    return null;
  }
}

 //fetch followers post
  static Future getAllFollowingPost({required int page}) async {
    try {
      final token = await getUsertoken();
      var response = await client.get(
          Uri.parse(
              '${ApiEndpoints.baseUrl}${ApiEndpoints.allFollowingsPost}?page=$page&pageSize=5'),
          headers: {'Authorization': 'Bearer $token'});

      return response;
    } catch (e) {
      log(e.toString());
    }
  }

//Get All comments
  static Future getAllComments({required String postId}) async {
    try {
      final token = await getUsertoken();
      var response = await client.get(
          Uri.parse(
              '${ApiEndpoints.baseUrl}${ApiEndpoints.getAllComments}/$postId'),
          headers: {'Authorization': 'Bearer $token'});
      debugPrint(response.statusCode.toString());

      return response;
    } catch (e) {
      log(e.toString());
    }
  }

  //comment post
  static Future commentPost(
      {required String postId,
      required String userName,
      required String content}) async {
    try {
      final userId = await getUserId();
      final token = await getUsertoken();
      final comment = {
        'userId': userId,
        'userName': userName,
        'postId': postId,
        'content': content
      };
      var response = await client.post(
          Uri.parse(
              '${ApiEndpoints.baseUrl}${ApiEndpoints.createCommentPost}/$postId'),
          body: jsonEncode(comment),
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json'
          });
      // final responseBody = jsonDecode(response.body);
      debugPrint(response.statusCode.toString());
      debugPrint(response.body);
      return response;
    } catch (e) {
      log(e.toString());
    }
  }

  //Delete comments
  static Future deleteComment({required String commentId}) async {
    try {
      final token = await getUsertoken();
      var response = await client.delete(
          Uri.parse(
              '${ApiEndpoints.baseUrl}${ApiEndpoints.deleteComments}/$commentId'),
          headers: {'Authorization': 'Bearer $token'});
      debugPrint(response.statusCode.toString());
      debugPrint(response.body);
      return response;
    } catch (e) {
      log(e.toString());
    }
  }

    //Like post
  static Future likePost({required String postId}) async {
    try {
      final token = await getUsertoken();
      var response = await client.patch(
          Uri.parse('${ApiEndpoints.baseUrl}${ApiEndpoints.likePost}/$postId'),
          headers: {'Authorization': 'Bearer $token'});
      return response;
    } catch (e) {
      log(e.toString());
    }
  }

  //unlike post
  static Future unlikePost({required String postId}) async {
    try {
      final token = await getUsertoken();
      var response = await client.patch(
          Uri.parse(
              '${ApiEndpoints.baseUrl}${ApiEndpoints.unlikePost}/$postId'),
          headers: {'Authorization': 'Bearer $token'});
      return response;
    } catch (e) {
      log(e.toString());
    }
  }

  
}
