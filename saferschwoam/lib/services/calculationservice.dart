//https://idw-online.de/de/news9704#:~:text=Widmark%20definierte%20die%20Blutalkoholkonzentration%20als,das%20K%C3%B6rpergewicht%20p%20in%20Kilogramm.
//https://www.smart-rechner.de/promille/rechner.php


import 'package:fl_chart/fl_chart.dart';

import '../models/consumeddrink.dart';
import '../my-globals.dart' as globals;

class CalculationService {
  double calculateBAC(double weight, double height, String gender, double alcGrams, int timePassed) {
    double rFI = 0.31223 - 0.006446 *weight + 0.004466 * height;
    double rMI = 0.31608 - 0.004821 *weight + 0.004632 * height;
    //double genderConstant = gender == "male" ? 0.68 : 0.55;
    double genderConstant = gender == "male" ? rMI : rFI;
    
    double bac = (alcGrams / (weight * genderConstant));
    double resorpDeficit = 0.85; //(10%-30%) 
    //actual alcohol arriving in the blood
     bac = bac * resorpDeficit;
    
    // 0.15 ‰ per hour
    bac = bac - (0.15 * timePassed);
    return bac >= 0 ? bac : 0;
  }

    double calculateAlcGramDrink(num ml, num percent) {
      double alcGram =0;
      alcGram = ml * (percent/100) * 0.8;
    
    return alcGram;
  }

   double totalAlcGramDrink(List<ConsumedDrink> drinks) {
    globals.startTimeHour = drinks.first.consumed.hour;
       globals.sessionDate = drinks.first.consumed.day.toString() + '/' + drinks.first.consumed.month.toString() + '/' + drinks.first.consumed.year.toString() ;
      double totalAlcGram =0;
      for(ConsumedDrink drink in drinks){
        totalAlcGram += calculateAlcGramDrink(drink.size, drink.alcohol);
      } 
    return totalAlcGram;
  }

  List<FlSpot> getPlotList() {
   //   int startTime = drinks.first.consumed.hour;
      List<FlSpot> flListPlot =[];
     /* for(ConsumedDrink drink in drinks){
       
      } */
      double tempValue = 0;
      double value =0;
      double offset = 0;
      bool isDrinking = false;
      for(int i = 0; i< 24; i++ ){

        if(i%3 == 0){    
         value = calculateBAC(globals.weight,globals.height, globals.gender, 45, 0);
          offset = 0.1;
          isDrinking = true;
         value += tempValue;
         } else{
          value = tempValue;
          offset = 0;
          isDrinking = false;
         }
        FlSpot spot;
      /*  if((tempValue+value) <= 0){
           spot = FlSpot(i.toDouble(), 0);
        }else{*/
          if(isDrinking){
          spot = FlSpot(i.toDouble(), (tempValue));
          flListPlot.add(spot);
          spot = FlSpot((i.toDouble()+offset), (value));
          flListPlot.add(spot);
          }else{
            spot = FlSpot(i.toDouble(), (value));
            flListPlot.add(spot);
          }
      //  }

        tempValue = value - 0.15;
       // flListPlot.add(spot);
      }
     globals.flList = flListPlot;
     return flListPlot;
  }
}