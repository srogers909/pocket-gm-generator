class Referee {
  final String name;
  final int yearHired;
  final int? yearRetired;
  final int holdingTendency;
  final int passInterferenceTendency;
  final int roughingThePasserTendency;
  final int falseStartTendency;
  final int offensiveHoldingTendency;
  final int defensivePassInterferenceTendency;
  final int unnecessaryRoughnessTendency;
  final int personalFoulTendency;
  final int delayOfGameTendency;
  final int illegalFormationTendency;
  final int facemaskTendency;
  final int clippingTendency;

  const Referee({
    required this.name,
    required this.yearHired,
    this.yearRetired,
    required this.holdingTendency,
    required this.passInterferenceTendency,
    required this.roughingThePasserTendency,
    required this.falseStartTendency,
    required this.offensiveHoldingTendency,
    required this.defensivePassInterferenceTendency,
    required this.unnecessaryRoughnessTendency,
    required this.personalFoulTendency,
    required this.delayOfGameTendency,
    required this.illegalFormationTendency,
    required this.facemaskTendency,
    required this.clippingTendency,
  });

  /// Returns true if the referee is currently active (not retired)
  bool get isActive => yearRetired == null;

  /// Returns the referee's years of experience based on current year (2024)
  int get yearsOfExperience {
    final currentYear = 2024;
    final endYear = yearRetired ?? currentYear;
    return endYear - yearHired;
  }

  /// Returns a map of all penalty tendencies for easy access
  Map<String, int> get penaltyTendencies => {
    'holding': holdingTendency,
    'passInterference': passInterferenceTendency,
    'roughingThePasser': roughingThePasserTendency,
    'falseStart': falseStartTendency,
    'offensiveHolding': offensiveHoldingTendency,
    'defensivePassInterference': defensivePassInterferenceTendency,
    'unnecessaryRoughness': unnecessaryRoughnessTendency,
    'personalFoul': personalFoulTendency,
    'delayOfGame': delayOfGameTendency,
    'illegalFormation': illegalFormationTendency,
    'facemask': facemaskTendency,
    'clipping': clippingTendency,
  };

  /// Converts the Referee to a JSON representation
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'yearHired': yearHired,
      'yearRetired': yearRetired,
      'holdingTendency': holdingTendency,
      'passInterferenceTendency': passInterferenceTendency,
      'roughingThePasserTendency': roughingThePasserTendency,
      'falseStartTendency': falseStartTendency,
      'offensiveHoldingTendency': offensiveHoldingTendency,
      'defensivePassInterferenceTendency': defensivePassInterferenceTendency,
      'unnecessaryRoughnessTendency': unnecessaryRoughnessTendency,
      'personalFoulTendency': personalFoulTendency,
      'delayOfGameTendency': delayOfGameTendency,
      'illegalFormationTendency': illegalFormationTendency,
      'facemaskTendency': facemaskTendency,
      'clippingTendency': clippingTendency,
      // Computed properties
      'isActive': isActive,
      'yearsOfExperience': yearsOfExperience,
      'penaltyTendencies': penaltyTendencies,
    };
  }

  /// Creates a Referee from a JSON representation
  factory Referee.fromJson(Map<String, dynamic> json) {
    return Referee(
      name: json['name'] as String,
      yearHired: json['yearHired'] as int,
      yearRetired: json['yearRetired'] as int?,
      holdingTendency: json['holdingTendency'] as int,
      passInterferenceTendency: json['passInterferenceTendency'] as int,
      roughingThePasserTendency: json['roughingThePasserTendency'] as int,
      falseStartTendency: json['falseStartTendency'] as int,
      offensiveHoldingTendency: json['offensiveHoldingTendency'] as int,
      defensivePassInterferenceTendency: json['defensivePassInterferenceTendency'] as int,
      unnecessaryRoughnessTendency: json['unnecessaryRoughnessTendency'] as int,
      personalFoulTendency: json['personalFoulTendency'] as int,
      delayOfGameTendency: json['delayOfGameTendency'] as int,
      illegalFormationTendency: json['illegalFormationTendency'] as int,
      facemaskTendency: json['facemaskTendency'] as int,
      clippingTendency: json['clippingTendency'] as int,
    );
  }

  @override
  String toString() {
    return 'Referee(name: $name, yearHired: $yearHired, yearRetired: $yearRetired, '
           'yearsOfExperience: $yearsOfExperience, isActive: $isActive)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Referee &&
        other.name == name &&
        other.yearHired == yearHired &&
        other.yearRetired == yearRetired;
  }

  @override
  int get hashCode {
    return Object.hash(name, yearHired, yearRetired);
  }
}
