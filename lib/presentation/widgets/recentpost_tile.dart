import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RecentPostTile extends StatelessWidget {
  final String caption;
  final String imageUrl;
  final String time;
  final int likes;
  final int comments;

  const RecentPostTile({
    super.key,
    required this.caption,
    required this.imageUrl,
    required this.time,
    required this.likes,
    required this.comments,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[850],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            imageUrl,
            width: 50,
            height: 50,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => const Icon(Icons.image, color: Colors.white),
          ),
        ),
        title: Text(
          caption,
          style: GoogleFonts.poppins(color: Colors.white, fontSize: 14),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          "$likes likes • $comments comments • $time",
          style: GoogleFonts.poppins(color: Colors.white60, fontSize: 11),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white54, size: 16),
      ),
    );
  }
}
String monthName(int month) {
  const months = [
    "Jan", "Feb", "Mar", "Apr", "May", "Jun",
    "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"
  ];
  return months[month - 1];
}


