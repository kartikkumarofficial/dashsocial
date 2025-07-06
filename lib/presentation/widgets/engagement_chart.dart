import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:google_fonts/google_fonts.dart';

class EngagementChart extends StatelessWidget {
  final List<Map<String, dynamic>> data;

  const EngagementChart({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.6,
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          barTouchData: BarTouchData(enabled: true),
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, _) {

                  if (value >= 0 && value < data.length) {
                    final dateStr = data[value.toInt()]["date"] as String;

                    return Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Text(
                        dateStr.substring(5),
                        style: GoogleFonts.nunito(
                          fontSize: 12,
                          color: Colors.white,
                        ),
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
                reservedSize: 32,
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                interval: 50, // adjust as needed
                getTitlesWidget: (value, _) =>
                    Text(
                      value.toInt().toString(),
                      style: GoogleFonts.nunito(
                        fontSize: 10,
                        color: Colors.white70,
                      ),
                    ),
                reservedSize: 28,
              ),
            ),
            topTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            rightTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
          ),
          gridData: FlGridData(
            show: true,
            drawVerticalLine: false,
            horizontalInterval: 50,
            // verticalInterval: 1,
            getDrawingHorizontalLine: (value) =>
                FlLine(
                  color: Colors.white12,
                  strokeWidth: 1,
                ),
          ),
          borderData: FlBorderData(show: false),
          barGroups: List.generate(data.length, (index) {
            final engagement = (data[index]['engagement'] as num).toDouble();
            return BarChartGroupData(
              x: index,
              barRods: [
                BarChartRodData(
                  toY: engagement,
                  color: Colors.cyanAccent,
                  width: 16,
                  borderRadius: BorderRadius.circular(4),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}




