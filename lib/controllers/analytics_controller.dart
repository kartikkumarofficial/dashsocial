import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../models/post_model.dart';

class AnalyticsController extends GetxController {
  var followers = 0.obs;
  var reach = 0.obs;
  var likesOverTime = <double>[].obs;
  var username = ''.obs;
  var recentPosts = <PostModel>[].obs;

  final String baseUrl = 'http://192.168.227.239:3000/v1';


  @override
  void onInit() {
    super.onInit();
    fetchUserData();
    fetchMediaData();
  }

  void fetchUserData() async {
    try {
      final res = await http.get(Uri.parse('$baseUrl/users/user_id'));
      if (res.statusCode == 200) {
        final data = json.decode(res.body)['data'];
        followers.value = data['counts']['followed_by'];
        reach.value = 18400;
        username.value = data['username'];
      }
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }

  void fetchMediaData() async {
    try {
      final res = await http.get(Uri.parse('$baseUrl/users/user_id/media/recent'));
      if (res.statusCode == 200) {
        final List media = json.decode(res.body)['data'];

        likesOverTime.value = media
            .take(5)
            .map<double>((item) => item['likes']['count'] / 1000)
            .toList();

        recentPosts.value = media.take(3).map<PostModel>((item) {
          return PostModel(
            caption: item['caption']['text'],
            likes: item['likes']['count'],
            comments: item['comments']['count'],
            imageUrl: item['images']['thumbnail']['url'],
            createdTime: DateTime.fromMillisecondsSinceEpoch(
                int.parse(item['created_time']) * 1000),
          );
        }).toList();
      }
    } catch (e) {
      print('Error fetching media data: $e');
    }
  }

}
