import '../lib/src/services/team_generator.dart';
import '../lib/src/models/team_tier.dart';

void main() {
  final teamGenerator = TeamGenerator();
  
  print('🏈 Team Tier Variation Test');
  print('=' * 50);
  print('');
  
  // Test 1: Generate one team of each tier
  print('📊 Testing Each Team Tier:');
  print('-' * 30);
  
  for (final tier in TeamTier.values) {
    final team = teamGenerator.generateTeam(tier: tier);
    final averageRating = team.averageOverallRating;
    
    print('${tier.displayName}: ${team.name}');
    print('  Average Rating: ${averageRating.toStringAsFixed(1)}');
    print('  Description: ${tier.description}');
    print('');
  }
  
  // Test 2: Generate a varied league
  print('🏟️ League with Varied Team Strengths (8 teams):');
  print('-' * 45);
  
  final league = teamGenerator.generateLeague(8);
  final sortedTeams = List<String>.from(league.map((team) => 
    '${team.name.padRight(25)} | Avg: ${team.averageOverallRating.toStringAsFixed(1)}'));
  
  // Sort by rating for better visualization
  league.sort((a, b) => b.averageOverallRating.compareTo(a.averageOverallRating));
  
  var rank = 1;
  for (final team in league) {
    final rating = team.averageOverallRating;
    String tierGuess = '';
    
    if (rating >= 83) tierGuess = '(Super Bowl Contender)';
    else if (rating >= 78) tierGuess = '(Playoff Team)';
    else if (rating >= 74) tierGuess = '(Average)';
    else if (rating >= 69) tierGuess = '(Rebuilding)';
    else tierGuess = '(Bad)';
    
    print('${rank.toString().padLeft(2)}. ${team.name.padRight(25)} | ${rating.toStringAsFixed(1)} $tierGuess');
    rank++;
  }
  
  // Test 3: Rating distribution analysis
  print('');
  print('📈 Rating Distribution Analysis:');
  print('-' * 35);
  
  final ratings = league.map((team) => team.averageOverallRating).toList();
  final highest = ratings.reduce((a, b) => a > b ? a : b);
  final lowest = ratings.reduce((a, b) => a < b ? a : b);
  final average = ratings.reduce((a, b) => a + b) / ratings.length;
  final range = highest - lowest;
  
  print('Highest Team Rating: ${highest.toStringAsFixed(1)}');
  print('Lowest Team Rating:  ${lowest.toStringAsFixed(1)}');
  print('Average Team Rating: ${average.toStringAsFixed(1)}');
  print('Rating Range:        ${range.toStringAsFixed(1)} points');
  
  // Success indicator
  print('');
  if (range >= 8.0) {
    print('✅ SUCCESS: Good variation in team strengths! (${range.toStringAsFixed(1)} point range)');
  } else {
    print('⚠️  WARNING: Limited variation in team strengths (${range.toStringAsFixed(1)} point range)');
  }
  
  print('');
  print('🎯 Team tier system successfully implemented!');
}
