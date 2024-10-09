import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:vibehunt/utils/api_url.dart';
import 'package:vibehunt/utils/funtions.dart';


class ChatRepo {
  static var client = http.Client();

  //get all conversations
Future getAllConversations() async {
    try {
      final token = await getUsertoken();
      var response = client.get(
          Uri.parse(
              '${ApiEndpoints.baseUrl}${ApiEndpoints.getAllConversations}'),
          headers: {'Authorization': 'Bearer $token'});
      return response;
    } catch (e) {
      log(e.toString());
    }
  }
  
}

