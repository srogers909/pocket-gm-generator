import 'dart:math';
import '../models/player.dart';
import '../models/positions.dart';
import '../data/names.dart';
import '../data/schools.dart';
import '../data/locations.dart';

/// Service for generating realistic football players
class PlayerGenerator {
  final Random _random = Random();

  /// Generates a single player with realistic attributes
  /// [currentYear] - Optional current year override (defaults to device's current year)
  Player generatePlayer({int? currentYear}) {
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
    final height = _generateHeight();
    final weight = _generateWeight(height);
    final college = _generateCollegeInfo(year);
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
      overallRating: overallRating,
      potentialRating: potentialRating,
      durabilityRating: durabilityRating,
      footballIqRating: footballIqRating,
      fanPopularity: fanPopularity,
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
    final height = _generateHeight();
    final weight = _generateWeight(height);
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
      overallRating: overallRating,
      potentialRating: potentialRating,
      durabilityRating: durabilityRating,
      footballIqRating: footballIqRating,
      fanPopularity: fanPopularity,
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

  /// Generates realistic height for football players (66-78 inches)
  int _generateHeight() {
    return 66 + _random.nextInt(13); // 5'6" to 6'6"
  }

  /// Generates realistic weight based on height and position
  int _generateWeight(int height) {
    final baseWeight = 140 + (height - 66) * 8; // Base weight calculation
    final variation = _random.nextInt(40) - 20; // ±20 lbs variation
    return baseWeight + variation;
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

  /// Generates a rating value between 55-110
  int _generateRating() {
    return 55 + _random.nextInt(56); // 55-110 range
  }

  /// Generates Football IQ with potential boost for QBs and Safeties
  int _generateFootballIq(String position) {
    final baseRating = _generateRating();
    
    // QBs and Safeties get a slight boost to Football IQ
    if (hasFootballIqBoost(position)) {
      final boost = _random.nextInt(6); // 0-5 boost
      return (baseRating + boost).clamp(55, 110);
    }
    
    return baseRating;
  }

  /// Calculates overall rating as average of three position-specific ratings
  int _calculateOverallRating(int rating1, int rating2, int rating3) {
    return ((rating1 + rating2 + rating3) / 3).round();
  }
}
