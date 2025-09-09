import 'dart:math';
import '../models/player.dart';
import '../models/positions.dart';
import '../models/team_tier.dart';
import '../data/names.dart';
import '../data/schools.dart';
import '../data/locations.dart';

/// Service for generating realistic football players
class PlayerGenerator {
  final Random _random = Random();

  /// Generates a single player with realistic attributes
  /// [currentYear] - Optional current year override (defaults to device's current year)
  /// [tier] - Optional team tier to adjust player quality
  Player generatePlayer({int? currentYear, TeamTier? tier}) {
    // Determine nationality (95% USA, 2% Canada, 3% International)
    final nationality = _generateNationality();
    
    // Determine ethnicity for US players (70% African American, 30% Caucasian)
    final ethnicity = nationality == 'USA' ? _generateEthnicity() : 'other';
    
    // Generate names based on nationality and ethnicity
    final names = _generateNames(nationality, ethnicity);
    
    // Generate birth year and age first (needed for school years)
    final year = currentYear ?? DateTime.now().year;
    final birthYear = year - (21 + _random.nextInt(3)); // Age 21-23 (rookie ages)
    
    // Generate other attributes
    final position = footballPositions[_random.nextInt(footballPositions.length)];
    final height = _generateHeight(position);
    final weight = _generateWeight(position);
    final college = _generateCollegeInfo(year);
    final birthInfo = _generateBirthInfo(nationality, birthYear, year);

    // Generate ratings
    final positionRating1 = _generateRating(tier: tier);
    final positionRating2 = _generateRating(tier: tier);
    final positionRating3 = _generateRating(tier: tier);
    final overallRating = _calculateOverallRating(positionRating1, positionRating2, positionRating3);
    final potentialRating = _generateRating(tier: tier);
    final durabilityRating = _generateRating(tier: tier);
    final footballIqRating = _generateFootballIq(position, tier: tier);
    final fanPopularity = 0; // New players start with no fan popularity
    final morale = _generateMorale(); // Generate high morale for new players

    // Generate draft information
    final draftInfo = _generateDraftInfo(year, overallRating);

    return Player(
      fullName: names['full']!,
      commonName: names['common']!,
      shortName: names['short']!,
      fanNickname: null,
      primaryPosition: position,
      heightInches: height,
      weightLbs: weight,
      college: college,
      birthInfo: birthInfo,
      draftYear: draftInfo['year'],
      draftRound: draftInfo['round'],
      draftPick: draftInfo['pick'],
      draftInfo: draftInfo['info'],
      overallRating: overallRating,
      potentialRating: potentialRating,
      durabilityRating: durabilityRating,
      footballIqRating: footballIqRating,
      fanPopularity: fanPopularity,
      morale: morale,
      positionRating1: positionRating1,
      positionRating2: positionRating2,
      positionRating3: positionRating3,
    );
  }

  /// Generates a veteran player with realistic attributes for any age 19-40
  /// [age] - Optional specific age (if not provided, generates random age 19-40)
  /// [currentYear] - Optional current year override (defaults to device's current year)
  Player generateVeteranPlayer({int? age, int? currentYear}) {
    // Determine nationality (95% USA, 2% Canada, 3% International)
    final nationality = _generateNationality();
    
    // Determine ethnicity for US players (70% African American, 30% Caucasian)
    final ethnicity = nationality == 'USA' ? _generateEthnicity() : 'other';
    
    // Generate names based on nationality and ethnicity
    final names = _generateNames(nationality, ethnicity);
    
    // Generate age and birth year
    final year = currentYear ?? DateTime.now().year;
    final playerAge = age ?? (19 + _random.nextInt(22)); // Age 19-40 if not specified
    final birthYear = year - playerAge;
    
    // Generate other attributes
    final position = footballPositions[_random.nextInt(footballPositions.length)];
    final height = _generateHeight(position);
    final weight = _generateWeight(position);
    final college = _generateVeteranCollegeInfo(playerAge, year);
    final birthInfo = _generateBirthInfo(nationality, birthYear, year);

    // Generate ratings
    final positionRating1 = _generateRating();
    final positionRating2 = _generateRating();
    final positionRating3 = _generateRating();
    final overallRating = _calculateOverallRating(positionRating1, positionRating2, positionRating3);
    final potentialRating = _generateRating();
    final durabilityRating = _generateRating();
    final footballIqRating = _generateFootballIq(position);
    final fanPopularity = 0; // New players start with no fan popularity
    final morale = _generateMorale(); // Generate high morale for veteran players

    // Generate draft information for veteran based on their age
    final draftInfo = _generateVeteranDraftInfo(year, playerAge, overallRating);

    return Player(
      fullName: names['full']!,
      commonName: names['common']!,
      shortName: names['short']!,
      fanNickname: null,
      primaryPosition: position,
      heightInches: height,
      weightLbs: weight,
      college: college,
      birthInfo: birthInfo,
      draftYear: draftInfo['year'],
      draftRound: draftInfo['round'],
      draftPick: draftInfo['pick'],
      draftInfo: draftInfo['info'],
      overallRating: overallRating,
      potentialRating: potentialRating,
      durabilityRating: durabilityRating,
      footballIqRating: footballIqRating,
      fanPopularity: fanPopularity,
      morale: morale,
      positionRating1: positionRating1,
      positionRating2: positionRating2,
      positionRating3: positionRating3,
    );
  }

  /// Determines player nationality based on real NFL demographics
  String _generateNationality() {
    final roll = _random.nextInt(100);
    if (roll < 95) return 'USA';
    if (roll < 97) return 'Canada';
    return 'International';
  }

  /// Determines ethnicity for US players (70% African American, 30% Caucasian)
  String _generateEthnicity() {
    return _random.nextInt(100) < 70 ? 'africanAmerican' : 'caucasian';
  }

  /// Generates names based on nationality and ethnicity
  Map<String, String> _generateNames(String nationality, String ethnicity) {
    List<String> firstNames;
    List<String> lastNames;

    if (nationality == 'USA') {
      if (ethnicity == 'africanAmerican') {
        firstNames = africanAmericanFirstNames;
        lastNames = africanAmericanLastNames;
      } else {
        firstNames = caucasianFirstNames;
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
    
    // Generate middle name occasionally
    final hasMiddleName = _random.nextBool();
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

  /// Generates realistic height for football players based on position
  int _generateHeight(String position) {
    switch (position) {
      case 'OL': // Offensive Line - tallest players
        return 75 + _random.nextInt(6); // 6'3" to 6'8"
      case 'TE': // Tight End - tall and athletic
        return 75 + _random.nextInt(5); // 6'3" to 6'7"
      case 'DL': // Defensive Line - tall and powerful
        return 74 + _random.nextInt(7); // 6'2" to 6'8"
      case 'QB': // Quarterback - above average height
        return 72 + _random.nextInt(7); // 6'0" to 6'6"
      case 'LB': // Linebacker - athletic height
        return 72 + _random.nextInt(6); // 6'0" to 6'5"
      case 'WR': // Wide Receiver - varied heights
        return 70 + _random.nextInt(8); // 5'10" to 6'5"
      case 'S': // Safety - medium height
        return 70 + _random.nextInt(7); // 5'10" to 6'4"
      case 'K': // Kicker - average height
        return 70 + _random.nextInt(7); // 5'10" to 6'4"
      case 'CB': // Cornerback - shorter and agile
        return 69 + _random.nextInt(6); // 5'9" to 6'2"
      case 'RB': // Running Back - compact and low
        return 68 + _random.nextInt(7); // 5'8" to 6'2"
      default:
        return 70 + _random.nextInt(8); // Default fallback
    }
  }

  /// Generates realistic weight based on position using normal distribution
  int _generateWeight(String position) {
    double mean;
    double stdDev;
    int minWeight;
    int maxWeight;
    
    switch (position) {
      case 'OL': // Offensive Line - heaviest players
        mean = 315.0;
        stdDev = 15.0;
        minWeight = 280;
        maxWeight = 360;
        break;
      case 'DL': // Defensive Line - very heavy
        mean = 290.0;
        stdDev = 20.0;
        minWeight = 220;
        maxWeight = 350;
        break;
      case 'TE': // Tight End - large and athletic
        mean = 255.0;
        stdDev = 10.0;
        minWeight = 230;
        maxWeight = 280;
        break;
      case 'LB': // Linebacker - medium-heavy
        mean = 245.0;
        stdDev = 15.0;
        minWeight = 220;
        maxWeight = 270;
        break;
      case 'QB': // Quarterback - medium build
        mean = 215.0;
        stdDev = 10.0;
        minWeight = 185;
        maxWeight = 255;
        break;
      case 'RB': // Running Back - compact and powerful
        mean = 210.0;
        stdDev = 10.0;
        minWeight = 180;
        maxWeight = 240;
        break;
      case 'S': // Safety - medium build
        mean = 205.0;
        stdDev = 10.0;
        minWeight = 175;
        maxWeight = 235;
        break;
      case 'WR': // Wide Receiver - lean and fast
        mean = 200.0;
        stdDev = 10.0;
        minWeight = 170;
        maxWeight = 230;
        break;
      case 'CB': // Cornerback - lightest defenders
        mean = 195.0;
        stdDev = 10.0;
        minWeight = 165;
        maxWeight = 230;
        break;
      case 'K': // Kicker - lighter build
        mean = 185.0;
        stdDev = 10.0;
        minWeight = 160;
        maxWeight = 220;
        break;
      default:
        mean = 210.0;
        stdDev = 15.0;
        minWeight = 160;
        maxWeight = 280;
    }
    
    // Generate normal distribution using Box-Muller transform
    double u1 = _random.nextDouble();
    double u2 = _random.nextDouble();
    
    double z0 = sqrt(-2.0 * log(u1)) * cos(2.0 * pi * u2);
    double normalValue = mean + (z0 * stdDev);
    
    // Clamp to position-specific range and round to integer
    return normalValue.clamp(minWeight, maxWeight).round();
  }

  /// Generates college information for 2025 draft rookies
  String _generateCollegeInfo(int currentYear) {
    // All players are draft rookies, so they graduate in the current year
    final collegeGradYear = currentYear;
    
    // Select random college
    final college = colleges[_random.nextInt(colleges.length)];
    
    return '$college ($collegeGradYear)';
  }

  /// Generates college information for veteran players based on their age
  String _generateVeteranCollegeInfo(int playerAge, int currentYear) {
    // Calculate college graduation year based on player's age
    // Most players graduate college between ages 21-23
    final collegeGradAge = 21 + _random.nextInt(3); // 21, 22, or 23
    
    // If player is younger than typical college graduation age, they might be a young talent
    // who graduated early or is still in college
    int collegeGradYear;
    if (playerAge < collegeGradAge) {
      // Young player - graduate this year or next year
      collegeGradYear = currentYear + _random.nextInt(2);
    } else {
      // Normal case - graduated when they were 21-23
      collegeGradYear = currentYear - (playerAge - collegeGradAge);
    }
    
    // Select random college
    final college = colleges[_random.nextInt(colleges.length)];
    
    return '$college ($collegeGradYear)';
  }

  /// Generates birth information with location and age
  String _generateBirthInfo(String nationality, int birthYear, int currentYear) {
    final age = currentYear - birthYear;
    
    final month = _random.nextInt(12) + 1;
    final day = _random.nextInt(28) + 1; // Avoid date issues
    
    String location;
    String country;
    
    if (nationality == 'USA') {
      location = usCities[_random.nextInt(usCities.length)];
      country = 'USA';
    } else if (nationality == 'Canada') {
      location = canadianCities[_random.nextInt(canadianCities.length)];
      country = 'Canada';
    } else {
      location = internationalCities[_random.nextInt(internationalCities.length)];
      // Extract country from location string
      country = location.split(', ').last;
    }
    
    final flag = countryFlags[country] ?? '🌍';
    final formattedDate = '${month.toString().padLeft(2, '0')}/${day.toString().padLeft(2, '0')}/$birthYear';
    
    return '$formattedDate ($age yrs) - $location $flag';
  }

  /// Generates a rating value using bell curve distribution
  /// Uses Box-Muller transform to approximate normal distribution
  /// [tier] - Optional team tier to adjust rating distribution
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
    
    // Clamp to valid range and round to nearest integer
    return normalValue.clamp(55, 110).round();
  }

  /// Generates Football IQ with potential boost for QBs and Safeties
  /// [tier] - Optional team tier to adjust rating distribution
  int _generateFootballIq(String position, {TeamTier? tier}) {
    final baseRating = _generateRating(tier: tier);
    
    // QBs and Safeties get a slight boost to Football IQ
    if (hasFootballIqBoost(position)) {
      final boost = _random.nextInt(6); // 0-5 boost
      return (baseRating + boost).clamp(55, 110);
    }
    
    return baseRating;
  }

  /// Generates morale rating with high values (80-100, biased toward 100)
  int _generateMorale() {
    // Generate two random numbers between 80-100 and take the higher one
    // This biases the distribution toward higher values
    final morale1 = 80 + _random.nextInt(21); // 80-100
    final morale2 = 80 + _random.nextInt(21); // 80-100
    return morale1 > morale2 ? morale1 : morale2;
  }

  /// Calculates overall rating as average of three position-specific ratings
  int _calculateOverallRating(int rating1, int rating2, int rating3) {
    return ((rating1 + rating2 + rating3) / 3).round();
  }

  /// Generates draft information for rookie players
  Map<String, dynamic> _generateDraftInfo(int currentYear, int overallRating) {
    // Undrafted chance based on rating - elite players almost always get drafted
    int undraftedChance;
    if (overallRating >= 85) {
      undraftedChance = 1; // 1% chance for elite players
    } else if (overallRating >= 75) {
      undraftedChance = 5; // 5% chance for good players
    } else if (overallRating >= 65) {
      undraftedChance = 15; // 15% chance for average players
    } else {
      undraftedChance = 30; // 30% chance for lower-rated players
    }
    final isUndrafted = _random.nextInt(100) < undraftedChance;

    if (isUndrafted) {
      return {
        'year': currentYear,
        'round': null,
        'pick': null,
        'info': 'Undrafted Free Agent ($currentYear)',
      };
    }

    // Generate draft position based on rating
    int round;
    int pick;

    // Higher ratings get drafted earlier
    if (overallRating >= 85) {
      // Top players: Rounds 1-2
      round = 1 + _random.nextInt(2);
    } else if (overallRating >= 75) {
      // Good players: Rounds 2-4
      round = 2 + _random.nextInt(3);
    } else if (overallRating >= 65) {
      // Average players: Rounds 4-6
      round = 4 + _random.nextInt(3);
    } else {
      // Lower rated players: Rounds 6-7
      round = 6 + _random.nextInt(2);
    }

    // Generate pick within round (1-32 for most rounds, 1-35 for round 7)
    pick = 1 + _random.nextInt(round == 7 ? 35 : 32);

    // Calculate overall pick number
    int overallPick;
    switch (round) {
      case 1:
        overallPick = pick;
        break;
      case 2:
        overallPick = 32 + pick;
        break;
      case 3:
        overallPick = 64 + pick;
        break;
      case 4:
        overallPick = 96 + pick;
        break;
      case 5:
        overallPick = 128 + pick;
        break;
      case 6:
        overallPick = 160 + pick;
        break;
      case 7:
        overallPick = 192 + pick;
        break;
      default:
        overallPick = pick;
    }

    return {
      'year': currentYear,
      'round': round,
      'pick': pick,
      'info': '$currentYear Draft - Round $round, Pick $pick (#$overallPick overall)',
    };
  }

  /// Generates draft information for veteran players based on their age
  Map<String, dynamic> _generateVeteranDraftInfo(int currentYear, int playerAge, int overallRating) {
    // Calculate draft year based on age (most players drafted at 21-23)
    final draftAge = 21 + _random.nextInt(3); // 21, 22, or 23
    final draftYear = currentYear - (playerAge - draftAge);

    // Undrafted chance based on rating and age - elite players almost always get drafted
    int undraftedChance;
    if (overallRating >= 85) {
      undraftedChance = playerAge > 30 ? 3 : 2; // 2-3% chance for elite players
    } else if (overallRating >= 75) {
      undraftedChance = playerAge > 30 ? 8 : 6; // 6-8% chance for good players
    } else if (overallRating >= 65) {
      undraftedChance = playerAge > 30 ? 20 : 15; // 15-20% chance for average players
    } else {
      undraftedChance = playerAge > 30 ? 40 : 30; // 30-40% chance for lower-rated players
    }
    final isUndrafted = _random.nextInt(100) < undraftedChance;

    if (isUndrafted) {
      return {
        'year': draftYear,
        'round': null,
        'pick': null,
        'info': 'Undrafted Free Agent ($draftYear)',
      };
    }

    // Generate draft position based on rating and age
    int round;
    int pick;

    // Adjust rating based on age (older veterans might have been drafted lower)
    int adjustedRating = overallRating;
    if (playerAge > 28) {
      adjustedRating = (overallRating * 0.9).round(); // Slightly lower for older players
    }

    if (adjustedRating >= 85) {
      round = 1 + _random.nextInt(2);
    } else if (adjustedRating >= 75) {
      round = 2 + _random.nextInt(3);
    } else if (adjustedRating >= 65) {
      round = 4 + _random.nextInt(3);
    } else {
      round = 6 + _random.nextInt(2);
    }

    pick = 1 + _random.nextInt(round == 7 ? 35 : 32);

    // Calculate overall pick number
    int overallPick;
    switch (round) {
      case 1:
        overallPick = pick;
        break;
      case 2:
        overallPick = 32 + pick;
        break;
      case 3:
        overallPick = 64 + pick;
        break;
      case 4:
        overallPick = 96 + pick;
        break;
      case 5:
        overallPick = 128 + pick;
        break;
      case 6:
        overallPick = 160 + pick;
        break;
      case 7:
        overallPick = 192 + pick;
        break;
      default:
        overallPick = pick;
    }

    return {
      'year': draftYear,
      'round': round,
      'pick': pick,
      'info': '$draftYear Draft - Round $round, Pick $pick (#$overallPick overall)',
    };
  }
}
