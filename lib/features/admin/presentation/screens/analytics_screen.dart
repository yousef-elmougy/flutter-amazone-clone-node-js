import 'package:fl_chart/fl_chart.dart';

import '../../../../exports.dart';

class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const List<String> categoriesTitles = [
      'Mobiles ',
      'Electronics',
      'Essentials',
      'Appliances',
      'Books',
      'Fashion',
    ];
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Analytics', style: Style.textBold_14),
        flexibleSpace: Container(
          decoration: const BoxDecoration(gradient: kAppBarGradient),
        ),
      ),
      body: BlocBuilder<AdminCubit, AdminState>(
        builder: (context, state) {
          if (state is GetAnalyticsLoading) {
            return const LoaderWidget();
          }
          final analytics = context.read<AdminCubit>().analytics;
          List<num> earning = [];

          if (analytics != null) {
            earning = [
              analytics.mobileEarning,
              analytics.electronicsEarning,
              analytics.essentialsEarning,
              analytics.appliancesEarning,
              analytics.booksEarning,
              analytics.fashionEarning,
            ];
          }
          return analytics == null
              ? const LoaderWidget()
              : Padding(
                  padding: const EdgeInsets.all(16),
                  child: BarChart(
                    swapAnimationDuration: const Duration(milliseconds: 150),
                    swapAnimationCurve: Curves.linear,
                    BarChartData(
                      maxY: analytics.totalEarning.toDouble(),
                      gridData: FlGridData(show: false),
                      borderData: FlBorderData(
                        border: const Border(
                          top: BorderSide.none,
                          right: BorderSide.none,
                          left: BorderSide(width: 1),
                          bottom: BorderSide(width: 1),
                        ),
                      ),
                      barGroups: List.generate(
                        earning.length,
                        (index) => BarChartGroupData(
                          x: index,
                          barRods: [
                            BarChartRodData(
                              toY: earning[index].toDouble(),
                              width: 15,
                              color: Colors.amber,
                            ),
                          ],
                        ),
                      ),
                      titlesData: FlTitlesData(
                        show: true,
                        rightTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: false)),
                        topTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: false)),
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: (value, meta) {
                              int index = value.toInt();
                              if (index >= 0 &&
                                  index < categoriesTitles.length) {
                                return SideTitleWidget(
                                  angle: -.4,
                                  axisSide: meta.axisSide,
                                  child: Text(
                                    categoriesTitles[index],
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                );
                              }
                              return const Text('');
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                );
        },
      ),
    );
  }
}

// class MyBarChart extends StatelessWidget {
//   final List<String> categoriesTitles = [
//     'Mobiles',
//     'Electronics',
//     'Essentials',
//     'Appliances',
//     'Books',
//     'Fashion',
//   ];

//   final List<int> earning = [40, 30, 50, 10, 20, 5];

//   const MyBarChart({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BarChart(
//       BarChartData(
//         maxY: earning
//             .reduce((curr, next) => curr > next ? curr : next)
//             .toDouble(),
//         gridData: FlGridData(show: false),
//         borderData: FlBorderData(
//           border: const Border(
//             top: BorderSide.none,
//             right: BorderSide.none,
//             left: BorderSide(width: 1),
//             bottom: BorderSide(width: 1),
//           ),
//         ),
//         barGroups: List.generate(
//           earning.length,
//           (index) => BarChartGroupData(
//             x: index,
//             barRods: [
//               BarChartRodData(
//                 toY: earning[index].toDouble(),
//                 width: 15,
//                 color: Colors.amber,
//               ),
//             ],
//           ),
//         ),
//         titlesData: FlTitlesData(
//           show: true,
//           rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
//           topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
//           bottomTitles: AxisTitles(
//             sideTitles: SideTitles(
//               showTitles: true,
//               getTitlesWidget: (value, meta) {
//                 int index = value.toInt();
//                 if (index >= 0 && index < categoriesTitles.length) {
//                   return Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 10.0),
//                     child: Text(
//                       categoriesTitles[index],
//                       style: const TextStyle(fontSize: 10),
//                     ),
//                   );
//                 }
//                 return const Text('');
//               },
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
