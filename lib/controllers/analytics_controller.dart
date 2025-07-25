import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../models/post_model.dart';
import '../presentation/screens/home_screen.dart';

class AnalyticsController extends GetxController {
  var followers = 0.obs;
  var reach = 0.obs;
  var likesOverTime = <double>[].obs;
  var username = ''.obs;
  var recentPosts = <PostModel>[].obs;

  final String baseUrl = 'http://192.168.215.239:3000/v1';



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
        final body = json.decode(res.body);
        print('Raw response: $body');
        final data = body['data'];
        print('Data object: $data');
        print('Counts: ${data['counts']}');

        followers.value = data['counts']['followed_by'];
        reach.value = data['counts']['reach'] ?? 1800;
        username.value = data['username'];

        print('Followers: ${followers.value}');
        print('Reach: ${reach.value}');
        print('Username: ${username.value}');
      } else {
        print('Non-200 response: ${res.statusCode}');
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
        print('Raw media: $media');

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
        print('Likes over time: ${likesOverTime.value}');
        print('Chart data: ${analyticsController.likesOverTime}');
      }
    } catch (e) {
      print('Error fetching media data: $e');
    }
  }

}
