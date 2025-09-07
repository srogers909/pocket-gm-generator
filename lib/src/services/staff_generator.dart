import 'dart:math';
import '../models/staff.dart';
import '../models/team_tier.dart';
import '../data/names.dart';

/// Service for generating realistic team staff members
class StaffGenerator {
  final Random _random = Random();

  /// Generates a complete staff for a team
  TeamStaff generateTeamStaff(TeamTier tier) {
    return TeamStaff(
      headCoach: generateHeadCoach(tier: tier),
      offensiveCoordinator: generateOffensiveCoordinator(tier: tier),
      defensiveCoordinator: generateDefensiveCoordinator(tier: tier),
      teamDoctor: generateTeamDoctor(tier: tier),
      headScout: generateHeadScout(tier: tier),
    );
  }

  /// Generates a Head Coach with realistic attributes
  HeadCoach generateHeadCoach({TeamTier? tier}) {
    final names = _generateNames();
    final age = _generateAge();
    final experience = _generateExperience(age);
    
    final leadership = _generateRating(tier: tier);
    final gameManagement = _generateRating(tier: tier);
    final playerDevelopment = _generateRating(tier: tier);
    final schemeKnowledge = _generateRating(tier: tier);
    
    final overallRating = _calculateOverallRating([
      leadership,
      gameManagement,
      playerDevelopment,
      schemeKnowledge,
    ]);

    return HeadCoach(
      fullName: names['full']!,
      commonName: names['common']!,
      shortName: names['short']!,
      age: age,
      yearsExperience: experience,
      overallRating: overallRating,
      morale: _generateMorale(),
      leadership: leadership,
      gameManagement: gameManagement,
      playerDevelopment: playerDevelopment,
      schemeKnowledge: schemeKnowledge,
    );
  }

  /// Generates an Offensive Coordinator with realistic attributes
  OffensiveCoordinator generateOffensiveCoordinator({TeamTier? tier}) {
    final names = _generateNames();
    final age = _generateAge();
    final experience = _generateExperience(age);
    
    final playCalling = _generateRating(tier: tier);
    final passingOffense = _generateRating(tier: tier);
    final rushingOffense = _generateRating(tier: tier);
    final offensiveLineExpertise = _generateRating(tier: tier);
    
    final overallRating = _calculateOverallRating([
      playCalling,
      passingOffense,
      rushingOffense,
      offensiveLineExpertise,
    ]);

    return OffensiveCoordinator(
      fullName: names['full']!,
      commonName: names['common']!,
      shortName: names['short']!,
      age: age,
      yearsExperience: experience,
      overallRating: overallRating,
      morale: _generateMorale(),
      playCalling: playCalling,
      passingOffense: passingOffense,
      rushingOffense: rushingOffense,
      offensiveLineExpertise: offensiveLineExpertise,
    );
  }

  /// Generates a Defensive Coordinator with realistic attributes
  DefensiveCoordinator generateDefensiveCoordinator({TeamTier? tier}) {
    final names = _generateNames();
    final age = _generateAge();
    final experience = _generateExperience(age);
    
    final defensivePlayCalling = _generateRating(tier: tier);
    final passingDefense = _generateRating(tier: tier);
    final rushingDefense = _generateRating(tier: tier);
    final defensiveLineExpertise = _generateRating(tier: tier);
    
    final overallRating = _calculateOverallRating([
      defensivePlayCalling,
      passingDefense,
      rushingDefense,
      defensiveLineExpertise,
    ]);

    return DefensiveCoordinator(
      fullName: names['full']!,
      commonName: names['common']!,
      shortName: names['short']!,
      age: age,
      yearsExperience: experience,
      overallRating: overallRating,
      morale: _generateMorale(),
      defensivePlayCalling: defensivePlayCalling,
      passingDefense: passingDefense,
      rushingDefense: rushingDefense,
      defensiveLineExpertise: defensiveLineExpertise,
    );
  }

  /// Generates a Team Doctor with realistic attributes
  TeamDoctor generateTeamDoctor({TeamTier? tier}) {
    final names = _generateNames();
    final age = _generateAge(minAge: 35, maxAge: 65); // Doctors typically older
    final experience = _generateExperience(age, minExperience: 5);
    
    final injuryPrevention = _generateRating(tier: tier);
    final rehabilitationSpeed = _generateRating(tier: tier);
    final misdiagnosisPrevention = _generateRating(tier: tier);
    final staminaRecovery = _generateRating(tier: tier);
    
    final overallRating = _calculateOverallRating([
      injuryPrevention,
      rehabilitationSpeed,
      misdiagnosisPrevention,
      staminaRecovery,
    ]);

    return TeamDoctor(
      fullName: names['full']!,
      commonName: names['common']!,
      shortName: names['short']!,
      age: age,
      yearsExperience: experience,
      overallRating: overallRating,
      morale: _generateMorale(),
      injuryPrevention: injuryPrevention,
      rehabilitationSpeed: rehabilitationSpeed,
      misdiagnosisPrevention: misdiagnosisPrevention,
      staminaRecovery: staminaRecovery,
    );
  }

  /// Generates a Head Scout with realistic attributes
  HeadScout generateHeadScout({TeamTier? tier}) {
    final names = _generateNames();
    final age = _generateAge();
    final experience = _generateExperience(age);
    
    final collegeScouting = _generateRating(tier: tier);
    final proScouting = _generateRating(tier: tier);
    final potentialIdentification = _generateRating(tier: tier);
    final tradeEvaluation = _generateRating(tier: tier);
    
    final overallRating = _calculateOverallRating([
      collegeScouting,
      proScouting,
      potentialIdentification,
      tradeEvaluation,
    ]);

    return HeadScout(
      fullName: names['full']!,
      commonName: names['common']!,
      shortName: names['short']!,
      age: age,
      yearsExperience: experience,
      overallRating: overallRating,
      morale: _generateMorale(),
      collegeScouting: collegeScouting,
      proScouting: proScouting,
      potentialIdentification: potentialIdentification,
      tradeEvaluation: tradeEvaluation,
    );
  }

  /// Generates names for staff members (uses similar logic to player generation)
  Map<String, String> _generateNames() {
    // Staff members are predominantly male and from USA/Canada
    // 85% male, 15% female distribution
    final isMale = _random.nextInt(100) < 85;
    
    // 90% USA, 8% Canada, 2% International
    String nationality;
    final nationalityRoll = _random.nextInt(100);
    if (nationalityRoll < 90) {
      nationality = 'USA';
    } else if (nationalityRoll < 98) {
      nationality = 'Canada';
    } else {
      nationality = 'International';
    }

    List<String> firstNames;
    List<String> lastNames;

    if (nationality == 'USA') {
      // Mix of ethnicities for US staff
      final isAfricanAmerican = _random.nextInt(100) < 30; // Lower percentage than players
      if (isAfricanAmerican) {
        firstNames = isMale ? africanAmericanFirstNames : africanAmericanFirstNames;
        lastNames = africanAmericanLastNames;
      } else {
        firstNames = isMale ? caucasianFirstNames : caucasianFirstNames;
        lastNames = caucasianLastNames;
      }
    } else if (nationality == 'Canada') {
      firstNames = canadianFirstNames;
      lastNames = canadianLastNames;
    } else {
      firstNames = internationalFirstNames;
      lastNames = internationalLastNames;
    }

    final firstName = firstNames[_random.nextInt(firstNames.length)];
    final lastName = lastNames[_random.nextInt(lastNames.length)];
    
    // Generate middle name occasionally (30% chance)
    final hasMiddleName = _random.nextInt(100) < 30;
    final middleName = hasMiddleName ? firstNames[_random.nextInt(firstNames.length)] : '';
    
    final fullName = hasMiddleName ? '$firstName $middleName $lastName' : '$firstName $lastName';
    final commonName = '$firstName $lastName';
    final shortName = firstName;

    return {
      'full': fullName,
      'common': commonName,
      'short': shortName,
    };
  }

  /// Generates realistic age for staff members
  int _generateAge({int minAge = 30, int maxAge = 70}) {
    // Most staff are between 30-70 years old
    // Use weighted distribution favoring middle ages (40-55)
    final weights = <int>[];
    for (int age = minAge; age <= maxAge; age++) {
      int weight;
      if (age >= 40 && age <= 55) {
        weight = 3; // Higher weight for prime coaching years
      } else if (age >= 35 && age <= 60) {
        weight = 2; // Moderate weight
      } else {
        weight = 1; // Lower weight for very young or old
      }
      weights.add(weight);
    }
    
    final totalWeight = weights.fold(0, (sum, weight) => sum + weight);
    final randomWeight = _random.nextInt(totalWeight);
    
    int currentWeight = 0;
    for (int i = 0; i < weights.length; i++) {
      currentWeight += weights[i];
      if (randomWeight < currentWeight) {
        return minAge + i;
      }
    }
    
    return minAge + _random.nextInt(maxAge - minAge + 1); // Fallback
  }

  /// Generates years of experience based on age
  int _generateExperience(int age, {int minExperience = 0}) {
    // Staff typically start their careers around age 25-30
    final careerStartAge = 25 + _random.nextInt(6); // 25-30
    final maxExperience = max(0, age - careerStartAge);
    
    // Most staff have between 60-90% of their maximum possible experience
    final experienceRatio = 0.6 + (_random.nextDouble() * 0.3); // 60-90%
    final experience = (maxExperience * experienceRatio).round();
    
    return max(minExperience, experience);
  }

  /// Generates a rating value using bell curve distribution with tier adjustment
  int _generateRating({TeamTier? tier}) {
    // Use tier-specific mean and standard deviation, or default to average
    final teamTier = tier ?? TeamTier.average;
    final mean = teamTier.meanRating;
    final stdDev = teamTier.standardDeviation;
    
    double u1 = _random.nextDouble();
    double u2 = _random.nextDouble();
    
    // Box-Muller transform for normal distribution
    double z0 = sqrt(-2.0 * log(u1)) * cos(2.0 * pi * u2);
    
    // Scale and shift using tier-specific parameters
    double normalValue = mean + (z0 * stdDev);
    
    // Clamp to valid range and round up to integer
    return normalValue.clamp(55, 110).ceil();
  }

  /// Generates morale rating with high values (80-100, biased toward 100)
  int _generateMorale() {
    // Generate two random numbers between 80-100 and take the higher one
    // This biases the distribution toward higher values
    final morale1 = 80 + _random.nextInt(21); // 80-100
    final morale2 = 80 + _random.nextInt(21); // 80-100
    return morale1 > morale2 ? morale1 : morale2;
  }

  /// Calculates overall rating as average of all attribute ratings
  int _calculateOverallRating(List<int> ratings) {
    if (ratings.isEmpty) return 70;
    
    final sum = ratings.fold(0, (total, rating) => total + rating);
    return (sum / ratings.length).ceil();
  }
}
