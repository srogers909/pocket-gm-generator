import 'player.dart';
import 'staff.dart';
import 'stadium.dart';
import 'team_tier.dart';

/// Represents a football team with roster and attributes
class Team {
  final String name;
  final String abbreviation;
  final String primaryColor;
  final String secondaryColor;
  final List<Player> roster;
  final TeamStaff? staff;
  final Stadium stadium;
  final int fanHappiness; // 50-100 scale
  final String? conference;
  final String? division;
  final String? city;
  final TeamTier? tier;

  Team({
    required this.name,
    required this.abbreviation,
    required this.primaryColor,
    required this.secondaryColor,
    required this.roster,
    required this.stadium,
    required this.fanHappiness,
    this.staff,
    this.conference,
    this.division,
    this.city,
    this.tier,
  });

  /// Gets players by position
  List<Player> getPlayersByPosition(String position) {
    return roster.where((player) => player.primaryPosition == position).toList();
  }

  /// Gets the total roster size
  int get rosterSize => roster.length;

  /// Gets the starting lineup (best player at each position)
  List<Player> get startingLineup {
    final starters = <Player>[];
    
    // Get the best player at each position
    final positions = ['QB', 'RB', 'WR', 'TE', 'OL', 'DL', 'LB', 'CB', 'S', 'K'];
    
    for (final position in positions) {
      final playersAtPosition = getPlayersByPosition(position);
      if (playersAtPosition.isNotEmpty) {
        // Sort by overall rating and take the best
        playersAtPosition.sort((a, b) => b.overallRating.compareTo(a.overallRating));
        starters.add(playersAtPosition.first);
      }
    }
    
    return starters;
  }

  /// Gets the team's average overall rating
  double get averageOverallRating {
    if (roster.isEmpty) return 0.0;
    final totalRating = roster.fold<int>(0, (sum, player) => sum + player.overallRating);
    return totalRating / roster.length;
  }

  /// Gets the team's average morale from all players and staff
  double get teamMorale {
    if (roster.isEmpty) return 80.0; // Default morale if no roster
    
    double totalMorale = 0.0;
    int totalPeople = 0;
    
    // Add player morale
    for (final player in roster) {
      totalMorale += player.morale;
      totalPeople++;
    }
    
    // Add staff morale if staff exists
    if (staff != null) {
      for (final staffMember in staff!.allStaff) {
        totalMorale += staffMember.morale;
        totalPeople++;
      }
    }
    
    return totalPeople > 0 ? totalMorale / totalPeople : 80.0;
  }

  /// Gets the calculated tier based on the team's actual average rating
  TeamTier get calculatedTier {
    final rating = averageOverallRating;
    if (rating >= 85.0) return TeamTier.superBowlContender;
    if (rating >= 80.0) return TeamTier.playoffTeam;
    if (rating >= 76.0) return TeamTier.average;
    if (rating >= 71.0) return TeamTier.rebuilding;
    return TeamTier.bad;
  }

  /// Gets the tier to display (uses calculated tier if no tier was assigned)
  TeamTier get displayTier => tier ?? calculatedTier;

  /// Gets roster breakdown by position
  Map<String, int> get rosterBreakdown {
    final breakdown = <String, int>{};
    for (final player in roster) {
      breakdown[player.primaryPosition] = (breakdown[player.primaryPosition] ?? 0) + 1;
    }
    return breakdown;
  }

  @override
  String toString() {
    final buffer = StringBuffer();
    buffer.writeln('=== $name ($abbreviation) ===');
    buffer.writeln('Colors: $primaryColor / $secondaryColor');
    buffer.writeln('Stadium: ${stadium.name} (${stadium.location})');
    buffer.writeln('Fan Happiness: $fanHappiness');
    buffer.writeln('Team Morale: ${teamMorale.toStringAsFixed(1)}');
    buffer.writeln('Roster Size: $rosterSize players');
    buffer.writeln('Average Rating: ${averageOverallRating.toStringAsFixed(1)}');
    buffer.writeln('');
    buffer.writeln('Roster Breakdown:');
    
    final breakdown = rosterBreakdown;
    final sortedPositions = breakdown.keys.toList()..sort();
    
    for (final position in sortedPositions) {
      buffer.writeln('  $position: ${breakdown[position]} players');
    }
    
    buffer.writeln('');
    buffer.writeln('Starting Lineup:');
    
    for (final starter in startingLineup) {
      buffer.writeln('  ${starter.primaryPosition}: ${starter.commonName} (${starter.overallRating})');
    }
    
    return buffer.toString();
  }

  /// Returns a detailed roster string
  String get detailedRoster {
    final buffer = StringBuffer();
    buffer.writeln('=== $name Complete Roster ===');
    buffer.writeln('');
    
    // Group players by position
    final positionGroups = <String, List<Player>>{};
    for (final player in roster) {
      positionGroups.putIfAbsent(player.primaryPosition, () => <Player>[]);
      positionGroups[player.primaryPosition]!.add(player);
    }
    
    // Sort positions
    final sortedPositions = positionGroups.keys.toList()..sort();
    
    for (final position in sortedPositions) {
      final players = positionGroups[position]!;
      // Sort players by overall rating (best first)
      players.sort((a, b) => b.overallRating.compareTo(a.overallRating));
      
      buffer.writeln('$position (${players.length} players):');
      for (int i = 0; i < players.length; i++) {
        final player = players[i];
        final starter = i == 0 ? '★' : ' ';
        buffer.writeln('  $starter ${player.commonName} - Overall: ${player.overallRating} - ${player.heightInches}" ${player.weightLbs}lbs');
      }
      buffer.writeln('');
    }
    
    return buffer.toString();
  }
}
