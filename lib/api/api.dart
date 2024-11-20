import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:taskkonvator/model/post_model.dart';

class Api {
  fetchPosts() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    return response;
  }

  fetchPostDetails(int postId) async {
    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/Posts/$postId'));
    if (response.statusCode == 200) {
      PostModel data = PostModel.fromJson(jsonDecode(response.body));
      return data;
    } else {
      throw Exception('Failed to load PostModel detail');
    }
  }
}
