import 'dart:io';
import 'dart:math';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart' as dt;
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:lottie/lottie.dart';

import '../../controllers/post_controller.dart';
import '../../core/suggestions.dart';




class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> with SingleTickerProviderStateMixin {
  final PostController postController = Get.put(PostController());
  File? selectedImage;
  DateTime? scheduledTime;
  final captionController = TextEditingController();


  bool showBulb = false;
  String currentSuggestion = "";

  Future<void> pickImage() async {
    try {
      final result = await FilePicker.platform.pickFiles(type: FileType.image);
      if (result != null && result.files.single.path != null) {
        setState(() {
          selectedImage = File(result.files.single.path!);
        });
      }
    } catch (e) {
      print("Image pick error: $e");
    }
  }

  void applyRandomSuggestion() {
    final random = (suggestions..shuffle()).first;
    setState(() {
      currentSuggestion = random;
      captionController.text = random;
    });



  Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          showBulb = false;
        });
      }
    });
  }

  void schedulePost() async {
    if (selectedImage == null || scheduledTime == null || captionController.text.trim().isEmpty) {
      Get.snackbar("Incomplete", "Please fill all fields before scheduling.",
          backgroundColor: Colors.redAccent, colorText: Colors.white);
      return;
    }

    await postController.uploadPost(
      image: selectedImage!,
      caption: captionController.text.trim(),
      scheduledAt: scheduledTime!,
    );


    if (!postController.isUploading.value) {
      setState(() {
        selectedImage = null;
        scheduledTime = null;
        captionController.clear();
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    final width = Get.width;
    final height = Get.height;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Plan Your Spotlight ✨",
            style: GoogleFonts.poppins(color: Colors.white)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: width * 0.06, vertical: height * 0.02),
        child: Column(
          children: [
            GestureDetector(
              onTap: pickImage,
              child: selectedImage == null
                  ? GlassmorphicContainer(
                width: double.infinity,
                height: height * 0.25,
                borderRadius: 20,
                blur: 15,
                alignment: Alignment.center,
                border: 1,
                linearGradient: LinearGradient(colors: [
                  Colors.white.withValues(alpha:0.1),
                  Colors.white.withValues(alpha:0.05),
                ]),
                borderGradient: LinearGradient(colors: [
                  Colors.white.withValues(alpha:0.2),
                  Colors.white.withValues(alpha:0.1),
                ]),
                child: const Icon(Icons.add_a_photo, color: Colors.white54, size: 36),
              )
                  : Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.file(
                      selectedImage!,
                      width: double.infinity,
                      height: height * 0.25,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: GestureDetector(
                      onTap: pickImage,
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.black54,
                        ),
                        child: const Icon(Icons.refresh, color: Colors.white, size: 20),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Caption Field
            GlassmorphicContainer(
              width: double.infinity,
              height: 180,
              borderRadius: 20,
              blur: 15,
              border: 1,
              linearGradient: LinearGradient(colors: [
                Colors.white.withValues(alpha: 0.1),
                Colors.white.withValues(alpha:0.05),
              ]),
              borderGradient: LinearGradient(colors: [
                Colors.white.withValues(alpha:0.2),
                Colors.white.withValues(alpha:0.1),
              ]),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text("Caption",
                            style: GoogleFonts.poppins(
                                color: Colors.white70, fontSize: 14)),
                        const Spacer(),
                        GestureDetector(
                          onTap: applyRandomSuggestion,
                          child: Row(
                            children: [
                              const Icon(Icons.lightbulb_outline, color: Colors.yellowAccent),
                              const SizedBox(width: 4),
                              Text("Suggest",
                                  style: GoogleFonts.poppins(
                                      color: Colors.greenAccent, fontSize: 12))
                            ],
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 10),
                    Stack(
                      children: [
                        TextFormField(
                          controller: captionController,
                          maxLines: 3,
                          style: const TextStyle(color: Colors.white),
                          decoration: const InputDecoration(
                            hintText: "Write something creative...",
                            hintStyle: TextStyle(color: Colors.white54),
                            border: InputBorder.none,
                          ),
                        ),
                        if (showBulb)
                          Positioned(
                            top: -20,
                            right: 0,
                            child: Lottie.asset('assets/lottie/bulb.json',
                                height: 50, repeat: false),
                          ),
                      ],
                    )
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Buttons Row
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Obx( (){
                  return postController.isUploading.value
                  ? CircularProgressIndicator()
                      :ElevatedButton(
                    onPressed:schedulePost,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.greenAccent,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                    ),
                    child: Text("Schedule Now",
                        style: GoogleFonts.poppins(color: Colors.black, fontSize: 16)),
                  );})//
                ),
                const SizedBox(width: 12),
                Expanded(
                  flex: 1,
                  child: ElevatedButton(
                    onPressed: () {
                      dt.DatePicker.showDateTimePicker(
                        context,
                        showTitleActions: true,
                        minTime: DateTime.now(),
                        theme: dt.DatePickerTheme(
                          backgroundColor: Colors.black,
                          itemStyle: GoogleFonts.poppins(color: Colors.white),
                          doneStyle: const TextStyle(color: Colors.green),
                        ),
                        onConfirm: (date) {
                          setState(() {
                            scheduledTime = date;
                          });
                        },
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white10,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                    ),
                    child: const Icon(Icons.calendar_today, color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

