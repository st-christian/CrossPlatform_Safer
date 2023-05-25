//https://idw-online.de/de/news9704#:~:text=Widmark%20definierte%20die%20Blutalkoholkonzentration%20als,das%20K%C3%B6rpergewicht%20p%20in%20Kilogramm.
//https://www.smart-rechner.de/promille/rechner.php


import 'package:fl_chart/fl_chart.dart';

import '../models/consumeddrink.dart';
import '../my-globals.dart' as globals;

class CalculationService {
  double calculateBAC(double weight, double height, String gender, double alcGrams, int timePassed) {
    if(alcGrams !=0){
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
     }else{
      return 0;
    }
  }


    double calculateAlcGramDrink(num ml, num percent) {
      double alcGram =0;
      alcGram = ml * (percent/100) * 0.8;
    
    return alcGram;
    }
  

   double totalAlcGramDrink(List<ConsumedDrink> drinks) {
    globals.startTimeHour = drinks.last.consumed.hour;
       globals.sessionDate = drinks.first.consumed.day.toString() + '/' + drinks.first.consumed.month.toString() + '/' + drinks.first.consumed.year.toString() ;
      double totalAlcGram =0;
      for(ConsumedDrink drink in drinks){
        totalAlcGram += calculateAlcGramDrink(drink.size, drink.alcohol);
      } 
      getPlotList( drinks);
    return totalAlcGram;
  }

  List<FlSpot> getPlotList(List<ConsumedDrink> drinks) {
   //   int startTime = drinks.first.consumed.hour;
      List<FlSpot> flListPlot =[];
     /* for(ConsumedDrink drink in drinks){
       
      } */
      double tempValue = 0;
      double value =0;
      double offset = 0;
      bool isDrinking = false;
      List<double> totalAlcGram=[];
        for(int i = 0; i< 24; i++ ){
          totalAlcGram.add(0);}
      // Map<int, double> alcGramMap = {0:0,1:0};
      // double[] alcGramMap = 
      int indexTime = globals.startTimeHour;
      for(ConsumedDrink drink in drinks){
        
        int ind = (drink.consumed.hour-globals.startTimeHour);
          if((drink.consumed.hour-globals.startTimeHour) < 0 ){
            ind = 24+(drink.consumed.hour-globals.startTimeHour);
          }
        totalAlcGram[ind] += calculateAlcGramDrink(drink.size, drink.alcohol);
        

      } 

      for(int i = 0; i< 24; i++ ){       
         value = calculateBAC(globals.weight,globals.height, globals.gender, totalAlcGram[i], 0);
         if(value != 0){   
          offset = 0.01;
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
           if(i == DateTime.now().hour-globals.startTimeHour){
          globals.bacRound = double.parse(value.toStringAsFixed(2));

           }
          flListPlot.add(spot);
          }else{
            spot = FlSpot(i.toDouble(), (value));
          if(i == DateTime.now().hour-globals.startTimeHour){
            globals.bacRound = double.parse(value.toStringAsFixed(2));

            }
            flListPlot.add(spot);
          }
      //  }
        if((value - 0.15)<=0){
tempValue = 0;
        }else{
 tempValue = value - 0.15;
        }
       
       // flListPlot.add(spot);
      }
     globals.flList = flListPlot;
     return flListPlot;
  }
}