import 'package:get/get.dart';
import '../models/schedule_post_model.dart';


class ScheduleController extends GetxController {
  var scheduledPosts = <ScheduledPost>[].obs;

  void addPost(ScheduledPost post) {
    scheduledPosts.add(post);
  }

  void removePost(int index) {
    scheduledPosts.removeAt(index);
  }
}
