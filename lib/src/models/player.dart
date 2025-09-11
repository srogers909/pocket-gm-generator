import 'positions.dart';

/// Represents a football player with all their personal and professional information
class Player {
  /// Full legal name (e.g., "Steven Christopher Rogers")
  final String fullName;
  
  /// Common name used in everyday situations (e.g., "Steve Rogers")
  final String commonName;
  
  /// Short version of name (e.g., "Steve")
  final String shortName;
  
  /// Fan-given nickname (e.g., "The Bruiser")
  final String? fanNickname;
  
  /// Primary football position (e.g., "QB", "RB", "WR")
  final String primaryPosition;
  
  /// Height in inches
  final int heightInches;
  
  /// Weight in pounds
  final int weightLbs;
  
  /// College name and graduation year (e.g., "University of Texas, Austin, 2001")
  final String college;
  
  /// Birth information with location, country flag, and age (e.g., "12/08/2001 (24 yrs) - USA 🇺🇸")
  final String birthInfo;
  
  /// Overall player rating (0-100)
  final int overallRating;
  
  /// Potential rating indicating future growth (0-100)
  final int potentialRating;
  
  /// Durability rating indicating injury resistance (0-100)
  final int durabilityRating;
  
  /// Football IQ rating indicating game knowledge (0-100)
  final int footballIqRating;
  
  /// Fan popularity rating (0-100)
  final int fanPopularity;
  
  /// Player morale rating (50-100)
  final int morale;
  
  /// Draft year when player was selected
  final int draftYear;
  
  /// Draft round (1-7, null if undrafted)
  final int? draftRound;
  
  /// Draft pick number within the round (1-32, null if undrafted)
  final int? draftPick;
  
  /// Formatted draft information string
  final String draftInfo;
  
  /// Position-specific rating 1 (0-100)
  final int positionRating1;
  
  /// Position-specific rating 2 (0-100)
  final int positionRating2;
  
  /// Position-specific rating 3 (0-100)
  final int positionRating3;
  
  /// Evasion rating indicating ability to avoid sacks and pressure (0-100)
  final int evasion;

  Player({
    required this.fullName,
    required this.commonName,
    required this.shortName,
    this.fanNickname,
    required this.primaryPosition,
    required this.heightInches,
    required this.weightLbs,
    required this.college,
    required this.birthInfo,
    required this.draftYear,
    this.draftRound,
    this.draftPick,
    required this.draftInfo,
    this.overallRating = 0,
    this.potentialRating = 0,
    this.durabilityRating = 0,
    this.footballIqRating = 0,
    this.fanPopularity = 0,
    this.morale = 80,
    this.positionRating1 = 0,
    this.positionRating2 = 0,
    this.positionRating3 = 0,
    this.evasion = 0,
  });

  /// Returns height in feet and inches format (e.g., "6'2\"")
  String get heightFormatted {
    final feet = heightInches ~/ 12;
    final inches = heightInches % 12;
    return "$feet'$inches\"";
  }

  /// Get position-specific attribute names for this player's position
  PositionAttributes? get positionAttributes {
    return getPositionAttributes(primaryPosition);
  }

  /// Get formatted position-specific ratings with attribute names
  String get formattedPositionRatings {
    final attributes = positionAttributes;
    if (attributes == null) {
      return 'Unknown Position: $positionRating1, $positionRating2, $positionRating3';
    }
    
    return '${attributes.attribute1}($positionRating1) ${attributes.attribute2}($positionRating2) ${attributes.attribute3}($positionRating3)';
  }

  /// Converts the player to JSON
  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'commonName': commonName,
      'shortName': shortName,
      'fanNickname': fanNickname,
      'primaryPosition': primaryPosition,
      'heightInches': heightInches,
      'weightLbs': weightLbs,
      'college': college,
      'birthInfo': birthInfo,
      'overallRating': overallRating,
      'potentialRating': potentialRating,
      'durabilityRating': durabilityRating,
      'footballIqRating': footballIqRating,
      'fanPopularity': fanPopularity,
      'morale': morale,
      'draftYear': draftYear,
      'draftRound': draftRound,
      'draftPick': draftPick,
      'draftInfo': draftInfo,
      'positionRating1': positionRating1,
      'positionRating2': positionRating2,
      'positionRating3': positionRating3,
      'evasion': evasion,
      'heightFormatted': heightFormatted,
      'formattedPositionRatings': formattedPositionRatings,
    };
  }

  /// Creates a player from JSON
  factory Player.fromJson(Map<String, dynamic> json) {
    return Player(
      fullName: json['fullName'] as String,
      commonName: json['commonName'] as String,
      shortName: json['shortName'] as String,
      fanNickname: json['fanNickname'] as String?,
      primaryPosition: json['primaryPosition'] as String,
      heightInches: json['heightInches'] as int,
      weightLbs: json['weightLbs'] as int,
      college: json['college'] as String,
      birthInfo: json['birthInfo'] as String,
      overallRating: json['overallRating'] as int,
      potentialRating: json['potentialRating'] as int,
      durabilityRating: json['durabilityRating'] as int,
      footballIqRating: json['footballIqRating'] as int,
      fanPopularity: json['fanPopularity'] as int,
      morale: json['morale'] as int,
      draftYear: json['draftYear'] as int,
      draftRound: json['draftRound'] as int?,
      draftPick: json['draftPick'] as int?,
      draftInfo: json['draftInfo'] as String,
      positionRating1: json['positionRating1'] as int,
      positionRating2: json['positionRating2'] as int,
      positionRating3: json['positionRating3'] as int,
      evasion: json['evasion'] as int,
    );
  }

  @override
  String toString() {
    return '''
Player: $fullName ($commonName)
Nickname: ${fanNickname != null ? '"$fanNickname"' : 'None'}
Position: $primaryPosition
Height: $heightFormatted ($heightInches inches)
Weight: $weightLbs lbs
College: $college
Born: $birthInfo
Ratings: Overall($overallRating) Potential($potentialRating) Durability($durabilityRating) IQ($footballIqRating) Popularity($fanPopularity) Morale($morale)
Position Ratings: $formattedPositionRatings
''';
  }
}
