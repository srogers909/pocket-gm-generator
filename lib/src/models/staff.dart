/// Container class for a complete team staff
class TeamStaff {
  final HeadCoach headCoach;
  final OffensiveCoordinator offensiveCoordinator;
  final DefensiveCoordinator defensiveCoordinator;
  final TeamDoctor teamDoctor;
  final HeadScout headScout;

  TeamStaff({
    required this.headCoach,
    required this.offensiveCoordinator,
    required this.defensiveCoordinator,
    required this.teamDoctor,
    required this.headScout,
  });

  /// Returns all staff members as a list
  List<Staff> get allStaff => [
    headCoach,
    offensiveCoordinator,
    defensiveCoordinator,
    teamDoctor,
    headScout,
  ];
}

/// Base class for all staff members
abstract class Staff {
  /// Full legal name (e.g., "Steven Christopher Rogers")
  final String fullName;
  
  /// Common name used in everyday situations (e.g., "Steve Rogers")
  final String commonName;
  
  /// Short version of name (e.g., "Steve")
  final String shortName;
  
  /// Age of the staff member
  final int age;
  
  /// Years of experience in coaching/staff roles
  final int yearsExperience;
  
  /// Overall rating for this staff member (0-100)
  final int overallRating;
  
  /// Staff morale rating (50-100)
  final int morale;

  Staff({
    required this.fullName,
    required this.commonName,
    required this.shortName,
    required this.age,
    required this.yearsExperience,
    required this.overallRating,
    required this.morale,
  });

  /// Returns the position title (implemented by subclasses)
  String get position;

  @override
  String toString() {
    return '''
$position: $fullName ($commonName)
Age: $age, Experience: $yearsExperience years
Overall Rating: $overallRating, Morale: $morale
''';
  }
}

/// Head Coach staff member
class HeadCoach extends Staff {
  /// Affects team morale, player discipline, and clutch performance
  final int leadership;
  
  /// Influences clock management, timeout usage, and challenge success
  final int gameManagement;
  
  /// Boosts player experience gain and development speed
  final int playerDevelopment;
  
  /// Determines how well the team's playbook is utilized
  final int schemeKnowledge;

  HeadCoach({
    required super.fullName,
    required super.commonName,
    required super.shortName,
    required super.age,
    required super.yearsExperience,
    required super.overallRating,
    required super.morale,
    required this.leadership,
    required this.gameManagement,
    required this.playerDevelopment,
    required this.schemeKnowledge,
  });

  @override
  String get position => 'Head Coach';

  @override
  String toString() {
    return '''
${super.toString()}Attributes: Leadership($leadership) Game Management($gameManagement) Player Development($playerDevelopment) Scheme Knowledge($schemeKnowledge)
''';
  }
}

/// Offensive Coordinator staff member
class OffensiveCoordinator extends Staff {
  /// Ability to call the right plays against various defensive schemes
  final int playCalling;
  
  /// Improves quarterback accuracy, receiver routes, and pass-blocking
  final int passingOffense;
  
  /// Enhances running back vision, run-blocking, and tackle breaking
  final int rushingOffense;
  
  /// Directly impacts offensive line performance
  final int offensiveLineExpertise;

  OffensiveCoordinator({
    required super.fullName,
    required super.commonName,
    required super.shortName,
    required super.age,
    required super.yearsExperience,
    required super.overallRating,
    required super.morale,
    required this.playCalling,
    required this.passingOffense,
    required this.rushingOffense,
    required this.offensiveLineExpertise,
  });

  @override
  String get position => 'Offensive Coordinator';

  @override
  String toString() {
    return '''
${super.toString()}Attributes: Play Calling($playCalling) Passing Offense($passingOffense) Rushing Offense($rushingOffense) OL Expertise($offensiveLineExpertise)
''';
  }
}

/// Defensive Coordinator staff member
class DefensiveCoordinator extends Staff {
  /// Ability to call the right plays to counter offensive schemes
  final int defensivePlayCalling;
  
  /// Improves defensive back coverage and pass rush effectiveness
  final int passingDefense;
  
  /// Enhances front seven ability to stop the run
  final int rushingDefense;
  
  /// Directly impacts defensive line performance
  final int defensiveLineExpertise;

  DefensiveCoordinator({
    required super.fullName,
    required super.commonName,
    required super.shortName,
    required super.age,
    required super.yearsExperience,
    required super.overallRating,
    required super.morale,
    required this.defensivePlayCalling,
    required this.passingDefense,
    required this.rushingDefense,
    required this.defensiveLineExpertise,
  });

  @override
  String get position => 'Defensive Coordinator';

  @override
  String toString() {
    return '''
${super.toString()}Attributes: Defensive Play Calling($defensivePlayCalling) Passing Defense($passingDefense) Rushing Defense($rushingDefense) DL Expertise($defensiveLineExpertise)
''';
  }
}

/// Team Doctor staff member
class TeamDoctor extends Staff {
  /// Reduces the likelihood of players getting injured
  final int injuryPrevention;
  
  /// Decreases time for injured players to recover
  final int rehabilitationSpeed;
  
  /// Lowers chance of misdiagnosing injuries
  final int misdiagnosisPrevention;
  
  /// Improves player stamina recovery rate
  final int staminaRecovery;

  TeamDoctor({
    required super.fullName,
    required super.commonName,
    required super.shortName,
    required super.age,
    required super.yearsExperience,
    required super.overallRating,
    required super.morale,
    required this.injuryPrevention,
    required this.rehabilitationSpeed,
    required this.misdiagnosisPrevention,
    required this.staminaRecovery,
  });

  @override
  String get position => 'Team Doctor';

  @override
  String toString() {
    return '''
${super.toString()}Attributes: Injury Prevention($injuryPrevention) Rehabilitation Speed($rehabilitationSpeed) Misdiagnosis Prevention($misdiagnosisPrevention) Stamina Recovery($staminaRecovery)
''';
  }
}

/// Head Scout staff member
class HeadScout extends Staff {
  /// Increases accuracy of scouting reports on college players
  final int collegeScouting;
  
  /// Provides more accurate assessments of players on other teams
  final int proScouting;
  
  /// Ability to identify high-potential players
  final int potentialIdentification;
  
  /// Improves logic for evaluating trade offers
  final int tradeEvaluation;

  HeadScout({
    required super.fullName,
    required super.commonName,
    required super.shortName,
    required super.age,
    required super.yearsExperience,
    required super.overallRating,
    required super.morale,
    required this.collegeScouting,
    required this.proScouting,
    required this.potentialIdentification,
    required this.tradeEvaluation,
  });

  @override
  String get position => 'Head Scout';

  @override
  String toString() {
    return '''
${super.toString()}Attributes: College Scouting($collegeScouting) Pro Scouting($proScouting) Potential ID($potentialIdentification) Trade Evaluation($tradeEvaluation)
''';
  }
}
