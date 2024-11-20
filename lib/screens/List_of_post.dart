import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

import 'controller/post_controller.dart';
import 'post_details_screen.dart';

class ListOfScreen extends StatelessWidget {
  const ListOfScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final postsController = Get.find<PostController>();

    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text('List of posts')),
      body: Obx(
        () => postsController.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: postsController.postModels.length,
                itemBuilder: (context, index) {
                  final post = postsController.postModels[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      leading: CircleAvatar(
                        child: Text("${post.id}"),
                      ),
                      tileColor: post.isRead
                          ? Colors.white
                          : const Color.fromARGB(255, 240, 255, 196),
                      title: Text(post.title),
                      trailing: Column(
                        children: [
                          Icon(Icons.timer),
                          Text('${post.remainingTime}s',
                              style: const TextStyle(color: Colors.grey)),
                        ],
                      ),
                      onTap: () async {
                        postsController.markPostAsRead(post.id);
                        await Get.to(() => PostDetailScreen(postId: post.id));
                      },
                    ),
                  );
                },
              ),
      ),
    );
  }
}
