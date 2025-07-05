import 'package:dashsocial/homepage.dart';
import 'package:dashsocial/presentation/screens/analytics_screen.dart';
import 'package:dashsocial/presentation/screens/dashboard_screen.dart';
import 'package:dashsocial/presentation/screens/schedule_post_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/nav_controller.dart';
import '../widgets/bottom_navigation_bar.dart';
import 'home_screen.dart';
import 'profile/profile_screen.dart';

class MainScaffold extends StatelessWidget {
  MainScaffold({super.key});

  final NavController navController = Get.put(NavController());

  final List<Widget> screens = [
      HomeScreen(),
      AnalyticsScreen(),
      ScheduleScreen(),
    ProfileScreen(
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
      backgroundColor:   Color(0xFF121212),
      body: screens[navController.selectedIndex.value],
      bottomNavigationBar: BottomNavBar(navController: navController),
    ));
  }
}


