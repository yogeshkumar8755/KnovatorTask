import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskkonvator/api/api.dart';

import '../../model/post_model.dart';
import 'package:http/http.dart' as http;

class PostController extends GetxController {
  final Api _api = Api();
  var postModels = <PostModel>[].obs;
  var isLoading = true.obs;
  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
    fetchAndSyncpostModels();
  }

  Future<void> fetchAndSyncpostModels() async {
    isLoading.value = true;

    try {
      final prefs = await SharedPreferences.getInstance();
      final localData = prefs.getString('postModels');
      if (localData != null) {
        postModels.value = (json.decode(localData) as List)
            .map((e) => PostModel.fromJson(e))
            .toList();
      }

      final response = await _api.fetchPosts();
      if (response.statusCode == 200) {
        final data = json.decode(response.body) as List;
        postModels.value = data.map((e) => PostModel.fromJson(e)).toList();

        prefs.setString('postModels',
            json.encode(postModels.map((e) => e.toJson()).toList()));
      }
    } catch (error) {
      debugPrint('Error fetching postModels: $error');
    } finally {
      isLoading.value = false;
      _startTimers();
    }
  }

  void _startTimers() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      for (var PostModel in postModels) {
        if (PostModel.remainingTime > 0) {
          PostModel.remainingTime--;
        }
      }
      postModels.refresh();
    });
  }

  Future<PostModel> fetchPostDetail(int postId) async {
    final response = await _api.fetchPostDetails(postId);
    return response;
  }

  void markPostAsRead(int PostModelId) {
    final PostModelIndex =
        postModels.indexWhere((PostModel) => PostModel.id == PostModelId);
    if (PostModelIndex != -1) {
      postModels[PostModelIndex].isRead = true;
      postModels.refresh();
    }
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}
