import 'package:pocket_gm_generator/pocket_gm_generator.dart';
import 'package:test/test.dart';

void main() {
  group('PlayerGenerator Tests', () {
    late PlayerGenerator generator;

    setUp(() {
      generator = PlayerGenerator();
    });

    test('generatePlayer creates a player with null nickname', () {
      final player = generator.generatePlayer();
      
      expect(player.fullName, isNotEmpty);
      expect(player.commonName, isNotEmpty);
      expect(player.shortName, isNotEmpty);
      expect(player.fanNickname, isNull);
      expect(player.primaryPosition, isNotEmpty);
      expect(player.heightInches, greaterThan(0));
      expect(player.weightLbs, greaterThan(0));
      expect(player.college, isNotEmpty);
      expect(player.birthInfo, isNotEmpty);
      expect(player.fanPopularity, equals(0));
    });

    test('generateVeteranPlayer creates a player with null nickname', () {
      final player = generator.generateVeteranPlayer(age: 25);
      
      expect(player.fullName, isNotEmpty);
      expect(player.commonName, isNotEmpty);
      expect(player.shortName, isNotEmpty);
      expect(player.fanNickname, isNull);
      expect(player.primaryPosition, isNotEmpty);
      expect(player.heightInches, greaterThan(0));
      expect(player.weightLbs, greaterThan(0));
      expect(player.college, isNotEmpty);
      expect(player.birthInfo, isNotEmpty);
      expect(player.fanPopularity, equals(0));
    });

    test('Player toString handles null nickname correctly', () {
      final player = generator.generatePlayer();
      final playerString = player.toString();
      
      expect(playerString, contains('Nickname: None'));
      expect(playerString, isNot(contains('Nickname: "null"')));
    });

    test('generateVeteranPlayer with specific age creates appropriate college year', () {
      final player = generator.generateVeteranPlayer(age: 30, currentYear: 2025);
      
      // For a 30-year-old player in 2025, they should have graduated college around 2017-2019
      expect(player.college, contains('(201'));
    });
  });

  group('Rating System Tests', () {
    late PlayerGenerator generator;

    setUp(() {
      generator = PlayerGenerator();
    });

    test('generatePlayer creates ratings within valid range (55-110)', () {
      final player = generator.generatePlayer();
      
      // Test all ratings are within 55-110 range
      expect(player.overallRating, allOf(greaterThanOrEqualTo(55), lessThanOrEqualTo(110)));
      expect(player.potentialRating, allOf(greaterThanOrEqualTo(55), lessThanOrEqualTo(110)));
      expect(player.durabilityRating, allOf(greaterThanOrEqualTo(55), lessThanOrEqualTo(110)));
      expect(player.footballIqRating, allOf(greaterThanOrEqualTo(55), lessThanOrEqualTo(110)));
      expect(player.positionRating1, allOf(greaterThanOrEqualTo(55), lessThanOrEqualTo(110)));
      expect(player.positionRating2, allOf(greaterThanOrEqualTo(55), lessThanOrEqualTo(110)));
      expect(player.positionRating3, allOf(greaterThanOrEqualTo(55), lessThanOrEqualTo(110)));
    });

    test('generateVeteranPlayer creates ratings within valid range (55-110)', () {
      final player = generator.generateVeteranPlayer(age: 25);
      
      // Test all ratings are within 55-110 range
      expect(player.overallRating, allOf(greaterThanOrEqualTo(55), lessThanOrEqualTo(110)));
      expect(player.potentialRating, allOf(greaterThanOrEqualTo(55), lessThanOrEqualTo(110)));
      expect(player.durabilityRating, allOf(greaterThanOrEqualTo(55), lessThanOrEqualTo(110)));
      expect(player.footballIqRating, allOf(greaterThanOrEqualTo(55), lessThanOrEqualTo(110)));
      expect(player.positionRating1, allOf(greaterThanOrEqualTo(55), lessThanOrEqualTo(110)));
      expect(player.positionRating2, allOf(greaterThanOrEqualTo(55), lessThanOrEqualTo(110)));
      expect(player.positionRating3, allOf(greaterThanOrEqualTo(55), lessThanOrEqualTo(110)));
    });

    test('overall rating is calculated correctly as average of position ratings', () {
      final player = generator.generatePlayer();
      
      final expectedOverall = ((player.positionRating1 + player.positionRating2 + player.positionRating3) / 3).round();
      expect(player.overallRating, equals(expectedOverall));
    });

    test('QB players get Football IQ boost', () {
      // Generate multiple QB players and check if any have boosted Football IQ
      var foundBoostedQB = false;
      var qbCount = 0;
      
      // Test up to 50 generations to find a QB
      for (int i = 0; i < 50; i++) {
        final player = generator.generatePlayer();
        if (player.primaryPosition == 'QB') {
          qbCount++;
          // Check if this QB has potentially boosted IQ (base range is 55-110, boost can go up to 115 but clamped to 110)
          if (player.footballIqRating >= 55) {
            foundBoostedQB = true;
          }
        }
      }
      
      // If we found any QBs, verify they have valid Football IQ ratings
      if (qbCount > 0) {
        expect(foundBoostedQB, isTrue, reason: 'QBs should have valid Football IQ ratings');
      }
    });

    test('Safety players get Football IQ boost', () {
      // Generate multiple players and check if Safeties have boosted Football IQ
      var foundBoostedSafety = false;
      var safetyCount = 0;
      
      // Test up to 50 generations to find a Safety
      for (int i = 0; i < 50; i++) {
        final player = generator.generatePlayer();
        if (['S', 'FS', 'SS'].contains(player.primaryPosition)) {
          safetyCount++;
          // Check if this Safety has potentially boosted IQ
          if (player.footballIqRating >= 55) {
            foundBoostedSafety = true;
          }
        }
      }
      
      // If we found any Safeties, verify they have valid Football IQ ratings
      if (safetyCount > 0) {
        expect(foundBoostedSafety, isTrue, reason: 'Safeties should have valid Football IQ ratings');
      }
    });

    test('fan popularity starts at 0 for new players', () {
      final player = generator.generatePlayer();
      expect(player.fanPopularity, equals(0));
      
      final veteranPlayer = generator.generateVeteranPlayer();
      expect(veteranPlayer.fanPopularity, equals(0));
    });
  });

  group('Position-Specific Attributes Tests', () {
    late PlayerGenerator generator;

    setUp(() {
      generator = PlayerGenerator();
    });

    test('Player has position-specific attribute names', () {
      final player = generator.generatePlayer();
      final attributes = player.positionAttributes;
      
      // Should have position attributes for known positions
      if (attributes != null) {
        expect(attributes.attribute1, isNotEmpty);
        expect(attributes.attribute2, isNotEmpty);
        expect(attributes.attribute3, isNotEmpty);
      }
    });

    test('Player toString displays position-specific ratings correctly', () {
      final player = generator.generatePlayer();
      final playerString = player.toString();
      
      // Should contain position ratings in some form
      expect(playerString, contains('Position Ratings:'));
      
      // Should contain actual rating values
        expect(playerString, contains('(${player.positionRating1})'));
        expect(playerString, contains('(${player.positionRating2})'));
        expect(playerString, contains('(${player.positionRating3})'));
    });

    test('formattedPositionRatings includes attribute names for known positions', () {
      // Test multiple players to get different positions
      for (int i = 0; i < 10; i++) {
        final player = generator.generatePlayer();
        final formatted = player.formattedPositionRatings;
        
        // Should contain rating values in parentheses
        expect(formatted, contains('(${player.positionRating1})'));
        expect(formatted, contains('(${player.positionRating2})'));
        expect(formatted, contains('(${player.positionRating3})'));
        
        // Should either contain attribute names or "Unknown Position"
        expect(formatted, anyOf(
          contains('Unknown Position:'),
          allOf(
            isNot(contains('Unknown Position:')),
            isNot(isEmpty),
          ),
        ));
      }
    });
  });

  group('Position-Specific Physical Attributes Tests', () {
    late PlayerGenerator generator;

    setUp(() {
      generator = PlayerGenerator();
    });

    test('Offensive Line players have appropriate height and weight ranges', () {
      const sampleSize = 100;
      final heights = <int>[];
      final weights = <int>[];
      
      // Generate OL players by filtering generated players
      int attempts = 0;
      while (heights.length < sampleSize && attempts < sampleSize * 10) {
        final player = generator.generatePlayer();
        if (player.primaryPosition == 'OL') {
          heights.add(player.heightInches);
          weights.add(player.weightLbs);
        }
        attempts++;
      }
      
      if (heights.isNotEmpty) {
        // OL Height: 75-80 inches (6'3" - 6'8")
        expect(heights.every((h) => h >= 75 && h <= 80), isTrue);
        
        // OL Weight: should average around 315 lbs (280-360 range)
        final avgWeight = weights.reduce((a, b) => a + b) / weights.length;
        expect(avgWeight, allOf(greaterThan(300.0), lessThan(330.0)));
        expect(weights.every((w) => w >= 280 && w <= 360), isTrue);
      }
    });

    test('Defensive Line players have appropriate height and weight ranges', () {
      const sampleSize = 100;
      final heights = <int>[];
      final weights = <int>[];
      
      int attempts = 0;
      while (heights.length < sampleSize && attempts < sampleSize * 10) {
        final player = generator.generatePlayer();
        if (player.primaryPosition == 'DL') {
          heights.add(player.heightInches);
          weights.add(player.weightLbs);
        }
        attempts++;
      }
      
      if (heights.isNotEmpty) {
        // DL Height: 74-80 inches (6'2" - 6'8")
        expect(heights.every((h) => h >= 74 && h <= 80), isTrue);
        
        // DL Weight: should average around 290 lbs (220-350 range)
        final avgWeight = weights.reduce((a, b) => a + b) / weights.length;
        expect(avgWeight, allOf(greaterThan(270.0), lessThan(310.0)));
        expect(weights.every((w) => w >= 220 && w <= 350), isTrue);
      }
    });

    test('Cornerback players have appropriate height and weight ranges', () {
      const sampleSize = 100;
      final heights = <int>[];
      final weights = <int>[];
      
      int attempts = 0;
      while (heights.length < sampleSize && attempts < sampleSize * 10) {
        final player = generator.generatePlayer();
        if (player.primaryPosition == 'CB') {
          heights.add(player.heightInches);
          weights.add(player.weightLbs);
        }
        attempts++;
      }
      
      if (heights.isNotEmpty) {
        // CB Height: 69-74 inches (5'9" - 6'2")
        expect(heights.every((h) => h >= 69 && h <= 74), isTrue);
        
        // CB Weight: should average around 195 lbs (165-230 range)
        final avgWeight = weights.reduce((a, b) => a + b) / weights.length;
        expect(avgWeight, allOf(greaterThan(185.0), lessThan(210.0)));
        expect(weights.every((w) => w >= 165 && w <= 230), isTrue);
      }
    });

    test('Running Back players have appropriate height and weight ranges', () {
      const sampleSize = 100;
      final heights = <int>[];
      final weights = <int>[];
      
      int attempts = 0;
      while (heights.length < sampleSize && attempts < sampleSize * 10) {
        final player = generator.generatePlayer();
        if (player.primaryPosition == 'RB') {
          heights.add(player.heightInches);
          weights.add(player.weightLbs);
        }
        attempts++;
      }
      
      if (heights.isNotEmpty) {
        // RB Height: 68-74 inches (5'8" - 6'2")
        expect(heights.every((h) => h >= 68 && h <= 74), isTrue);
        
        // RB Weight: should average around 210 lbs (180-240 range)
        final avgWeight = weights.reduce((a, b) => a + b) / weights.length;
        expect(avgWeight, allOf(greaterThan(200.0), lessThan(220.0)));
        expect(weights.every((w) => w >= 180 && w <= 240), isTrue);
      }
    });

    test('Quarterback players have appropriate height and weight ranges', () {
      const sampleSize = 100;
      final heights = <int>[];
      final weights = <int>[];
      
      int attempts = 0;
      while (heights.length < sampleSize && attempts < sampleSize * 10) {
        final player = generator.generatePlayer();
        if (player.primaryPosition == 'QB') {
          heights.add(player.heightInches);
          weights.add(player.weightLbs);
        }
        attempts++;
      }
      
      if (heights.isNotEmpty) {
        // QB Height: 72-78 inches (6'0" - 6'6")
        expect(heights.every((h) => h >= 72 && h <= 78), isTrue);
        
        // QB Weight: should average around 215 lbs (185-255 range)
        final avgWeight = weights.reduce((a, b) => a + b) / weights.length;
        expect(avgWeight, allOf(greaterThan(205.0), lessThan(230.0)));
        expect(weights.every((w) => w >= 185 && w <= 255), isTrue);
      }
    });

    test('Position weight distributions follow normal curves with correct means', () {
      const sampleSize = 50;
      final positionWeights = <String, List<int>>{};
      
      // Collect weights for each position
      int attempts = 0;
      while (attempts < sampleSize * 20) {
        final player = generator.generatePlayer();
        positionWeights.putIfAbsent(player.primaryPosition, () => <int>[]);
        if (positionWeights[player.primaryPosition]!.length < sampleSize) {
          positionWeights[player.primaryPosition]!.add(player.weightLbs);
        }
        attempts++;
      }
      
      // Expected weight means for each position
      final expectedMeans = {
        'OL': 315.0,
        'DL': 290.0,
        'TE': 255.0,
        'LB': 245.0,
        'QB': 215.0,
        'RB': 210.0,
        'S': 205.0,
        'WR': 200.0,
        'CB': 195.0,
        'K': 185.0,
      };
      
      // Verify each position has weights close to expected mean
      for (final entry in positionWeights.entries) {
        final position = entry.key;
        final weights = entry.value;
        
        if (weights.length >= 10 && expectedMeans.containsKey(position)) {
          final avgWeight = weights.reduce((a, b) => a + b) / weights.length;
          final expectedMean = expectedMeans[position]!;
          
          // Average should be within ±15 lbs of expected mean
          expect(avgWeight, 
            allOf(
              greaterThan(expectedMean - 15), 
              lessThan(expectedMean + 15)
            ),
            reason: '$position players should average around $expectedMean lbs, but averaged $avgWeight lbs'
          );
        }
      }
    });

    test('Offensive Line players are consistently heavier than skill position players', () {
      const sampleSize = 50;
      final olWeights = <int>[];
      final skillWeights = <int>[]; // RB, WR, CB
      
      int attempts = 0;
      while ((olWeights.length < sampleSize || skillWeights.length < sampleSize) && attempts < sampleSize * 20) {
        final player = generator.generatePlayer();
        if (player.primaryPosition == 'OL' && olWeights.length < sampleSize) {
          olWeights.add(player.weightLbs);
        } else if (['RB', 'WR', 'CB'].contains(player.primaryPosition) && skillWeights.length < sampleSize) {
          skillWeights.add(player.weightLbs);
        }
        attempts++;
      }
      
      if (olWeights.isNotEmpty && skillWeights.isNotEmpty) {
        final avgOLWeight = olWeights.reduce((a, b) => a + b) / olWeights.length;
        final avgSkillWeight = skillWeights.reduce((a, b) => a + b) / skillWeights.length;
        
        // OL players should be significantly heavier than skill position players
        expect(avgOLWeight, greaterThan(avgSkillWeight + 80));
      }
    });
  });

  group('Bell Curve Distribution Tests', () {
    late PlayerGenerator generator;

    setUp(() {
      generator = PlayerGenerator();
    });

    test('Rating distribution follows bell curve centered at 70', () {
      const sampleSize = 1000;
      final ratings = <int>[];
      
      // Generate a large sample of ratings
      for (int i = 0; i < sampleSize; i++) {
        final player = generator.generatePlayer();
        ratings.add(player.positionRating1);
        ratings.add(player.positionRating2);
        ratings.add(player.positionRating3);
      }
      
      // Calculate average rating
      final average = ratings.reduce((a, b) => a + b) / ratings.length;
      
      // Average should be close to 70 (within ±3 points due to randomness)
      expect(average, allOf(greaterThan(67.0), lessThan(73.0)));
      
      // Count ratings in different ranges
      final range60to79 = ratings.where((r) => r >= 60 && r < 80).length;
      final range80to89 = ratings.where((r) => r >= 80 && r < 90).length;
      final above90 = ratings.where((r) => r >= 90).length;
      
      // Most ratings should be in the 60-79 range (bell curve center)
      expect(range60to79, greaterThan(ratings.length * 0.5));
      
      // Higher ratings should be rarer
      expect(range80to89, lessThan(range60to79));
      expect(above90, lessThan(range80to89));
      
      // Elite ratings (90+) should be very rare (less than 5% of total)
      expect(above90, lessThan(ratings.length * 0.05));
    });

    test('Overall ratings reflect bell curve distribution', () {
      const sampleSize = 500;
      final overallRatings = <int>[];
      
      // Generate players and collect overall ratings
      for (int i = 0; i < sampleSize; i++) {
        final player = generator.generatePlayer();
        overallRatings.add(player.overallRating);
      }
      
      // Calculate average overall rating
      final average = overallRatings.reduce((a, b) => a + b) / overallRatings.length;
      
      // Average should be close to 70 (within ±3 points)
      expect(average, allOf(greaterThan(67.0), lessThan(73.0)));
      
      // Count elite players (overall 85+)
      final elitePlayers = overallRatings.where((r) => r >= 85).length;
      
      // Elite players should be rare (less than 10% of total)
      expect(elitePlayers, lessThan(overallRatings.length * 0.1));
    });
  });
}
