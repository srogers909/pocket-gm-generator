import '../lib/pocket_gm_generator.dart';

void main() {
  print('🏈 Generating NFL-style League 🏈');
  print('=' * 40);
  
  // Create league generator
  final leagueGenerator = LeagueGenerator();
  
  // Generate a complete NFL-style league
  final league = leagueGenerator.generateLeague(
    leagueName: "Professional Football League",
    distributeTiers: true,
    useNflStructure: true,
  );
  
  // Display basic league information
  print('\n📊 League Statistics:');
  print('Teams: ${league.teamCount}');
  print('Conferences: ${league.conferenceCount}');
  print('Divisions: ${league.divisionCount}');
  print('Average Rating: ${league.averageRating.toStringAsFixed(1)}');
  
  final stats = league.statistics;
  print('Rating Range: ${stats['lowestRating'].toStringAsFixed(1)} - ${stats['highestRating'].toStringAsFixed(1)}');
  
  // Display power rankings (top 10)
  print('\n🏆 Top 10 Teams:');
  final topTeams = league.teamsByRating.take(10);
  int rank = 1;
  for (final team in topTeams) {
    print('${rank}. ${team.name} (${team.abbreviation}) - ${team.averageOverallRating.toStringAsFixed(1)}');
    rank++;
  }
  
  // Display conference overview
  print('\n📋 Conference Overview:');
  for (final conference in league.conferences) {
    print('\n${conference.name} Conference (Avg: ${conference.averageRating.toStringAsFixed(1)}):');
    for (final division in conference.divisions) {
      print('  ${division.name} (Avg: ${division.averageRating.toStringAsFixed(1)})');
      for (final team in division.teams) {
        print('    ${team.name} (${team.abbreviation}) - ${team.averageOverallRating.toStringAsFixed(1)}');
      }
    }
  }
  
  print('\n✅ League generation complete!');
}
