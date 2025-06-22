import 'package:dashsocial/presentation/screens/schedule_post_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../controllers/analytics_controller.dart';
import '../widgets/recentpost_tile.dart';
import '../widgets/stat_Card.dart';
final analyticsController = Get.put(AnalyticsController());

class HomeScreen extends StatefulWidget {
    HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Stream<List<Map<String, dynamic>>> getUserPosts() {
    final uid = Supabase.instance.client.auth.currentUser?.id;
    return Supabase.instance.client
        .from('posts')
        .stream(primaryKey: ['id'])
        .eq('user_id', uid!)
        .order('created_at', ascending: false);

  }
  Stream<List<Map<String, dynamic>>> getScheduledPosts() {
    final uid = Supabase.instance.client.auth.currentUser?.id;
    final now = DateTime.now().toIso8601String();

    return Supabase.instance.client
        .from('posts')
        .stream(primaryKey: ['id'])
        .eq('user_id', uid!)
        .order('scheduled_at', ascending: true)
        .map((posts) => posts
        .where((post) =>
    post['scheduled_at'] != null &&
        DateTime.parse(post['scheduled_at']).isAfter(DateTime.now()))
        .toList());
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      body: RefreshIndicator(
        onRefresh: ()async{
          analyticsController.fetchUserData();
          analyticsController.fetchMediaData();
        },
        child:
        ListView(
          padding:   EdgeInsets.all(16),
          children: [
            SafeArea(
              child: Row(
                children: [
                  Obx(() => Text(
                    'Welcome, ${analyticsController.username} 👋',overflow: TextOverflow.fade,
                    style: GoogleFonts.poppins(color: Colors.white, fontSize: Get.width*0.05),
                  )),
                  Positioned(
                    right: 5,
                    child: IconButton(
                      icon:   Icon(Icons.notifications, color: Colors.white),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),
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
                    comments:  post.comments,
                  );
                }).toList(),
              );
            }),


            SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {Get.to(ScheduleScreen());},
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
            SizedBox(height: 10,),

            SizedBox(height: 10),
            StreamBuilder<List<Map<String, dynamic>>>(
              stream: getScheduledPosts(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      "No upcoming scheduled posts.",
                      style: TextStyle(color: Colors.white54),
                      textAlign: TextAlign.center,
                    ),
                  );
                }

                final scheduled = snapshot.data!;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "📅 Scheduled Posts",
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 10),
                    ...scheduled.map((post) => Container(
                      margin: EdgeInsets.only(bottom: 12),
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white10,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              post['image_url'],
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  post['caption'],
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  "Scheduled for: ${DateTime.parse(post['scheduled_at']).toLocal().toString().substring(0, 16)}",
                                  style: TextStyle(color: Colors.white70, fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ))
                  ],
                );
              },
            ),

          ],
        ),
      ),
    );
  }
}
