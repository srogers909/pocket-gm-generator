import 'package:pocket_gm_generator/pocket_gm_generator.dart';

void main() {
  print('=== Testing League Generation with Referee Pool ===\n');
  
  // Generate a complete league
  final leagueGenerator = LeagueGenerator();
  final league = leagueGenerator.generateLeague(
    leagueName: "Test Football League",
  );
  
  print('Generated league: ${league.name}');
  print('Conferences: ${league.conferenceCount}');
  print('Divisions: ${league.divisionCount}');
  print('Teams: ${league.teamCount}');
  print('');
  
  // Test referee pool
  print('Referee Pool Analysis:');
  print('Total referees: ${league.refereePool.length}');
  print('');
  
  if (league.refereePool.isNotEmpty) {
    print('Sample referees from the league:');
    for (int i = 0; i < 3 && i < league.refereePool.length; i++) {
      final referee = league.refereePool[i];
      print('${i + 1}. ${referee.name}');
      print('   Status: ${referee.isActive ? "Active" : "Retired"}');
      print('   Experience: ${referee.yearsOfExperience} years');
      print('   Hired: ${referee.yearHired}');
      if (referee.yearRetired != null) {
        print('   Retired: ${referee.yearRetired}');
      }
      print('   Sample penalty tendencies:');
      print('     Holding: ${referee.holdingTendency}');
      print('     Pass Interference: ${referee.passInterferenceTendency}');
      print('     False Start: ${referee.falseStartTendency}');
      print('');
    }
    
    // Verify referee pool has expected size
    if (league.refereePool.length == 20) {
      print('✓ Referee pool has correct default size (20 referees)');
    } else {
      print('✗ Unexpected referee pool size: ${league.refereePool.length}');
    }
    
    // Check for unique referee names
    final refereeNames = league.refereePool.map((ref) => ref.name).toSet();
    if (refereeNames.length == league.refereePool.length) {
      print('✓ All referee names are unique');
    } else {
      print('✗ Found duplicate referee names');
    }
    
    // Check active vs retired distribution
    final activeCount = league.refereePool.where((ref) => ref.isActive).length;
    final retiredCount = league.refereePool.length - activeCount;
    print('✓ Active referees: $activeCount, Retired: $retiredCount');
    
    print('');
    print('✅ League with referee pool generated successfully!');
  } else {
    print('✗ No referees found in league pool');
  }
  
  print('');
  print('=== Test Complete ===');
}
