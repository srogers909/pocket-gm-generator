import 'package:pocket_gm_generator/pocket_gm_generator.dart';

void main() {
  print('=== Testing Stadium and Fan Happiness Features ===\n');

  // Test stadium generation
  print('--- Testing Stadium Generation ---');
  final stadiumGenerator = StadiumGenerator();
  
  for (int i = 0; i < 3; i++) {
    final stadium = stadiumGenerator.generateStadium();
    print('Stadium ${i + 1}:');
    print('  Name: ${stadium.name}');
    print('  Location: ${stadium.location}');
    print('  Turf: ${stadium.turfType}');
    print('  Roof: ${stadium.roofType}');
    print('  Capacity: ${stadium.capacity}');
    print('  Year Built: ${stadium.yearBuilt}');
    print('  Luxury Suites: ${stadium.luxurySuites}');
    print('  Concessions Rating: ${stadium.concessionsRating}');
    print('  Parking Rating: ${stadium.parkingRating}');
    print('  Home Field Advantage: ${stadium.homeFieldAdvantage}');
    print('');
  }

  // Test team generation with stadium and fan happiness
  print('--- Testing Team Generation with Stadium and Fan Happiness ---');
  final teamGenerator = TeamGenerator();
  
  // Generate teams of different tiers to see fan happiness variation
  final tiers = [
    TeamTier.superBowlContender,
    TeamTier.playoffTeam,
    TeamTier.average,
    TeamTier.rebuilding,
    TeamTier.bad,
  ];
  
  for (final tier in tiers) {
    final team = teamGenerator.generateTeam(tier: tier);
    print('${tier.name.toUpperCase()} Team: ${team.name}');
    print('  Average Rating: ${team.averageOverallRating.toStringAsFixed(1)}');
    print('  Fan Happiness: ${team.fanHappiness}');
    print('  Team Morale: ${team.teamMorale.toStringAsFixed(1)}');
    print('  Stadium: ${team.stadium.name} (${team.stadium.location})');
    print('  Stadium Details:');
    print('    - Capacity: ${team.stadium.capacity}');
    print('    - ${team.stadium.turfType.name.toUpperCase()} turf');
    print('    - ${team.stadium.roofType.name.toUpperCase()} roof');
    print('    - Home Field Advantage: ${team.stadium.homeFieldAdvantage}/10');
    print('');
  }

  // Test league generation to ensure all teams have stadiums and fan happiness
  print('--- Testing League Generation ---');
  final leagueGenerator = LeagueGenerator();
  final league = leagueGenerator.generateLeague();
  
  print('Generated league with ${league.allTeams.length} teams:');
  for (final team in league.allTeams) {
    print('  ${team.name} (${team.abbreviation})');
    print('    - Rating: ${team.averageOverallRating.ceil()}');
    print('    - Fan Happiness: ${team.fanHappiness}');
    print('    - Stadium: ${team.stadium.name}');
  }
  
  print('\n=== Stadium and Fan Happiness Testing Complete ===');
}
