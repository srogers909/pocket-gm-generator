import 'package:pocket_gm_generator/pocket_gm_generator.dart';

void main() {
  print('🏈 Team Generator Demo');
  print('=' * 50);
  
  // Create team generator instance
  final teamGenerator = TeamGenerator();
  
  // Generate a single team
  print('\n📊 Generating a Single Team...\n');
  final team = teamGenerator.generateTeam();
  printTeamInfo(team);
  
  // Generate multiple teams for comparison
  print('\n🏟️  Generating Multiple Teams...\n');
  final teams = teamGenerator.generateLeague(4);
  
  for (int i = 0; i < teams.length; i++) {
    print('Team ${i + 1}:');
    printTeamSummary(teams[i]);
    print('');
  }
  
  // Generate a veteran team
  print('\n🏆 Generating a Veteran Team...\n');
  final veteranTeam = teamGenerator.generateVeteranTeam();
  printTeamInfo(veteranTeam);
  
  // Demonstrate roster composition validation
  print('\n📋 Roster Composition Validation');
  print('=' * 40);
  validateRosterComposition(team);
}

void printTeamInfo(Team team) {
  print('Team: ${team.name}');
  print('Abbreviation: ${team.abbreviation}');
  print('Colors: ${team.primaryColor} / ${team.secondaryColor}');
  print('Roster Size: ${team.roster.length} players');
  print('Average Overall Rating: ${team.averageOverallRating.toStringAsFixed(1)}');
  
  print('\nStarting Lineup:');
  final startingLineup = team.startingLineup;
  for (final player in startingLineup) {
    print('  ${player.primaryPosition}: ${player.commonName} (${player.overallRating})');
  }
  
  print('\nRoster by Position:');
  for (final position in ['QB', 'RB', 'WR', 'TE', 'OL', 'DL', 'LB', 'CB', 'S', 'K']) {
    final players = team.getPlayersByPosition(position);
    print('  $position (${players.length}): ${players.map((p) => '${p.commonName} (${p.overallRating})').join(', ')}');
  }
}

void printTeamSummary(Team team) {
  print('  ${team.name} (${team.abbreviation})');
  print('  Colors: ${team.primaryColor} / ${team.secondaryColor}');
  print('  Roster: ${team.roster.length} players, Avg Rating: ${team.averageOverallRating.toStringAsFixed(1)}');
  
  final qb = team.getPlayersByPosition('QB').first;
  print('  Starting QB: ${qb.commonName} (${qb.overallRating})');
}

void validateRosterComposition(Team team) {
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
  
  bool isValid = true;
  int totalExpected = 0;
  int totalActual = 0;
  
  for (final entry in expectedComposition.entries) {
    final position = entry.key;
    final expected = entry.value;
    final actual = team.getPlayersByPosition(position).length;
    
    totalExpected += expected;
    totalActual += actual;
    
    final status = actual == expected ? '✅' : '❌';
    print('  $position: $actual/$expected $status');
    
    if (actual != expected) {
      isValid = false;
    }
  }
  
  print('\nTotal Roster: $totalActual/$totalExpected ${isValid ? '✅' : '❌'}');
  print('Roster Composition: ${isValid ? 'VALID' : 'INVALID'}');
}
