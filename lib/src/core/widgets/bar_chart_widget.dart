import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';

class BarChartWidget extends StatelessWidget {
  final Map<String, int> tasksByDay;

  const BarChartWidget({
    super.key,
    required this.tasksByDay,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BarChart(
        BarChartData(
          barGroups: _getBarGroups(),
          borderData: FlBorderData(show: false),
          titlesData: FlTitlesData(
            topTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            rightTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: true, interval: 10),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  List<String> days = tasksByDay.keys.toList();
                  return Text(days[value.toInt()],
                      style: const TextStyle(fontSize: 12));
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<BarChartGroupData> _getBarGroups() {
    List<BarChartGroupData> barGroups = [];
    List<String> days = tasksByDay.keys.toList();

    for (int i = 0; i < days.length; i++) {
      barGroups.add(
        BarChartGroupData(
          x: i,
          barRods: [
            BarChartRodData(
              toY: tasksByDay[days[i]]!.toDouble(),
              color: Colors.blue,
              width: 15,
              borderRadius: BorderRadius.circular(4),
            ),
          ],
        ),
      );
    }

    return barGroups;
  }
}
