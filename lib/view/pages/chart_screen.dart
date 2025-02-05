import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:math_mini/core/utils.dart';
import 'package:math_mini/view/widgets/rounded_thumb_shape.dart';

import '../../core/constants.dart';

class ChartScreen extends StatefulWidget {
  const ChartScreen({super.key});

  @override
  State<ChartScreen> createState() => _ChartScreenState();
}

class _ChartScreenState extends State<ChartScreen> {
  final TextEditingController _controller = TextEditingController();

  int trials = 0;

  late List<int> tailsCount;

  static const List<Color> gradientColors = [
    primaryColor,
    secondaryColor,
  ];

  bool showAvg = false;

  bool isCurved = false;
  bool showSpots = false;
  bool isBarChart = false;
  bool isSliderEnabled = false;
  bool isGradientEnabled = true;

  void _showBottomModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        bool isCurvedLocal = isCurved;
        bool showSpotsLocal = showSpots;
        bool isBarChartLocal = isBarChart;
        bool isSliderEnabledLocal = isSliderEnabled;
        bool isGradientEnabledLocal = isGradientEnabled;

        return StatefulBuilder(
          builder: (context, setModalState) {
            Widget settingsTile(text, {required IconData icon, required Widget switchWidget}) {
              return Container(
                padding: EdgeInsets.all(6).copyWith(left: 12),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white10, width: 1),
                  color: Color(0xff111111),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    // Setting Name
                    Expanded(
                      child: Row(
                        children: [
                          HugeIcon(
                            icon: icon,
                            color: Color(0xff308999),
                            size: 24.0,
                          ),
                          SizedBox(width: 10),
                          Text(
                            text,
                            style: TextStyle(color: Colors.white70),
                          ),
                        ],
                      ),
                    ),
                    // Switch
                    Transform.scale(
                      scale: 0.8,
                      child: switchWidget,
                    ),
                  ],
                ),
              );
            }

            return Container(
              decoration: BoxDecoration(
                color: Color(0xff222222),
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              ),
              width: MediaQuery.of(context).size.width * 0.9,
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white10, width: 1),
                      color: Color(0xff1f1f1f),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      children: [
                        settingsTile(
                          'Toggle Gradient',
                          icon: HugeIcons.strokeRoundedColors,
                          switchWidget: Switch(
                            value: isGradientEnabledLocal,
                            activeColor: Color(0xff308999),
                            activeTrackColor: Color(0xff112934),
                            splashRadius: 1,
                            inactiveTrackColor: Color(0xff121212),
                            onChanged: isBarChartLocal
                                ? null
                                : (value) {
                                    setModalState(() {
                                      isGradientEnabledLocal = value;
                                    });

                                    setState(() {
                                      isGradientEnabled = value;
                                    });
                                  },
                          ),
                        ),
                        settingsTile(
                          'Toggle Curves',
                          icon: HugeIcons.strokeRoundedBendTool,
                          switchWidget: Switch(
                            value: isCurvedLocal,
                            activeColor: Color(0xff308999),
                            activeTrackColor: Color(0xff112934),
                            splashRadius: 1,
                            inactiveTrackColor: Color(0xff121212),
                            onChanged: isBarChartLocal
                                ? null
                                : (value) {
                                    setModalState(() {
                                      isCurvedLocal = value;
                                    });

                                    setState(() {
                                      isCurved = value;
                                    });
                                  },
                          ),
                        ),
                        settingsTile(
                          'Toggle Spots',
                          icon: HugeIcons.strokeRoundedChartScatter,
                          switchWidget: Switch(
                            value: showSpotsLocal,
                            activeColor: Color(0xff308999),
                            activeTrackColor: Color(0xff112934),
                            splashRadius: 1,
                            inactiveTrackColor: Color(0xff121212),
                            onChanged: isBarChartLocal
                                ? null
                                : (value) {
                                    setModalState(() {
                                      showSpotsLocal = value;
                                    });

                                    setState(() {
                                      showSpots = value;
                                    });
                                  },
                          ),
                        ),
                        settingsTile(
                          'Toggle BarChart',
                          icon: HugeIcons.strokeRoundedChartHistogram,
                          switchWidget: Switch(
                            value: isBarChartLocal,
                            activeColor: Color(0xff308999),
                            activeTrackColor: Color(0xff112934),
                            splashRadius: 1,
                            inactiveTrackColor: Color(0xff121212),
                            onChanged: (value) {
                              setModalState(() {
                                isBarChartLocal = value;
                              });

                              setState(() {
                                isBarChart = value;
                              });
                            },
                          ),
                        ),
                        settingsTile(
                          'Toggle Input',
                          icon: HugeIcons.strokeRoundedKeyboard,
                          switchWidget: Switch(
                            value: isSliderEnabledLocal,
                            activeColor: Color(0xff308999),
                            activeTrackColor: Color(0xff112934),
                            splashRadius: 1,
                            inactiveTrackColor: Color(0xff121212),
                            onChanged: (value) {
                              setModalState(() {
                                isSliderEnabledLocal = value;
                              });

                              setState(() {
                                isSliderEnabled = value;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 24),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: const EdgeInsets.all(4.0),
                      decoration: BoxDecoration(
                        color: Colors.redAccent,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: HugeIcon(
                        icon: HugeIcons.strokeRoundedCancel01,
                        color: Colors.black,
                        size: 24.0,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  _handleButtonPress() {
    try {
      if (_controller.text.isEmpty) throw 'Please enter a number';
      var trialValue = int.parse(_controller.text);
      if (trialValue < 0) throw 'No. of trials should be positive';

      setState(() {
        trials = trialValue;
      });
    } on FormatException {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(getSnackBar('NaN', 'Please enter a valid number', ContentType.failure));
    } catch (e) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(getSnackBar('Invalid Input', e, ContentType.failure));
    }
  }

  @override
  Widget build(BuildContext context) {
    tailsCount = coinTossOutcomes(trials);
    final sampleTrials = [1, 5, 10, 20, 30, 100, 200, 1000, 14000];

    return Padding(
      padding: const EdgeInsets.only(top: 48),
      child: Column(
        spacing: 20,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Trials Header
          Container(
            margin: EdgeInsets.only(left: 32, right: 32, bottom: 10),
            child: Row(
              spacing: 20,
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: gradientColors.map((color) => color.withValues(alpha: 0.1)).toList(),
                      ),
                      border: Border.all(color: primaryColor),
                      // color: Color(0xff222222),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      '${formatNumber(trials)} Trial${trials == 1 ? '' : 's'} Performed',
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: primaryColor,
                        // color: Colors.white54,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    _showBottomModal(context);
                  },
                  child: Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: gradientColors[0],
                    ),
                    child: Center(
                        child: HugeIcon(
                      icon: HugeIcons.strokeRoundedSettings03,
                      color: Colors.black,
                      size: 32.0,
                    )),
                  ),
                ),
              ],
            ),
          ),

          Container(
            height: 300,
            padding: const EdgeInsets.only(left: 10.0, right: 32),
            child: isBarChart ? BarChart(barChartData()) : LineChart(mainData()),
          ),

          isSliderEnabled
              ?
              // Slider
              Container(
                  width: MediaQuery.of(context).size.width * 0.6,
                  decoration: BoxDecoration(
                    border: Border.all(color: primaryColor.withAlpha(80), width: 2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      activeTrackColor: primaryColor, // Color of the track when dragged
                      inactiveTrackColor: Colors.grey.shade300, // Color of the track before the thumb
                      trackHeight: 6.0, // Thickness of the track
                      thumbColor: primaryColor, // Color of the thumb
                      thumbShape: RoundedRectSliderThumbShape(width: 20.0, height: 20.0), // Size of the thumb
                      tickMarkShape: RoundSliderTickMarkShape(), // Shape of tick marks
                      activeTickMarkColor: primaryColor.withValues(alpha: 0.7),
                      inactiveTickMarkColor: Colors.grey.shade500,
                      valueIndicatorColor: primaryColor, // Color of the value indicator
                      valueIndicatorTextStyle: TextStyle(color: Colors.white), // Text style for the value
                    ),
                    child: Slider(
                      label: "Trials",
                      value: trials.toDouble().clamp(0, 2000),
                      onChanged: (value) {
                        setState(() {
                          trials = value.toInt();
                        });
                      },
                      min: 0,
                      max: 2000,
                    ),
                  ),
                )
              :
              // Trial Input
              SizedBox(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: Row(
                    spacing: 10,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.405,
                        height: 50,
                        child: TextField(
                          controller: _controller,
                          keyboardType: TextInputType.number,
                          style: TextStyle(
                            color: Colors.white54,
                          ),
                          decoration: InputDecoration(
                            hintText: 'No. of trials',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(color: Colors.white54, width: 4),
                            ),
                          ),
                          onSubmitted: (_) => _handleButtonPress(),
                        ),
                      ),
                      GestureDetector(
                        onTap: _handleButtonPress,
                        child: Container(
                          height: 45,
                          padding: EdgeInsets.symmetric(horizontal: 15.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: gradientColors[0],
                          ),
                          child: Center(child: Text('Enter', style: TextStyle(fontWeight: FontWeight.w700))),
                        ),
                      ),
                    ],
                  ),
                ),

          // Sample Trials
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.6,
            child: Wrap(
              spacing: 10,
              runSpacing: 10,
              direction: Axis.horizontal,
              children: List.generate(
                sampleTrials.length,
                (index) => GestureDetector(
                  onTap: () {
                    setState(() {
                      trials = sampleTrials[index];
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: gradientColors.map((color) => color.withValues(alpha: 0.1)).toList(),
                      ),
                      border: Border.all(color: primaryColor),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(formatNumber(sampleTrials[index]), style: TextStyle(color: primaryColor)),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<int> generateYAxisLabels(int maxFreq) {
    if (maxFreq == 0) return List.generate(11, (index) => index);
    int step = (maxFreq / 10).ceil(); // Ensure 11 values instead of 10
    return List.generate(11, (index) => step * index);
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    return Text(
      value.toInt().toString(),
      textAlign: TextAlign.center,
      style: const TextStyle(color: Colors.white54, fontWeight: FontWeight.bold, fontSize: 14),
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    int maxFreq = tailsCount.reduce((a, b) => a > b ? a : b);
    List<int> yLabels = generateYAxisLabels(maxFreq);
    if (!yLabels.contains(value.toInt())) return Container();
    return Text(
      formatNumber(value.toInt()),
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.white54),
      textAlign: TextAlign.center,
    );
  }

  LineChartData mainData() {
    int maxFreq = tailsCount.isEmpty ? 10 : tailsCount.reduce((a, b) => a > b ? a : b);

    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        drawHorizontalLine: true,
        horizontalInterval: trials == 0 ? 9 : (maxFreq / 10).ceil().toDouble(),
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          axisNameWidget: Text('Counts of tails', style: TextStyle(color: Colors.white54)),
          drawBelowEverything: false,
          sideTitles: SideTitles(showTitles: true, interval: 1, getTitlesWidget: bottomTitleWidgets, reservedSize: 30),
        ),
        leftTitles: AxisTitles(
          axisNameWidget: Text('Frequency', style: TextStyle(color: Colors.white54)),
          sideTitles: SideTitles(
            showTitles: true,
            interval: trials == 0 ? 11 : (maxFreq / 10).ceil().toDouble(),
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 42,
          ),
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      ),
      borderData: FlBorderData(show: true, border: Border.all(color: const Color(0xff37434d))),
      minX: 0,
      maxX: 9,
      minY: 0,
      maxY: maxFreq.toDouble(),
      lineBarsData: [
        LineChartBarData(
          spots: List.generate(tailsCount.length, (index) {
            return FlSpot(index.toDouble(), tailsCount[index].toDouble());
          }),
          dotData: FlDotData(
            show: showSpots,
          ),
          isCurved: isCurved,
          gradient: const LinearGradient(colors: gradientColors),
          barWidth: 5,
          isStrokeCapRound: true,
          belowBarData: BarAreaData(
            show: isGradientEnabled,
            gradient: LinearGradient(
              colors: gradientColors.map((color) => color.withValues(alpha: 0.3)).toList(),
            ),
          ),
        ),
      ],
    );
  }

  BarChartData barChartData() {
    int maxFreq = tailsCount.isEmpty ? 10 : tailsCount.reduce((a, b) => a > b ? a : b);

    return BarChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        drawHorizontalLine: true,
        horizontalInterval: trials == 0 ? 9 : (maxFreq / 10).ceil().toDouble(),
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          axisNameWidget: Text('Counts of tails', style: TextStyle(color: Colors.white54)),
          drawBelowEverything: false,
          sideTitles: SideTitles(showTitles: true, interval: 1, getTitlesWidget: bottomTitleWidgets, reservedSize: 30),
        ),
        leftTitles: AxisTitles(
          axisNameWidget: Text('Frequency', style: TextStyle(color: Colors.white54)),
          sideTitles: SideTitles(
            showTitles: true,
            interval: trials == 0 ? 11 : (maxFreq / 10).ceil().toDouble(),
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 42,
          ),
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      ),
      borderData: FlBorderData(show: true, border: Border.all(color: const Color(0xff37434d))),
      // minX: 0,
      // maxX: 9,
      minY: 0,
      maxY: maxFreq.toDouble(),
      barGroups: List.generate(tailsCount.length, (index) {
        return BarChartGroupData(
          x: index,
          barRods: [
            BarChartRodData(
              toY: tailsCount[index].toDouble(),
              color: gradientColors[0],
              width: 16,
              borderRadius: BorderRadius.circular(4),
            ),
          ],
        );
      }),
    );
  }
}
