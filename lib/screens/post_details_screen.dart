import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskkonvator/model/post_model.dart';

import 'controller/post_controller.dart';

class PostDetailScreen extends StatelessWidget {
  final int postId;

  const PostDetailScreen({required this.postId, super.key});

  @override
  Widget build(BuildContext context) {
    final postController = Get.find<PostController>();

    return FutureBuilder(
      future: postController.fetchPostDetail(postId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            appBar: AppBar(title: const Text('Post Detail')),
            body: const Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasError) {
          return Scaffold(
            appBar: AppBar(title: const Text('Post Detail')),
            body: const Center(child: Text('Failed to load post details.')),
          );
        }

        PostModel? postDetail = snapshot.data;

        return Scaffold(
          appBar: AppBar(title: const Text('Post Detail')),
          body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("id :${postDetail!.id}"),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("title :${postDetail!.title}"),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Body :${postDetail}"),
                      ),
                    ],
                  ),
                ),
              )),
        );
      },
    );
  }
}
