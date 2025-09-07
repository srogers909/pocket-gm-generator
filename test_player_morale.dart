import 'lib/src/models/player.dart';
import 'lib/src/models/team_tier.dart';
import 'lib/src/services/player_generator.dart';

void main() {
  print('=== Player Morale Test ===\n');
  
  final playerGenerator = PlayerGenerator();
  
  // Generate 10 players and check their morale values
  print('Generating 10 players to test morale:');
  print('');
  
  for (int i = 1; i <= 10; i++) {
    final player = playerGenerator.generatePlayer(tier: TeamTier.average);
    print('Player $i: ${player.commonName}');
    print('  Position: ${player.primaryPosition}');
    print('  Overall Rating: ${player.overallRating}');
    print('  Morale: ${player.morale}');
    print('');
  }
  
  // Test with different tiers
  print('Testing morale across different team tiers:');
  print('');
  
  for (final tier in TeamTier.values) {
    final player = playerGenerator.generatePlayer(tier: tier);
    print('${tier.displayName} - ${player.commonName}:');
    print('  Overall: ${player.overallRating}, Morale: ${player.morale}');
    print('');
  }
}
