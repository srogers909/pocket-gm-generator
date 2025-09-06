import 'package:pocket_gm_generator/pocket_gm_generator.dart';

void main() {
  print('🎯 Player Rating Distribution Test');
  print('=' * 50);
  
  final playerGenerator = PlayerGenerator();
  final teamGenerator = TeamGenerator();
  
  // Generate multiple teams to test rating distribution
  print('\n📊 Testing Rating Distribution Across 5 Teams...\n');
  
  final teams = teamGenerator.generateLeague(5);
  final allPlayers = <Player>[];
  
  for (int i = 0; i < teams.length; i++) {
    final team = teams[i];
    allPlayers.addAll(team.roster);
    print('Team ${i + 1}: ${team.name}');
    print('  Average Rating: ${team.averageOverallRating.toStringAsFixed(1)}');
    print('  Roster Size: ${team.roster.length}');
  }
  
  // Calculate overall statistics
  final totalPlayers = allPlayers.length;
  final overallAverage = allPlayers.fold<double>(0, (sum, player) => sum + player.overallRating) / totalPlayers;
  
  print('\n📈 Overall Statistics');
  print('=' * 30);
  print('Total Players: $totalPlayers');
  print('Overall Average Rating: ${overallAverage.toStringAsFixed(2)}');
  
  // Count players by rating ranges
  final ranges = {
    '90+': 0,
    '80-89': 0,
    '70-79': 0,
    '60-69': 0,
    '50-59': 0,
  };
  
  for (final player in allPlayers) {
    final rating = player.overallRating;
    if (rating >= 90) {
      ranges['90+'] = ranges['90+']! + 1;
    } else if (rating >= 80) {
      ranges['80-89'] = ranges['80-89']! + 1;
    } else if (rating >= 70) {
      ranges['70-79'] = ranges['70-79']! + 1;
    } else if (rating >= 60) {
      ranges['60-69'] = ranges['60-69']! + 1;
    } else {
      ranges['50-59'] = ranges['50-59']! + 1;
    }
  }
  
  print('\n🎯 Rating Distribution');
  print('=' * 25);
  for (final entry in ranges.entries) {
    final percentage = (entry.value / totalPlayers * 100).toStringAsFixed(1);
    print('${entry.key}: ${entry.value} players (${percentage}%)');
  }
  
  // Find highest and lowest rated players
  final sortedPlayers = List<Player>.from(allPlayers);
  sortedPlayers.sort((a, b) => b.overallRating.compareTo(a.overallRating));
  
  print('\n⭐ Top 5 Players');
  print('=' * 20);
  for (int i = 0; i < 5 && i < sortedPlayers.length; i++) {
    final player = sortedPlayers[i];
    print('${i + 1}. ${player.commonName} (${player.primaryPosition}) - ${player.overallRating}');
  }
  
  print('\n📉 Bottom 5 Players');
  print('=' * 20);
  for (int i = sortedPlayers.length - 5; i < sortedPlayers.length && i >= 0; i++) {
    final player = sortedPlayers[i];
    print('${sortedPlayers.length - i}. ${player.commonName} (${player.primaryPosition}) - ${player.overallRating}');
  }
}
