
import 'package:dashsocial/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../controllers/theme_controller.dart';
import '../../../controllers/user_controller.dart';
import '../../widgets/profile_tile.dart';
import '../../widgets/stat_item.dart';
import 'edit_accountdetails_screen.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ThemeController themeController = Get.put(ThemeController());

  final UserController userController = Get.find<UserController>();

  @override
  void initState() {
    super.initState();
    userController.fetchUserProfile();
  }


  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [

          // Positioned(
          //   right: 10,
          //   top: 30,
          //   child: IconButton(
          //     icon:   Icon(Icons.edit, color: Colors.white),
          //     onPressed: () async {
          //       final result = await Get.to(() => EditAccountPage());
          //       if (result == true) {
          //         userController.fetchUserProfile();
          //       }
          //     },
          //
          //   ),
          // ),
          Obx(() => userController.isLoading.value
              ?   Center(child: CircularProgressIndicator())
              : ListView(
            children: [
                SizedBox(height: 45),

              Center(
                child: CircleAvatar(
                  radius: Get.width * 0.17,
                  backgroundImage: NetworkImage(
                      userController.profileImageUrl.value),
                ),
              ),
                SizedBox(height: 16),


              Center(
                child: Text(
                  userController.userName.value,
                  style: GoogleFonts.playfairDisplay(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
                SizedBox(height: 4),

              Center(
                child: Text(
                  userController.email.value,
                  style: GoogleFonts.barlow(color: Colors.grey[400]),
                ),
              ),
                SizedBox(height: 32),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  StatItem("Followers", analyticsController.followers.toString()),
                  StatItem("Posts", analyticsController.recentPosts.length.toString()),
                  StatItem("Reach", analyticsController.reach.toString()),
                ],
              ),
                SizedBox(height: 32),


                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: Get.width*0.02),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //for future twitter implementation
                  //     Text("Connected Platforms",
                  //       style:
                  //       TextStyle(color: Colors.white, fontSize: 16)),
                  //
                  // SizedBox(height: 12),
                  //               Row(
                  // children: [
                  //    PlatformIcon(Icons.camera_alt, "Instagram", true),
                  //    PlatformIcon(Icons.message, "Twitter", false),
                  // ],
                  //               ),
                  SizedBox(height: 32),


                                ProfileTile(
                                  onTap: () async {
                                    final result = await Get.to(() => EditAccountPage());
                                    if (result == true) {
                                      userController.fetchUserProfile();
                                    }},
                  icon: Icons.settings,
                  label: "Edit Account Details",
                                ),
                                Obx(() => ProfileTile(
                  icon: Icons.brightness_6,
                  label: themeController.isDarkMode.value
                      ? "Switch to Light Mode"
                      : "Switch to Dark Mode",
                  onTap: themeController.toggleTheme,
                                )),
                                ProfileTile(
                  icon: Icons.lock,
                  label: "Security",
                  onTap: () {},
                                ),
                    ],
                  ),
                ),
                SizedBox(height: 24),

             //logout
              TextButton.icon(
                onPressed: () {
                  userController.logout();
                },
                icon:   Icon(Icons.logout,
                    color: Colors.redAccent),
                label:   Text(
                  'Log Out',
                  style: TextStyle(color: Colors.redAccent),
                ),
              ),
                SizedBox(height: 12),
              Center(
                child: Text(
                  "v1.0.0 • DashSocial",
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ),
                SizedBox(height: 24),
            ],
          )),
        ],
      ),
    );
  }
}
