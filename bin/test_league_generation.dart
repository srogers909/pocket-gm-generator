import 'package:pocket_gm_generator/pocket_gm_generator.dart';

void main() {
  print('🏈 NFL League Generation Test 🏈');
  print('=' * 50);
  
  // Create league generator
  final leagueGenerator = LeagueGenerator();
  
  try {
    // Test 1: Generate NFL-style league
    print('\n📊 Generating NFL-style league...');
    final league = leagueGenerator.generateLeague(
      leagueName: "National Football League",
      distributeTiers: true,
      useNflStructure: true,
    );
    
    // Validate league structure
    print('\n✅ League Structure Validation:');
    print('  Conferences: ${league.conferenceCount}/2');
    print('  Divisions: ${league.divisionCount}/8');
    print('  Teams: ${league.teamCount}/32');
    print('  Average Rating: ${league.averageRating.toStringAsFixed(1)}');
    
    final stats = league.statistics;
    print('  Rating Range: ${stats['lowestRating'].toStringAsFixed(1)} - ${stats['highestRating'].toStringAsFixed(1)} (${stats['ratingRange'].toStringAsFixed(1)} points)');
    
    // Verify structure matches NFL
    final afcConference = league.getConference('AFC');
    final nfcConference = league.getConference('NFC');
    
    if (afcConference != null && nfcConference != null) {
      print('\n✅ Conference Structure:');
      print('  AFC: ${afcConference.teamCount} teams, ${afcConference.divisionCount} divisions');
      print('  NFC: ${nfcConference.teamCount} teams, ${nfcConference.divisionCount} divisions');
    }
    
    // Test 2: Display league overview
    print('\n📋 League Overview:');
    print('-' * 30);
    
    for (final conference in league.conferences) {
      print('\n${conference.name} Conference:');
      for (final division in conference.divisions) {
        print('  ${division.name}:');
        for (final team in division.teams) {
          print('    ${team.name} (${team.abbreviation}) - ${team.averageOverallRating.toStringAsFixed(1)}');
        }
      }
    }
    
    // Test 3: Power Rankings
    print('\n🏆 Power Rankings (Top 10):');
    print('-' * 30);
    
    final rankedTeams = league.teamsByRating;
    for (int i = 0; i < 10 && i < rankedTeams.length; i++) {
      final team = rankedTeams[i];
      print('${i + 1}. ${team.name} (${team.abbreviation}) - ${team.division} - ${team.averageOverallRating.toStringAsFixed(1)}');
    }
    
    // Test 4: Conference standings
    print('\n📊 Conference Standings:');
    print('-' * 30);
    
    for (final conference in league.conferences) {
      print('\n${conference.name} Conference:');
      final confTeams = conference.teamsByRating;
      for (int i = 0; i < confTeams.length; i++) {
        final team = confTeams[i];
        // Find team's division
        String divisionName = 'Unknown';
        for (final division in conference.divisions) {
          if (division.teams.contains(team)) {
            divisionName = division.name;
            break;
          }
        }
        print('  ${i + 1}. ${team.name} (${team.abbreviation}) - $divisionName - ${team.averageOverallRating.toStringAsFixed(1)}');
      }
    }
    
    // Test 5: Division analysis
    print('\n🏟️ Division Analysis:');
    print('-' * 30);
    
    for (final conference in league.conferences) {
      for (final division in conference.divisions) {
        final divisionTeams = division.teamsByRating;
        print('\n${division.name} (Avg: ${division.averageRating.toStringAsFixed(1)}):');
        for (int i = 0; i < divisionTeams.length; i++) {
          final team = divisionTeams[i];
          final rank = i == 0 ? '👑' : '  ';
          print('  $rank ${team.name} (${team.abbreviation}) - ${team.averageOverallRating.toStringAsFixed(1)}');
        }
      }
    }
    
    // Test 6: Team lookup functionality
    print('\n🔍 Team Lookup Test:');
    print('-' * 30);
    
    // Test getting team by name
    final testTeam = league.allTeams.first;
    final foundTeam = league.getTeam(testTeam.name);
    if (foundTeam != null) {
      print('✅ Found team by name: ${foundTeam.name}');
    }
    
    // Test getting team by abbreviation
    final foundByAbbr = league.getTeamByAbbreviation(testTeam.abbreviation);
    if (foundByAbbr != null) {
      print('✅ Found team by abbreviation: ${foundByAbbr.name} (${foundByAbbr.abbreviation})');
    }
    
    // Test 7: Division lookup
    final testDivision = league.getDivision('AFC East');
    if (testDivision != null) {
      print('✅ Found division: ${testDivision.name} with ${testDivision.teamCount} teams');
    }
    
    // Test 8: Team tier distribution analysis
    print('\n📈 Team Tier Distribution Analysis:');
    print('-' * 30);
    
    final allTeams = league.allTeams;
    final tierRanges = <String, List<double>>{
      'Elite (80+)': [],
      'Playoff (75-79.9)': [],
      'Average (70-74.9)': [],
      'Rebuilding (65-69.9)': [],
      'Bad (<65)': [],
    };
    
    for (final team in allTeams) {
      final rating = team.averageOverallRating;
      if (rating >= 80) {
        tierRanges['Elite (80+)']!.add(rating);
      } else if (rating >= 75) {
        tierRanges['Playoff (75-79.9)']!.add(rating);
      } else if (rating >= 70) {
        tierRanges['Average (70-74.9)']!.add(rating);
      } else if (rating >= 65) {
        tierRanges['Rebuilding (65-69.9)']!.add(rating);
      } else {
        tierRanges['Bad (<65)']!.add(rating);
      }
    }
    
    for (final entry in tierRanges.entries) {
      final count = entry.value.length;
      final percentage = (count / allTeams.length * 100).toStringAsFixed(1);
      print('${entry.key}: $count teams ($percentage%)');
    }
    
    // Test 9: Performance check
    print('\n⚡ Performance Test:');
    print('-' * 30);
    
    final stopwatch = Stopwatch()..start();
    final performanceLeague = leagueGenerator.generateLeague();
    stopwatch.stop();
    
    print('✅ Generated 32-team league in ${stopwatch.elapsedMilliseconds}ms');
    print('   Average: ${performanceLeague.averageRating.toStringAsFixed(1)}');
    final perfStats = performanceLeague.statistics;
    print('   Range: ${perfStats['lowestRating'].toStringAsFixed(1)} - ${perfStats['highestRating'].toStringAsFixed(1)}');
    
    // Final validation
    print('\n🎯 Final Validation:');
    print('-' * 30);
    
    bool allValid = true;
    
    // Check team count
    if (league.teamCount != 32) {
      print('❌ Wrong team count: ${league.teamCount} (expected 32)');
      allValid = false;
    }
    
    // Check conference count
    if (league.conferenceCount != 2) {
      print('❌ Wrong conference count: ${league.conferenceCount} (expected 2)');
      allValid = false;
    }
    
    // Check division count
    if (league.divisionCount != 8) {
      print('❌ Wrong division count: ${league.divisionCount} (expected 8)');
      allValid = false;
    }
    
    // Check rating variation
    final ratingRange = stats['ratingRange'] as double;
    if (ratingRange < 10.0) {
      print('❌ Insufficient rating variation: ${ratingRange.toStringAsFixed(1)} (expected > 10.0)');
      allValid = false;
    }
    
    if (allValid) {
      print('✅ All validations passed!');
      print('✅ League generation system working correctly');
    } else {
      print('❌ Some validations failed');
    }
    
  } catch (e, stackTrace) {
    print('❌ Error during league generation: $e');
    print('Stack trace: $stackTrace');
  }
  
  print('\n${'=' * 50}');
  print('🏈 League Generation Test Complete 🏈');
}
