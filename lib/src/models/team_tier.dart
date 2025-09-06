/// Enum defining different tiers of team quality for generating varied team strengths
enum TeamTier {
  superBowlContender,
  playoffTeam,
  average,
  rebuilding,
  bad,
}

/// Extension to provide tier-specific configuration
extension TeamTierConfig on TeamTier {
  /// Mean rating for players generated for this tier
  double get meanRating {
    switch (this) {
      case TeamTier.superBowlContender:
        return 85.0; // Elite teams with high-rated players
      case TeamTier.playoffTeam:
        return 80.0; // Above average teams
      case TeamTier.average:
        return 76.0; // Current baseline
      case TeamTier.rebuilding:
        return 71.0; // Below average teams
      case TeamTier.bad:
        return 66.0; // Poor teams with low-rated players
    }
  }

  /// Standard deviation for player ratings (wider spread for more variation)
  double get standardDeviation {
    switch (this) {
      case TeamTier.superBowlContender:
        return 7.0; // Tighter distribution - more consistent high talent
      case TeamTier.playoffTeam:
        return 8.0;
      case TeamTier.average:
        return 10.0; // Current baseline
      case TeamTier.rebuilding:
        return 8.0;
      case TeamTier.bad:
        return 7.0; // Tighter distribution - more consistent low talent
    }
  }

  /// Display name for the tier
  String get displayName {
    switch (this) {
      case TeamTier.superBowlContender:
        return 'Super Bowl Contender';
      case TeamTier.playoffTeam:
        return 'Playoff Team';
      case TeamTier.average:
        return 'Average';
      case TeamTier.rebuilding:
        return 'Rebuilding';
      case TeamTier.bad:
        return 'Bad';
    }
  }

  /// Description of the tier
  String get description {
    switch (this) {
      case TeamTier.superBowlContender:
        return 'Elite team with high-quality players across all positions';
      case TeamTier.playoffTeam:
        return 'Strong team with above-average talent';
      case TeamTier.average:
        return 'Typical NFL team with standard player quality';
      case TeamTier.rebuilding:
        return 'Team in transition with below-average talent';
      case TeamTier.bad:
        return 'Struggling team with poor player quality';
    }
  }
}
