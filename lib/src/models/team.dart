import 'player.dart';

/// Represents a football team with roster and attributes
class Team {
  final String name;
  final String abbreviation;
  final String primaryColor;
  final String secondaryColor;
  final List<Player> roster;
  final String? conference;
  final String? division;
  final String? city;

  Team({
    required this.name,
    required this.abbreviation,
    required this.primaryColor,
    required this.secondaryColor,
    required this.roster,
    this.conference,
    this.division,
    this.city,
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
