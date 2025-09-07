import 'package:pocket_gm_generator/pocket_gm_generator.dart';

void main() {
  print('=== Testing Referee Generator ===\n');
  
  // Test generating a single referee
  print('Testing single referee generation:');
  final singleReferee = RefereeGenerator.generateReferee();
  print('Generated referee: ${singleReferee.name}');
  print('  Year hired: ${singleReferee.yearHired}');
  print('  Year retired: ${singleReferee.yearRetired ?? "Still active"}');
  print('  Years of experience: ${singleReferee.yearsOfExperience}');
  print('  Is active: ${singleReferee.isActive}');
  print('  Sample penalty tendencies:');
  print('    Holding: ${singleReferee.holdingTendency}');
  print('    Pass Interference: ${singleReferee.passInterferenceTendency}');
  print('    Roughing the Passer: ${singleReferee.roughingThePasserTendency}');
  print('    False Start: ${singleReferee.falseStartTendency}');
  print('');
  
  // Test generating a pool of 20 referees
  print('Testing referee pool generation (20 referees):');
  final refereePool = RefereeGenerator.generateRefereePool(count: 20);
  
  print('Generated ${refereePool.length} referees:');
  print('');
  
  // Display details of first 5 referees
  print('Details of first 5 referees:');
  for (int i = 0; i < 5 && i < refereePool.length; i++) {
    final referee = refereePool[i];
    print('${i + 1}. ${referee.name}');
    print('   Hired: ${referee.yearHired}, Retired: ${referee.yearRetired ?? "Active"}');
    print('   Experience: ${referee.yearsOfExperience} years');
    print('   Penalty Tendencies (1-100):');
    print('     Holding: ${referee.holdingTendency}');
    print('     Pass Interference: ${referee.passInterferenceTendency}');
    print('     Roughing Passer: ${referee.roughingThePasserTendency}');
    print('     False Start: ${referee.falseStartTendency}');
    print('     Personal Foul: ${referee.personalFoulTendency}');
    print('     Unnecessary Roughness: ${referee.unnecessaryRoughnessTendency}');
    print('');
  }
  
  // Check for unique names
  final names = refereePool.map((ref) => ref.name).toSet();
  print('Uniqueness check: ${names.length} unique names out of ${refereePool.length} referees');
  if (names.length == refereePool.length) {
    print('✓ All referee names are unique');
  } else {
    print('✗ Found ${refereePool.length - names.length} duplicate names');
  }
  print('');
  
  // Analyze distribution of active vs retired referees
  final activeReferees = refereePool.where((ref) => ref.isActive).length;
  final retiredReferees = refereePool.length - activeReferees;
  print('Activity status distribution:');
  print('  Active referees: $activeReferees (${(activeReferees / refereePool.length * 100).toStringAsFixed(1)}%)');
  print('  Retired referees: $retiredReferees (${(retiredReferees / refereePool.length * 100).toStringAsFixed(1)}%)');
  print('');
  
  // Analyze penalty tendency ranges
  print('Penalty tendency analysis:');
  final allHoldingTendencies = refereePool.map((ref) => ref.holdingTendency).toList();
  allHoldingTendencies.sort();
  final minHolding = allHoldingTendencies.first;
  final maxHolding = allHoldingTendencies.last;
  final avgHolding = allHoldingTendencies.reduce((a, b) => a + b) / allHoldingTendencies.length;
  
  print('  Holding tendency range: $minHolding - $maxHolding (avg: ${avgHolding.toStringAsFixed(1)})');
  
  // Test that all penalty tendencies are within valid range (1-100)
  bool allTendenciesValid = true;
  for (final referee in refereePool) {
    final tendencies = referee.penaltyTendencies.values;
    for (final tendency in tendencies) {
      if (tendency < 1 || tendency > 100) {
        allTendenciesValid = false;
        break;
      }
    }
    if (!allTendenciesValid) break;
  }
  
  if (allTendenciesValid) {
    print('✓ All penalty tendencies are within valid range (1-100)');
  } else {
    print('✗ Some penalty tendencies are outside valid range');
  }
  
  print('');
  print('=== Referee Generator Test Complete ===');
}
