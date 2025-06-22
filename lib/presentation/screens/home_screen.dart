import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fl_chart/fl_chart.dart';

import '../../controllers/analytics_controller.dart';
import '../widgets/recentpost_tile.dart';
import '../widgets/stat_Card.dart';
final analyticsController = Get.put(AnalyticsController());

class HomeScreen extends StatelessWidget {
    HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: Obx(() => Text(
          'Welcome, ${analyticsController.username} 👋',
          style: GoogleFonts.poppins(color: Colors.white, fontSize: 20),
        )),

        actions: [
          IconButton(
            icon:   Icon(Icons.notifications, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: ()async{
          analyticsController.fetchUserData();
          analyticsController.fetchMediaData();
        },
        child:
        ListView(
          padding:   EdgeInsets.all(16),
          children: [
            Row(
              children: [
                Obx(() => StatCard("Followers", "${analyticsController.followers}", Icons.group)),
                SizedBox(width: 12),
                Obx(() => StatCard("Reach", "${analyticsController.reach}", Icons.visibility)),

              ],
            ),
              SizedBox(height: 24),
            Text(
              "Engagement Overview",
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
              SizedBox(height: 12),
            Obx(() {
              final data = analyticsController.likesOverTime;

              if (data.isEmpty) {
                return Container(
                  height: 200,
                  alignment: Alignment.center,
                  child: Text(
                    "No engagement data available",
                    style: TextStyle(color: Colors.white54),
                  ),
                );
              }

              return SizedBox(
                height: 200,
                child: LineChart(
                  LineChartData(
                    backgroundColor: Colors.transparent,
                    gridData: FlGridData(
                      show: true,
                      drawHorizontalLine: true,
                      horizontalInterval: 1,
                      getDrawingHorizontalLine: (_) => FlLine(
                        color: Colors.white12,
                        strokeWidth: 1,
                      ),
                    ),
                    titlesData: FlTitlesData(
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          interval: 1,
                          getTitlesWidget: (value, _) => Padding(
                            padding: EdgeInsets.only(top: 8),
                            child: Text(
                              "Day ${value.toInt() + 1}",
                              style: TextStyle(color: Colors.white54, fontSize: 10),
                            ),
                          ),
                        ),
                      ),
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          interval: 1,
                          getTitlesWidget: (value, _) => Text(
                            value.toInt().toString(),
                            style: TextStyle(color: Colors.white54, fontSize: 10),
                          ),
                        ),
                      ),
                      rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    ),
                    borderData: FlBorderData(
                      show: true,
                      border: Border.all(color: Colors.white10),
                    ),
                    minX: 0,
                    maxX: data.length.toDouble() - 1,
                    minY: 0,
                    maxY: data.reduce((a, b) => a > b ? a : b) + 1,
                    lineBarsData: [
                      LineChartBarData(
                        isCurved: true,
                        color: Colors.greenAccent,
                        barWidth: 3,
                        dotData: FlDotData(show: false),
                        belowBarData: BarAreaData(show: false),
                        spots: List.generate(
                          data.length,
                              (index) => FlSpot(index.toDouble(), data[index]),
                        ),
                      )
                    ],
                  ),
                ),
              );
            }),

            SizedBox(height: 24),
            Text(
              "Recent Posts",
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
              SizedBox(height: 10),
            Obx(() {
              if (analyticsController.recentPosts.isEmpty) {
                return Text(
                  "No posts to display",textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white54),
                );
              }

              return Column(
                children: analyticsController.recentPosts.map((post) {
                  return RecentPostTile(
                    caption: post.caption,
                    imageUrl: post.imageUrl,
                    time: "${post.createdTime.day} ${monthName(post.createdTime.month)}",
                    likes: post.likes,
                    comments: post.comments,
                  );
                }).toList(),
              );
            }),


            SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {},
              icon:   Icon(Icons.add, color: Colors.black),
              label:   Text(
                "Create New Post",
                style: TextStyle(color: Colors.black),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                padding:   EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }




}
