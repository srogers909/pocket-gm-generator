import 'package:pocket_gm_generator/pocket_gm_generator.dart';

void main() {
  print('=== Staff Generator Test ===\n');
  
  final staffGenerator = StaffGenerator();
  
  // Test each team tier
  for (final tier in TeamTier.values) {
    print('--- ${tier.displayName} Team Staff ---');
    print('Tier Description: ${tier.description}');
    print('Mean Rating: ${tier.meanRating}');
    print('');
    
    final staff = staffGenerator.generateTeamStaff(tier);
    
    // Display each staff member
    print('Head Coach:');
    _displayStaff(staff.headCoach);
    print('');
    
    print('Offensive Coordinator:');
    _displayStaff(staff.offensiveCoordinator);
    print('');
    
    print('Defensive Coordinator:');
    _displayStaff(staff.defensiveCoordinator);
    print('');
    
    print('Team Doctor:');
    _displayStaff(staff.teamDoctor);
    print('');
    
    print('Head Scout:');
    _displayStaff(staff.headScout);
    print('');
    
    print('=' * 50);
    print('');
  }
}

void _displayStaff(Staff staff) {
  print('  Name: ${staff.commonName}');
  print('  Age: ${staff.age}');
  print('  Experience: ${staff.yearsExperience} years');
  print('  Overall Rating: ${staff.overallRating}');
  print('  Morale: ${staff.morale}');
  
  if (staff is HeadCoach) {
    print('  Leadership: ${staff.leadership}');
    print('  Game Management: ${staff.gameManagement}');
    print('  Player Development: ${staff.playerDevelopment}');
    print('  Scheme Knowledge: ${staff.schemeKnowledge}');
  } else if (staff is OffensiveCoordinator) {
    print('  Play Calling: ${staff.playCalling}');
    print('  Passing Offense: ${staff.passingOffense}');
    print('  Rushing Offense: ${staff.rushingOffense}');
    print('  Offensive Line Expertise: ${staff.offensiveLineExpertise}');
  } else if (staff is DefensiveCoordinator) {
    print('  Defensive Play Calling: ${staff.defensivePlayCalling}');
    print('  Passing Defense: ${staff.passingDefense}');
    print('  Rushing Defense: ${staff.rushingDefense}');
    print('  Defensive Line Expertise: ${staff.defensiveLineExpertise}');
  } else if (staff is TeamDoctor) {
    print('  Injury Prevention: ${staff.injuryPrevention}');
    print('  Rehabilitation Speed: ${staff.rehabilitationSpeed}');
    print('  Misdiagnosis Prevention: ${staff.misdiagnosisPrevention}');
    print('  Stamina Recovery: ${staff.staminaRecovery}');
  } else if (staff is HeadScout) {
    print('  College Scouting: ${staff.collegeScouting}');
    print('  Pro Scouting: ${staff.proScouting}');
    print('  Potential Identification: ${staff.potentialIdentification}');
    print('  Trade Evaluation: ${staff.tradeEvaluation}');
  }
}
