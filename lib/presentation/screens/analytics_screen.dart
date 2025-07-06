import 'package:dashsocial/presentation/widgets/age_chart.dart';
import 'package:dashsocial/presentation/widgets/gender_chart.dart';
import 'package:dashsocial/presentation/widgets/engagement_chart.dart';
import 'package:dashsocial/presentation/widgets/highlight_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/analytics_detail_controller.dart';

class AnalyticsScreen extends StatefulWidget {
  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  final controller = Get.find<AnalyticsDetailController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],

      body: Obx(() {

        if (controller.engagementOverTime.isEmpty ||
            controller.highlightData.isEmpty ||
            controller.genderDistribution.isEmpty ||
            controller.ageDistribution.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SafeArea(child: Text('Audience Insights',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 25),)),
              HighlightCard(highlight: controller.highlightData.value),


              const SizedBox(height: 24),

              const Text(
                "Engagement Over Time",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              EngagementChart(data: controller.engagementOverTime),
              const SizedBox(height: 24),

              const Text(
                "Gender Distribution",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              GenderChart(genderData: controller.genderDistribution.value),
              const SizedBox(height: 24),

              const Text(
                "Age Distribution",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              AgeChart(ageData: controller.ageDistribution.value),
              const SizedBox(height: 24),
            ],
          ),
        );
      }),
    );
  }
}
