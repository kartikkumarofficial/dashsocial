import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AnalyticsDetailController extends GetxController {
  var engagementOverTime = <Map<String, dynamic>>[].obs;
  var genderDistribution = <String, int>{}.obs;
  var ageDistribution = <String, int>{}.obs;
  var highlightData = {}.obs;

  final String baseUrl = 'http://192.168.227.239:3000/v1';

  @override
  void onInit() {
    super.onInit();
    fetchAnalyticsData();
  }

  void fetchAnalyticsData() async {
    try {
      final res = await http.get(Uri.parse('$baseUrl/analytics'));
      if (res.statusCode == 200) {
        final body = json.decode(res.body)['data'];
        engagementOverTime.value =
        List<Map<String, dynamic>>.from(body['engagement_over_time']);
        genderDistribution.value =
        Map<String, int>.from(body['gender_distribution']);
        ageDistribution.value =
        Map<String, int>.from(body['age_distribution']);
        highlightData.value = Map<String, dynamic>.from(body['highlight']);
      }
    } catch (e) {
      print('Error fetching analytics: $e');
    }
  }
}
