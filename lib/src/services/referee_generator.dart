import 'dart:math';
import '../models/referee.dart';
import '../data/names.dart';

class RefereeGenerator {
  static final Random _random = Random();

  /// Generates a single referee with randomized attributes
  static Referee generateReferee() {
    final name = _generateRefereeShuffledFullName();
    final yearHired = _generateYearHired();
    final yearRetired = _generateYearRetired(yearHired);
    
    return Referee(
      name: name,
      yearHired: yearHired,
      yearRetired: yearRetired,
      holdingTendency: _generatePenaltyTendency(),
      passInterferenceTendency: _generatePenaltyTendency(),
      roughingThePasserTendency: _generatePenaltyTendency(),
      falseStartTendency: _generatePenaltyTendency(),
      offensiveHoldingTendency: _generatePenaltyTendency(),
      defensivePassInterferenceTendency: _generatePenaltyTendency(),
      unnecessaryRoughnessTendency: _generatePenaltyTendency(),
      personalFoulTendency: _generatePenaltyTendency(),
      delayOfGameTendency: _generatePenaltyTendency(),
      illegalFormationTendency: _generatePenaltyTendency(),
      facemaskTendency: _generatePenaltyTendency(),
      clippingTendency: _generatePenaltyTendency(),
    );
  }

  /// Generates a pool of referees for the league
  static List<Referee> generateRefereePool({int count = 20}) {
    final referees = <Referee>[];
    final usedNames = <String>{};
    
    while (referees.length < count) {
      final referee = generateReferee();
      // Ensure no duplicate names
      if (!usedNames.contains(referee.name)) {
        referees.add(referee);
        usedNames.add(referee.name);
      }
    }
    
    return referees;
  }

  /// Generates a realistic referee name by combining first and last names from various ethnicities
  static String _generateRefereeShuffledFullName() {
    // Combine all first names from different ethnicities for diversity
    final allFirstNames = [
      ...africanAmericanFirstNames,
      ...caucasianFirstNames,
      ...canadianFirstNames,
      ...internationalFirstNames,
    ];
    
    // Combine all last names from different ethnicities for diversity
    final allLastNames = [
      ...africanAmericanLastNames,
      ...caucasianLastNames,
      ...canadianLastNames,
      ...internationalLastNames,
    ];
    
    final firstName = allFirstNames[_random.nextInt(allFirstNames.length)];
    final lastName = allLastNames[_random.nextInt(allLastNames.length)];
    
    return '$firstName $lastName';
  }

  /// Generates a realistic year when the referee was hired
  /// Most referees start their NFL careers between ages 25-45
  /// Using a range from 1990 to 2020 for variety
  static int _generateYearHired() {
    const minYear = 1990;
    const maxYear = 2020;
    return minYear + _random.nextInt(maxYear - minYear + 1);
  }

  /// Generates a retirement year (if applicable)
  /// About 70% of referees are still active, 30% have retired
  /// Referees typically work 15-30 years before retiring
  static int? _generateYearRetired(int yearHired) {
    // 70% chance the referee is still active
    if (_random.nextDouble() < 0.7) {
      return null; // Still active
    }
    
    // Generate retirement year 15-30 years after being hired
    const minCareerLength = 15;
    const maxCareerLength = 30;
    final careerLength = minCareerLength + _random.nextInt(maxCareerLength - minCareerLength + 1);
    final retirementYear = yearHired + careerLength;
    
    // Don't retire in the future
    return retirementYear > 2024 ? null : retirementYear;
  }

  /// Generates a penalty tendency value between 1-100
  /// Uses a normal distribution centered around 50 for realistic variation
  /// Most referees will be average (40-60), with some being strict or lenient
  static int _generatePenaltyTendency() {
    // Generate a value using normal distribution approximation
    // Sum of 6 random values approximates normal distribution
    double sum = 0;
    for (int i = 0; i < 6; i++) {
      sum += _random.nextDouble();
    }
    
    // Convert to 1-100 scale with mean around 50
    final normalizedValue = (sum / 6.0); // 0.0 to 1.0
    final scaledValue = (normalizedValue * 80) + 10; // 10 to 90 range
    
    // Clamp to 1-100 range and round
    return scaledValue.round().clamp(1, 100);
  }
}
