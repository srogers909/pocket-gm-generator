import 'lib/src/models/staff.dart';
import 'lib/src/models/team_tier.dart';
import 'lib/src/services/staff_generator.dart';

void main() {
  print('=== Single Team Staff Test ===\n');
  
  final staffGenerator = StaffGenerator();
  
  // Test with a specific tier (change this to test different tiers)
  const tier = TeamTier.superBowlContender;
  
  print('Generating staff for: ${tier.displayName}');
  print('Expected Mean Rating: ${tier.meanRating}');
  print('Standard Deviation: ${tier.standardDeviation}');
  print('');
  
  final staff = staffGenerator.generateTeamStaff(tier);
  
  // Display each staff member
  for (final staffMember in staff.allStaff) {
    print('${staffMember.position}:');
    print('  Name: ${staffMember.commonName}');
    print('  Age: ${staffMember.age}');
    print('  Experience: ${staffMember.yearsExperience} years');
    print('  Overall Rating: ${staffMember.overallRating}');
    _displayStaffAttributes(staffMember);
    print('');
  }
}

void _displayStaffAttributes(Staff staff) {
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
