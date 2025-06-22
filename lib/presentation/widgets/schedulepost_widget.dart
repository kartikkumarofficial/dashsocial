import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/post_controller.dart';
import '../../models/post_model.dart';

class ScheduledPostsWidget extends StatelessWidget {
  final PostController postController = Get.find();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<PostModel>>(
      future: postController.fetchScheduledPosts(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Padding(
            padding: EdgeInsets.all(12.0),
            child: Text("No scheduled posts yet!"),
          );
        }

        final posts = snapshot.data!;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
              child: Text("📅 Scheduled Posts", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
            ListView.builder(
              itemCount: posts.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final post = posts[index];
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          post.imageUrl,
                          width: 70,
                          height: 70,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(post.caption, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                            const SizedBox(height: 4),
                            Text(
                              post.scheduledAt != null
                                  ? "Scheduled: ${post.scheduledAt!.toLocal().toString().substring(0, 16)}"
                                  : "Scheduled: Not set",
                              style: TextStyle(color: Colors.grey[600], fontSize: 13),
                            ),

                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
