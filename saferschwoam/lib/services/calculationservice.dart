class CalculationService {
  double calculateBAC(double weight, double height, String gender, double alcGrams, int timePassed) {
    double genderConstant = gender == "male" ? 0.68 : 0.55;
    
    double bac = (alcGrams / (weight * genderConstant));
    double resorpDeficit = 0.7;
    //actual alcohol arriving in the blood
    bac = bac * resorpDeficit;
    
    // 0.15 ‰ per hour
    bac = bac - (0.15 * timePassed);
    return bac >= 0 ? bac : 0;
  }
}