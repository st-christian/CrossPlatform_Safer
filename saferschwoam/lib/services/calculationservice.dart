//https://idw-online.de/de/news9704#:~:text=Widmark%20definierte%20die%20Blutalkoholkonzentration%20als,das%20K%C3%B6rpergewicht%20p%20in%20Kilogramm.
//https://www.smart-rechner.de/promille/rechner.php


import '../models/consumeddrink.dart';

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
      double totalAlcGram =0;
      for(ConsumedDrink drink in drinks){
        totalAlcGram += calculateAlcGramDrink(drink.size, drink.alcohol);
      } 
    return totalAlcGram;
  }
}