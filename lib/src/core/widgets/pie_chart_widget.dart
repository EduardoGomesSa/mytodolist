import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class PieChartWidget extends StatelessWidget {
  final int totalTarefas;
  final int tarefasAbertas;
  final int tarefasConcluidas;

  const PieChartWidget({
    super.key,
    required this.totalTarefas,
    required this.tarefasAbertas,
    required this.tarefasConcluidas,
  });

  @override
  Widget build(BuildContext context) {
    final double porcentagemAbertas = (tarefasAbertas / totalTarefas) * 100;
    final double porcentagemConcluidas =
        (tarefasConcluidas / totalTarefas) * 100;
    const double radius = 80;

    return Center(
      child: PieChart(
        PieChartData(
          sections: [
            PieChartSectionData(
              value: porcentagemAbertas,
              color: Colors.red,
              title: 'Em abertas ${porcentagemAbertas.toStringAsFixed(1)}%',
              radius: radius,
              titleStyle: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  color: Colors.black),
            ),
            PieChartSectionData(
              value: porcentagemConcluidas,
              color: Colors.blue,
              title: 'Concluídas ${porcentagemConcluidas.toStringAsFixed(1)}%',
              radius: radius,
              titleStyle: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  color: Colors.black),
            ),
          ],
          borderData: FlBorderData(show: false),
          sectionsSpace: 0,
          centerSpaceRadius: 0,
          startDegreeOffset: 20,
        ),
      ),
    );
  }
}
