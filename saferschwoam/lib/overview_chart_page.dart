//import 'package:fl_chart_app/presentation/resources/app_resources.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:namer_app/services/calculationservice.dart';
import 'package:namer_app/services/history_service.dart';
import 'package:namer_app/widgets/add_drink_card.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'my-globals.dart' as globals;

import 'models/consumeddrink.dart';

class LineChartSample2 extends StatefulWidget {
  const LineChartSample2({super.key});

  @override
  State<LineChartSample2> createState() => _LineChartSample2State();
}

class _LineChartSample2State extends State<LineChartSample2> {
    final HistoryService historyService = HistoryService();
    final CalculationService calculationService = CalculationService();
           double bac = 0;  
       double bacRound = 0;
  List<Color> gradientColors = [
    const Color.fromARGB(255, 0, 75, 112),
     Color.fromARGB(255, 0, 255, 213),
  ];

  bool showAvg = false;
     List<Map<String, dynamic>> _listData = [
    {'name': 'Bier', 'icon': Icons.local_drink, 'size': 500, 'alcohol' : 5},
   ];

  List<bool> isSelected = [true, false, false];

  @override
  Widget build(BuildContext context) {
      final theme = Theme.of(context);

      
    return Scaffold( 
       body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Column(
              children: <Widget>[    
                SizedBox(height: 30,),
                Text('Schwoamo Meter ',
                          style: TextStyle(fontSize: 28,fontWeight:FontWeight.bold,  color: theme.primaryColor),),  
                           Divider(thickness: 1,),
                           StreamBuilder<List<ConsumedDrink>>(
  stream: historyService.getHistory(),
  builder: (context, snapshot) {
    if (snapshot.hasError) {
      print(snapshot.error);
      return Center(
        child: Text('Error fetching data'),
      );
    }

    if (!snapshot.hasData) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
       bac = calculationService.calculateBAC(
        80,
        180,
        "male",
        calculationService.totalAlcGramDrink(snapshot.data!),
        0,
      );
       //bacRound = double.parse(bac.toStringAsFixed(2));
       globals.bacRound =double.parse(bac.toStringAsFixed(2));
      print("BAC: $bac");
      return Column(
        children: [
         SizedBox(
                        height: 230,
                         child: SfRadialGauge(
                         axes: <RadialAxis>[
                               RadialAxis(minimum: 0,maximum: 3.01,
                                       ranges: <GaugeRange>[
                                           GaugeRange(startValue: 0,endValue: 0.5,color: theme.primaryColorLight,startWidth: 10,endWidth:10),
                                           GaugeRange(startValue: 0.5,endValue: 2,color: theme.primaryColorDark,startWidth: 10,endWidth: 10),
                                           GaugeRange(startValue: 2,endValue: 4,color: theme.primaryColor, startWidth: 10,endWidth: 10)],
                                           pointers: <GaugePointer>[NeedlePointer(value:globals.bacRound)],
                                      annotations: <GaugeAnnotation>[
                                          GaugeAnnotation(widget: Container(child:
                                          Text(globals.bacRound.toString() +' ‰ ',style: TextStyle(fontSize: 22,fontWeight:FontWeight.bold))),
                                          angle: 90,positionFactor: 0.5)]
                                  )]
                                       ),
                       ),
          // Render the drink cards or other components here
        ],
      );
    }
  },
),
                       Divider(thickness: 1,),
                     
                  Text('Schwoam Charts ',
                          style: TextStyle(fontSize: 28,fontWeight:FontWeight.bold,  color: theme.primaryColor),),
                            Text('Date: ' + globals.sessionDate.toString(),
                          style: TextStyle(fontSize: 12,fontWeight:FontWeight.bold,  color: theme.primaryColor),), 
                           
            AspectRatio(
              aspectRatio: 1.70,
              child: Padding(
                padding: const EdgeInsets.only(
                  right: 18,
                  left: 12,
                  top: 24,
                  bottom: 12,
                ),
                
                child: LineChart(
                  mainData(),
                ),               
              ),
              
            ),
            //    Divider(thickness: 1,),
            //     Text('Last Drink ',
            //               style: TextStyle(fontSize: 28,fontWeight:FontWeight.bold,  color: theme.primaryColor),),
            //  AddDrinkCard(drinkName: _listData[0]["name"], alcoholContent: _listData[0]["alcohol"], size: _listData[0]["size"])
          ],
        ),
       
          ),
        ),
       ),
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 12,
    );
    Widget text;
    switch (value.toInt()) {
       case 0:
       String time = globals.startTimeHour.toString();
       time = time + ':00';
        text =  Text(time, style: style);
        break;
      case 6:
      if((globals.startTimeHour+6) > 24){
       double tim=  (globals.startTimeHour+6) - 24;
       String time = tim.toString();
       time = time + ':00';
        text =  Text(time, style: style);
      }else{
 String time = (globals.startTimeHour+6).toString();
        time = time + ':00';
        text =  Text(time, style: style);
      }
      
        break;
      case 12:
      if((globals.startTimeHour+12) > 24){
       int tim=  (globals.startTimeHour+12) - 24;
       String time = tim.toString();
       time = time + ':00';
        text =  Text(time, style: style);
      }else{
String time = (globals.startTimeHour+12).toString();
 time = time + ':00';
        text =  Text(time, style: style);
      }
       
        break;
      case 18:
      if((globals.startTimeHour+18) > 24){
       int tim=  (globals.startTimeHour+18) - 24;
       String time = tim.toString();
       time = time + ':00';
         text =  Text(time, style: style);
      }else{
 String time = (globals.startTimeHour+18).toString();
  time = time + ':00';
        text =  Text(time, style: style);
      }
      
        break;
        case 23:
        if((globals.startTimeHour+23) > 24){
       int tim=  (globals.startTimeHour+23) - 24;
       String time = tim.toString();
       time = time + ':00';
        text =  Text(time, style: style);
      }else{
         String time = (globals.startTimeHour+23).toString();
          time = time + ':00';
          text =  Text(time, style: style);
      }
       
        break;
      default:
        text = const Text('', style: style);
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text,
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 15,
    );
    String text;
    switch (value.toInt()) {
      case 0:
        text = '0 ‰';
        break;     
      case 1:
        text = '1 ‰';
        break;
       case 2:
        text = '2 ‰';
        break;
      case 3:
        text = '3 ‰';
        break;
      default:
        return Container();
    }

    return Text(text, style: style, textAlign: TextAlign.left);
  }

  LineChartData mainData() {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        horizontalInterval: 1,
        verticalInterval: 1,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: Color.fromARGB(255, 202, 202, 202),
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: Color.fromARGB(255, 202, 202, 202),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 1,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 42,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: const Color(0xff37434d)),
      ),
      minX: 0,
      maxX: 23,
      minY: 0,
      maxY: 3,
      lineBarsData: [
        LineChartBarData(spots: calculationService.getPlotList()
        /*  spots: const [
            FlSpot(0, 0),
            FlSpot(2, 0.5),
            FlSpot(5, 0),
            FlSpot(6, 1.5),
            FlSpot(10, 1.2),
            FlSpot(12, 2),
            FlSpot(14, 2.5),
            FlSpot(23, 0),
          ]*/,
          isCurved: false,
          gradient: LinearGradient(
            colors: gradientColors,
          ),
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: gradientColors
                  .map((color) => color.withOpacity(0.3))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }

}