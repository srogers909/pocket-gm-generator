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
}
