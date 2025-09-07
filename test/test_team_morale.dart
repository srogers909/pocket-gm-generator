import 'package:pocket_gm_generator/pocket_gm_generator.dart';

void main() {
  print('=== Team Morale Test ===\n');
  
  final teamGenerator = TeamGenerator();
  
  print('Generating teams to test overall team morale calculation:');
  print('');
  
  // Test with different tiers
  for (final tier in TeamTier.values) {
    print('Testing ${tier.displayName} team:');
    final team = teamGenerator.generateTeam(tier: tier);
    
    print('  Team: ${team.name} (${team.abbreviation})');
    print('  Average Player Rating: ${team.averageOverallRating.toStringAsFixed(1)}');
    print('  Team Morale: ${team.teamMorale.toStringAsFixed(1)}');
    
    // Show a few sample player morale values
    print('  Sample Player Morale:');
    for (int i = 0; i < 3 && i < team.roster.length; i++) {
      final player = team.roster[i];
      print('    ${player.commonName} (${player.primaryPosition}): ${player.morale}');
    }
    
    // Show staff morale values
    if (team.staff != null) {
      print('  Staff Morale:');
      for (final staffMember in team.staff!.allStaff) {
        print('    ${staffMember.position}: ${staffMember.morale}');
      }
    }
    
    print('');
  }
  
  // Test a single team in detail
  print('Detailed team morale breakdown:');
  final detailedTeam = teamGenerator.generateTeam(tier: TeamTier.average);
  print('Team: ${detailedTeam.name}');
  print('');
  
  // Calculate morale manually to verify
  double totalMorale = 0.0;
  int totalPeople = 0;
  
  print('All Player Morale:');
  for (final player in detailedTeam.roster) {
    print('  ${player.commonName} (${player.primaryPosition}): ${player.morale}');
    totalMorale += player.morale;
    totalPeople++;
  }
  
  print('');
  print('All Staff Morale:');
  if (detailedTeam.staff != null) {
    for (final staffMember in detailedTeam.staff!.allStaff) {
      print('  ${staffMember.position}: ${staffMember.morale}');
      totalMorale += staffMember.morale;
      totalPeople++;
    }
  }
  
  final manualAverage = totalMorale / totalPeople;
  print('');
  print('Manual calculation: $totalMorale / $totalPeople = ${manualAverage.toStringAsFixed(1)}');
  print('Team.teamMorale getter: ${detailedTeam.teamMorale.toStringAsFixed(1)}');
  print('Match: ${(manualAverage - detailedTeam.teamMorale).abs() < 0.01}');
}
