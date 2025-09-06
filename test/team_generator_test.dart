import 'package:test/test.dart';
import 'package:pocket_gm_generator/pocket_gm_generator.dart';

void main() {
  group('TeamGenerator Tests', () {
    late TeamGenerator teamGenerator;

    setUp(() {
      teamGenerator = TeamGenerator();
    });

    test('generateTeam creates a valid team with 53-man roster', () {
      final team = teamGenerator.generateTeam();
      
      expect(team.name, isNotEmpty);
      expect(team.abbreviation, isNotEmpty);
      expect(team.abbreviation.length, inInclusiveRange(2, 3));
      expect(team.primaryColor, isNotEmpty);
      expect(team.secondaryColor, isNotEmpty);
      expect(team.primaryColor, isNot(equals(team.secondaryColor)));
      expect(team.roster.length, equals(53));
      expect(team.averageOverallRating, greaterThan(0));
    });

    test('team has correct roster composition', () {
      final team = teamGenerator.generateTeam();
      
      // Expected roster composition
      const expectedComposition = {
        'QB': 3,
        'RB': 4,
        'WR': 6,
        'TE': 3,
        'OL': 9,
        'DL': 8,
        'LB': 7,
        'CB': 6,
        'S': 5,
        'K': 2,
      };
      
      for (final entry in expectedComposition.entries) {
        final position = entry.key;
        final expectedCount = entry.value;
        final actualPlayers = team.getPlayersByPosition(position);
        
        expect(actualPlayers.length, equals(expectedCount), 
               reason: 'Position $position should have $expectedCount players, but has ${actualPlayers.length}');
        
        // Verify all players have the correct position
        for (final player in actualPlayers) {
          expect(player.primaryPosition, equals(position));
        }
      }
    });

    test('team starting lineup has one player per position', () {
      final team = teamGenerator.generateTeam();
      final startingLineup = team.startingLineup;
      
      expect(startingLineup.length, equals(10)); // One starter per position
      
      // Check that we have exactly one starter for each position
      final positions = startingLineup.map((p) => p.primaryPosition).toSet();
      expect(positions.length, equals(10)); // No duplicate positions
      
      // Verify starters are the highest-rated players at their positions
      for (final starter in startingLineup) {
        final playersAtPosition = team.getPlayersByPosition(starter.primaryPosition);
        final highestRated = playersAtPosition.reduce((a, b) => 
            a.overallRating > b.overallRating ? a : b);
        expect(starter.overallRating, equals(highestRated.overallRating));
      }
    });

    test('generateLeague creates unique teams', () {
      final teams = teamGenerator.generateLeague(4);
      
      expect(teams.length, equals(4));
      
      // Check that all team names are unique
      final teamNames = teams.map((t) => t.name).toSet();
      expect(teamNames.length, equals(4));
      
      // Check that all teams have valid rosters
      for (final team in teams) {
        expect(team.roster.length, equals(53));
        expect(team.averageOverallRating, greaterThan(0));
      }
    });

    test('generateVeteranTeam creates team with veteran players', () {
      final veteranTeam = teamGenerator.generateVeteranTeam();
      
      expect(veteranTeam.name, isNotEmpty);
      expect(veteranTeam.roster.length, equals(53));
      expect(veteranTeam.averageOverallRating, greaterThan(0));
      
      // Veteran teams should generally have higher ratings than rookie teams
      // (this is probabilistic, but should be true most of the time)
      final regularTeam = teamGenerator.generateTeam();
      expect(veteranTeam.averageOverallRating, 
             greaterThanOrEqualTo(regularTeam.averageOverallRating - 5));
    });

    test('team roster breakdown is correct', () {
      final team = teamGenerator.generateTeam();
      final breakdown = team.rosterBreakdown;
      
      expect(breakdown.values.reduce((a, b) => a + b), equals(53));
      
      // Check specific position counts
      expect(breakdown['QB'], equals(3));
      expect(breakdown['RB'], equals(4));
      expect(breakdown['WR'], equals(6));
      expect(breakdown['TE'], equals(3));
      expect(breakdown['OL'], equals(9));
      expect(breakdown['DL'], equals(8));
      expect(breakdown['LB'], equals(7));
      expect(breakdown['CB'], equals(6));
      expect(breakdown['S'], equals(5));
      expect(breakdown['K'], equals(2));
    });

    test('team abbreviation is generated correctly', () {
      // Generate multiple teams to test abbreviation logic
      for (int i = 0; i < 10; i++) {
        final team = teamGenerator.generateTeam();
        
        expect(team.abbreviation, isNotEmpty);
        expect(team.abbreviation.length, inInclusiveRange(2, 3));
        expect(team.abbreviation, equals(team.abbreviation.toUpperCase()));
        
        // Abbreviation should be related to the team name
        final nameParts = team.name.split(' ');
        expect(nameParts.length, greaterThanOrEqualTo(2));
      }
    });

    test('team toString provides comprehensive information', () {
      final team = teamGenerator.generateTeam();
      final teamString = team.toString();
      
      expect(teamString, contains(team.name));
      expect(teamString, contains(team.abbreviation));
      expect(teamString, contains(team.primaryColor));
      expect(teamString, contains(team.secondaryColor));
      expect(teamString, contains('53 players'));
      expect(teamString, contains('Starting Lineup'));
      expect(teamString, contains('Roster Breakdown'));
    });

    test('detailed roster shows all players organized by position', () {
      final team = teamGenerator.generateTeam();
      final detailedRoster = team.detailedRoster;
      
      expect(detailedRoster, contains(team.name));
      expect(detailedRoster, contains('Complete Roster'));
      
      // Should contain all positions
      for (final position in ['QB', 'RB', 'WR', 'TE', 'OL', 'DL', 'LB', 'CB', 'S', 'K']) {
        expect(detailedRoster, contains(position));
      }
      
      // Should show starting players with star
      expect(detailedRoster, contains('★'));
    });
  });
}
